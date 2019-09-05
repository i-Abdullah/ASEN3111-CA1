function [ int ] = TrapezoidalRule(f,a,b,N)
% This function will perform numerical line integration using 
% Trapezoidal rule, the user will pass in the interval of integration
% and also the number of segments (panels). the code
% will return the result of the definite integral.
% 
% - - - - - - - - - - - - - - - - - - - - - - - - - -
%
%       Inputs:
%               1- f: function of integration, entered as splines functions
%               2- a: Lower bound of integration
%               3- b: Upper bound of integration
%               4- N: number of segments (panels)
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

x = linspace(a,b,N); % create segments that we will integrate along
y = fnval(f, x); % evaluate the function along that segment

% apply integration
int = 0;

for k = 1:N
    
    series = ( x(k+1) - x(k) ) * (y(k+1) + y(k))/2 ;
    
    int = int + series; % store results.
    
    series = []; % empty place-holder.
    
end


    
    

end