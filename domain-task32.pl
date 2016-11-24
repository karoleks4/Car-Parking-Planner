% ---------------------------------------------------------------------
%  ----- Informatics 2D - 2015/16 - Second Assignment - Planning -----
% ---------------------------------------------------------------------
%
% Write here you matriculation number (only - your name is not needed)
% Matriculation Number: s1448320
%
%
% ------------------------- Domain Definition -------------------------
% This file describes a planning domain: a set of predicates and
% fluents that describe the state of the system, a set of actions and
% the axioms related to them. More than one problem can use the same
% domain definition, and therefore include this file


% --- Cross-file definitions ------------------------------------------
% marks the predicates whose definition is spread across two or more
% files

:- multifile at/3 , parked/2 , delivered/2 , grabed/2, stored/2, dirty/2.


% --- Primitive control actions ---------------------------------------
% this section defines the name and the number of parameters of the
% actions available to the planner
%

primitive_action( move(agent,_,_) ).
primitive_action( drive(agent,_,_,_) ).
primitive_action( grab(agent,_) ).
primitive_action( store(agent,_) ).
primitive_action( park(agent,_) ).
primitive_action( deliver(agent,_) ).
primitive_action( clean(agent,_) ).

% --- Precondition for primitive actions ------------------------------
% describe when an action can be carried out, in a generic situation S
%

 poss( move(agent,From,To), S ) :- 
   at(agent,From,S),
   connected(From,To).
   % not(From = To).

 poss( drive(agent,Car,From,To), S ) :- 
  at(agent,From,S),
  at(Car,From,S),
  connected(From,To),
  not(delivered(Car,S)),
  corespond(Key,Car),
  grabed(Key,S),
  not(dirty(Car,S)),
  not(Car = agent).

% preconditions for the new action grab which describes when the agent can grab a key from the parking lot
poss( grab(agent,Key), S ) :- 
  at(agent,pl,S),
  % at(Key,pl,S),
  % not(Key = agent),
  stored(Key,S),
  key(Key),
  not(grabed(_,S)).

% preconditions for the new action store which describes when the agent can store a key in the parking lot
poss( store(agent,Key), S ) :- 
  at(agent,pl,S),
  parked(Car,S),
  key(Key),
  not(stored(Key,S)),
  grabed(Key,S).

poss( park(agent,Car), S ) :- 
  at(agent,pl,S),
  at(Car,pl,S),
  not(Car = agent),
  corespond(Key,Car),
  grabed(Key,S),
  not(parked(Car,S)).

poss( deliver(agent,Car), S ) :- 
  at(agent,p,S),
  at(Car,p,S),
  not(Car = agent),
  corespond(Key,Car),
  grabed(Key,S),
  not(delivered(Car,S)).

% preconditions of the new action clean. it is possible to clean the car only when its parked
poss( clean(agent,Car), S ) :- 
  at(agent,pl,S),
  at(Car,pl,S),
  not(Car = agent),
  parked(Car,S),
  dirty(Car,S).

% --- Successor state axioms ------------------------------------------
% describe the value of fluent based on the previous situation and the
% action chosen for the plan. 
%

at(What, Where, result(A, S)) :-
    A = move(What,_,Where) , What = agent;
    A = move(agent,_,Where) , grabed(What,S) , not(stored(Key,S));
    A = drive(agent,What,_,Where) , not(key(What));
    A = drive(What,_,_,Where) , What = agent;
    A = drive(agent,Car,_,Where) , grabed(What,S) , not(What = Car); 
    at(What, Where, S), What = agent, not(A = move(What,Where,_)) , not(A = drive(What,_,Where,_));
    at(What, Where, S), not(What = agent) , not(key(What)) , not(A = drive(agent,What,Where,_));
    at(What, Where, S) , not(What = agent) , not(A = move(agent,Where,_)) , not(A = drive(agent,Car,Where,_)) , not(What = Car).

% fluent grabed indicates which key is holded by the agent 
grabed(Key, result(A, S)) :-
    A = grab(agent,Key);
    grabed(Key,S) , not(A = store(agent,Key)).

parked(Car, result(A, S)) :-
    A = park(agent,Car);
    parked(Car, S), not(A = drive(agent,Car,pl,_)).

delivered(Car, result(A, S)) :-
   A = deliver(agent,Car);
   delivered(Car, S), not(A = drive(agent,Car,p,pl)).

% fluent stored indicates which key is stored in the parking lot
stored(Key, result(A, S)) :-
    A = store(agent, Key);
    stored(Key,S) , not(A = grab(agent,Key)).

% fluent dirty indicates which car needs to be cleaned
dirty(Car, result(A, S)) :-
   A = park(agent,Car);
   dirty(Car, S), not(A = clean(agent,Car)).


% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
