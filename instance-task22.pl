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
connected(pl,d).

at(agent,p,s0).

% --- Goal condition that the planner will try to reach ---------------

goal(S) :-	at(agent,d,S).				% fill in the goal definition




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
