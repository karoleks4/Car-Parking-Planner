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

:- multifile at/3 , parked/2 , delivered/2 , grabed/2, stored/2, dirty/2, free/2, box/2.


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
primitive_action( collect(agent,_) ).

% --- Precondition for primitive actions ------------------------------
% describe when an action can be carried out, in a generic situation S
%

 poss( move(agent,From,To), S ) :- 
   at(agent,From,S),
   connected(From,To).

 poss( drive(agent,Car,From,To), S ) :- 
  at(agent,From,S),
  at(Car,From,S),
  connected(From,To),
  not(delivered(Car,S)),
  corespond(Key,Car),
  grabed(Key,S),
  not(dirty(Car,S)),
  not(Car = agent).

poss( grab(agent,Key), S ) :- 
  at(agent,pl,S),
  stored(Key,S),
  key(Key),
  not(grabed(_,S)).

poss( store(agent,Key), S ) :- 
  at(agent,pl,S),
  parked(Car,S),
  corespond(Key,Car),
  key(Key),
  not(stored(Key,S)),
  grabed(Key,S).

poss( park(agent,Car), S ) :- 
  at(agent,pl,S),
  at(Car,pl,S),
  not(Car = agent),
  corespond(Key,Car),
  grabed(Key,S),
  free(X,S),
  X > 0,
  not(parked(Car,S)).

poss( deliver(agent,Car), S ) :- 
  at(agent,p,S),
  at(Car,p,S),
  not(Car = agent),
  corespond(Key,Car),
  grabed(Key,S),
  not(delivered(Car,S)).

poss( clean(agent,Car), S ) :- 
  at(agent,pl,S),
  at(Car,pl,S),
  not(Car = agent),
  parked(Car,S),
  dirty(Car,S).

% preconditions for a new action indicating that the agent grabes a key stored in the box in the drop-off area when a car is droped-off
poss( collect(agent,Key), S ) :- 
  at(agent,d,S),
  box(Key,S),
  key(Key),
  not(grabed(_,S)).

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
    at(What, Where, S)  , not(A = move(agent,Where,_)) , not(A = drive(agent,Car,Where,_)) , key(What).


grabed(Key, result(A, S)) :-
    A = grab(agent,Key); 
    A = collect(agent,Key);
    grabed(Key,S) , not(A = store(agent,Key)) , not(A = deliver(agent,Car)).

parked(Car, result(A, S)) :-
    A = park(agent,Car);
    parked(Car, S), not(A = drive(agent,Car,pl,_)). 

delivered(Car, result(A, S)) :-
   A = deliver(agent,Car);
   delivered(Car, S), not(A = drive(agent,Car,p,pl)).

stored(Key, result(A, S)) :-
    A = store(agent, Key);
    stored(Key,S) , not(A = grab(agent,Key)).

% new fluent indicating the number of free parking spaces
free(X, result(A, S)) :-
   (A = park(agent,Car) , X = Y - 1, free(Y,S));
   (A = drive(agent,Car,pl,_) , parked(Car,S) , X = Y + 1, free(Y,S)); 
   free(X, S), not(A = park(agent,Car)) , not(A = drive(agent,Car,pl,_)).

% new fluent indicationg that a key is stored in the box in the drop-off area (when the car is droped-off)
box(Key, result(A, S)) :-
    box(Key,S) , not(A = collect(agent,Key)).

dirty(Car, result(A, S)) :-
   A = park(agent,Car);
   dirty(Car, S), not(A = clean(agent,Car)).



% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
