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

:- ['domain-task21.pl'].		% Replace with the domain for this problem




% --- Definition of the initial state ---------------------------------

connected(p,pl).
connected(pl,p).
connected(pl,d).
connected(d,pl).

parked(carA,s0).

at(carA,pl,s0).
at(carB,d,s0).
at(agent,d,s0).

% --- Goal condition that the planner will try to reach ---------------

goal(S) :-	parked(carB,S) , delivered(carA,S) , at(agent,d,S).				% fill in the goal definition




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
