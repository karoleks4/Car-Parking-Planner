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

:- ['domain-task33.pl'].		% Replace with the domain for this problem



% --- Definition of the initial state ---------------------------------

connected(p,pl).
connected(pl,p).
connected(pl,d).
connected(d,pl).
corespond(keyA,carA).
corespond(keyB,carB).
free(0,s0).

key(keyA).
key(keyB).
box(keyA,s0).
stored(keyB,s0).

at(carA,d,s0).

at(carB,pl,s0).
parked(carB,s0).
dirty(carB,s0).

at(agent,pl,s0).

% --- Goal condition that the planner will try to reach ---------------

goal(S) :-  delivered(carB,S) , parked(carA,S).			




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
