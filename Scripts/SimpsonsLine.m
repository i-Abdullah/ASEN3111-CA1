function [ int ] = SimpsonsLine(f,N,a,b)
% This function will perform numerical line integration using 
% composite simpsons rule, the user will pass in parameterized
% vector field function f, and number of segments (panels) the code
% will return the result of the definite integral.
% 
% - - - - - - - - - - - - - - - - - - - - - - - - - -
%
%       Inputs:
%               1- f: parameterized vector field function
%               2- N: number of segments (panels)
%               3- a: Lower bound of integration
%               4- b: Upper bound of integration
%
% - - - - - - - - - - - - - - - - - - - - - - - - - -
%
%       Outputs: 
%               1- int: result of definite integral
% - - - - - - - - - - - - - - - - - - - - - - - - - -
%
%
%
%   -Abdulla AlAmeri
%   -CU Boulder, Fall 2019, ASEN 3111.

% define h:

h = ( b - a ) / ( 2*N ) ; 
h = 2*pi / N;

% intiate results
int = 0;

for k = 1:(N/2);
    
    x1 = a + ( (2*k -1) -1 ) * h;
    x2 = a + ( (2*k) -1 ) * h;
    x3 = a + ( (2*k +1) -1 ) * h;
    % calculate this itteration of the series
    series = subs(f,x1) + ...
        4*subs(f,x2) + ...
        subs(f,x3) ;
    
    % add new results to previous results
    int = int + series ;


end


% now multiply by the constants outside the series.
int = (h/3) * 0.5 * int ;
int = double(int);

