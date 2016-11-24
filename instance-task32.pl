% ---------------------------------------------------------------------
%  ----- Informatics 2D - 2015/16 - Second Assignment - Planning -----
% ---------------------------------------------------------------------
%
% Write here you matriculation number (only - your name is not needed)
% Matriculation Number: s1448320
%
%
% ------------------------- Problem Instance --------------------------
% This file is a template for a problem instance: the definition of an
% initial state and of a goal. 

% debug(on).	% need additional debug information at runtime?



% --- Load domain definitions from an external file -------------------

:- ['domain-task32.pl'].		% Replace with the domain for this problem




% --- Definition of the initial state ---------------------------------

connected(p,pl).
connected(pl,p).
connected(pl,d).
connected(d,pl).
corespond(keyA,carA). % this predicate describes which key corresponds o which car
corespond(keyB,carB).

key(keyA). % this predicate describes that the object is a key
key(keyB).
stored(keyA,s0).
grabed(keyB,s0).

at(carA,pl,s0).
parked(carA,s0).
dirty(carA,s0).

at(carB,d,s0).

at(agent,d,s0).

% --- Goal condition that the planner will try to reach ---------------

goal(S) :-	stored(keyB,S) , parked(carB,S) , delivered(carA,S).				% fill in the goal definition




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
