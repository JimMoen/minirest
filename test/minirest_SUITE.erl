%%--------------------------------------------------------------------
%% Copyright (c) 2020-2021 EMQ Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%--------------------------------------------------------------------

-module(minirest_SUITE).

-compile(export_all).
-compile(nowarn_export_all).

-define(PORT, 8088).

-include_lib("eunit/include/eunit.hrl").

init_per_suite(C) ->C.

end_per_suite(C) -> C.

all() ->
    [
        % t_find_app_api
    ].

% t_find_app_api(_) ->
%     application:ensure_all_started(test_server),
%     Apps = [test_server],
%     Modules = minirest_api:find_api_modules(Apps),
%     ?assertEqual(Modules, [echo_api]).

t_simple_api() ->
    application:ensure_all_started(minirest),
    Modules = [example_hello_api],
    RanchOptions = [{port, ?PORT}],
    MinirestOptions = #{modules => Modules},
    {ok, _} = minirest:start(?MODULE, RanchOptions, MinirestOptions).

