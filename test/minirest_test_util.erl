-module(minirest_test_util).

-compile(export_all).
-compile(nowarn_export_all).

request(Method, Url) ->
    request(Method, Url, [], {}, []).

request(Method, Url, Auth) ->
    request(Method, Url, [], Auth, []).

request(Method, Url, QueryParams, Auth) ->
    request(Method, Url, QueryParams, Auth, []).

request(Method, Url, QueryParams, Auth, [])
    when (Method =:= options) orelse
    (Method =:= get) orelse
    (Method =:= put) orelse
    (Method =:= head) orelse
    (Method =:= delete) orelse
    (Method =:= trace) ->
    NewUrl = case QueryParams of
                 "" -> Url;
                 _ -> Url ++ "?" ++ QueryParams
             end,
    do_request_api(Method, {NewUrl, [Auth]});
request(Method, Url, QueryParams, Auth, Body)
    when (Method =:= post) orelse
    (Method =:= patch) orelse
    (Method =:= put) orelse
    (Method =:= delete) ->
    NewUrl = case QueryParams of
                 "" -> Url;
                 _ -> Url ++ "?" ++ QueryParams
             end,
    do_request_api(Method, {NewUrl, [Auth], "application/json", jsx:encode(Body)}).

do_request_api(Method, Request)->
    ct:pal("Method: ~p, Request: ~p", [Method, Request]),
    case httpc:request(Method, Request, [], []) of
        {error, socket_closed_remotely} ->
            {error, socket_closed_remotely};
        {ok, {{"HTTP/1.1", Code, _}, _, Return} }
            when Code >= 200 andalso Code < 300 ->
            {ok, Return};
        {ok, {Reason, _, _}} ->
            {error, Reason}
    end.
