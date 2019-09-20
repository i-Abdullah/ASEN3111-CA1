%% ASEN 3111 - Computational Assignment 1 - Main
%{

This is the main script to answer the deliverables for Computational
Assignment 1 (CA 1), you can find the deliverables in the folder /info.

This script will use other routines in the folder Scripts/


Author: Abdulla Al Ameri 
Collaborators: Brendan Palmer, Abdullah Almugairin, Samuel D'Souza
Date: Sept, 2nd, 2019.

%}

%% house keeping


clear
clc
close all

%% add scripts folder to path

% the ./ means all paths up to the current folder that contains Main.m,
% then in this path there's a folder called Scripts, add that to us.


addpath('./Scripts');

%% question 1:
% call scripts related to question 1

run('Q1.m');


%% question 2:
% call scripts related to question 2

run('Q2.m');


%% functions used
%
%
% <include>Q1.m</include>
%% functions used
%
%
% <include>CompositeSimpsons.m</include>
%% functions used
%
%
% <include>Q2.m</include>
%% functions used
%
%
% <include>TrapezoidalRule.m</include>