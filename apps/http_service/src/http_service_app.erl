%%%-------------------------------------------------------------------
%% @doc http_service public API
%% @end
%%%-------------------------------------------------------------------

-module(http_service_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
                                      {'_', get_paths()}
                                     ]),
    {ok, _} = cowboy:start_clear(my_http_listener,
                                 [{port, 8080}],
                                 #{env => #{dispatch => Dispatch}}
                                ),

    http_service_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
get_paths() ->
    lists:flatten([Service:paths()|| Service <- application:get_env(http_service, services, [rest_demo_service])]).
