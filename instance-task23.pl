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

connected(pl,p).
connected(p,pl).
connected(pl,d).
connected(d,pl).

at(carA,pl,s0).
at(agent,pl,s0).

% --- Goal condition that the planner will try to reach ---------------

goal(S) :-	at(agent,d,S) , parked(carA,S).			% fill in the goal definition




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
