%%%-------------------------------------------------------------------
%% @doc demo service public API
%% @end
%%%-------------------------------------------------------------------
-module(rest_demo_service).

-export([paths/0]).

paths() ->
    [{"/", hello_handler, []}].