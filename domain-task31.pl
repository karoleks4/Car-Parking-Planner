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

:- multifile at/3 , parked/2 , delivered/2, dirty/2.


% --- Primitive control actions ---------------------------------------
% this section defines the name and the number of parameters of the
% actions available to the planner
%

primitive_action( move(agent,_,_) ).
primitive_action( park(agent,Car) ).
primitive_action( drive(agent,Car,_,_) ).
primitive_action( deliver(agent,Car) ). 
primitive_action( clean(agent,Car) ).

% --- Precondition for primitive actions ------------------------------
% describe when an action can be carried out, in a generic situation S
%

 poss( move(agent,From,To), S ) :- 
	 at(agent,From,S),
	 connected(From,To).

poss( park(agent,Car), S ) :- 
	at(agent,pl,S),
	at(Car,pl,S),
  not(Car = agent),
	not(parked(Car,S)).

 poss( drive(agent,Car,From,To), S ) :- 
	 at(agent,From,S),
	 at(Car,From,S),
	 connected(From,To),
	 not(delivered(Car,S)),
	 not(dirty(Car,S)),
    not(Car = agent).

poss( deliver(agent,Car), S ) :- 
  at(agent,p,S),
  at(Car,p,S),
  not(Car = agent),
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
    A = move(What,_,Where) ;
    A = drive(agent,What,_,Where);
    A = drive(What,_,_,Where); 
    at(What, Where, S), What = agent, not(A = move(What,Where,_)) , (not(A = drive(What,_,Where,_)));
    at(What, Where, S), not(What = agent) , (not(A = drive(agent,What,Where,_))).

parked(Car, result(A, S)) :-
  	A = park(agent,Car);
  	parked(Car, S), dirty(Car,S), not(A = drive(agent,Car,pl,_)).

delivered(Car, result(A, S)) :-
   A = deliver(agent,Car);
   delivered(Car, S), not(A = drive(agent,Car,p,pl)).

% fluent dirty indicates which car needs to be cleaned
dirty(Car, result(A, S)) :-
   A = park(agent,Car);
   dirty(Car, S), not(A = clean(agent,Car)).


% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
