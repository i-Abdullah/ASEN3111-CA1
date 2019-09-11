%% ASEN 3111 - Computational Assignment 1 - Main
%{

This is the main script to answer the deliverables for Computational
Assignment 1 (CA 1), you can find the deliverables in the folder /info.

This script will use other routines in the folder Scripts/


Author: Abdulla Al Ameri
Collaborators:
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

%%