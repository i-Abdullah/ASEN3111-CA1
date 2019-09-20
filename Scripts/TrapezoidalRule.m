function [ int ] = TrapezoidalRule(x,y,a,b,N,mode,Dy)
% This function will perform numerical line integration using 
% Trapezoidal rule, the user will pass in the interval of integration
% and also the number of segments (panels). the code
% will return the result of the definite integral.
% 
% - - - - - - - - - - - - - - - - - - - - - - - - - -
%
%       Inputs:
%               1- x: x interval you integrating alogn
%               2- y: corresponding y results to that x interval
%               3- a: Lower bound of integration
%               4- b: Upper bound of integration
%               5- N: number of segments (panels)
%               6- mode: this mode is specifcally designed for this problem,
%                         based on if we integrating for Cn or Ca
%               7- Dy =  y height of airfoil evaluated at each point, used
%               only when mode == Ca
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



% this's just to test numerical integration with symbolic function
% y = subs(f, x);
% ommit if not used


% apply integration
int = 0;
v = 1; % counting


% if we integrating for coefficient of normal force

if mode == "Cn" || mode == "cn"
    
for k = 1:(N-1)
    
    series = ( x(k+1) - x(k) ) * (y(k+1) + y(k))/2 ;
    
    int(v) = series; % store results.
    
    v = v+1;
end


elseif mode == "Ca" || mode == "ca"
    
for k = 1:(N-1)
    
    series = (( x(k+1) - x(k) ) * (y(k+1) + y(k))/2) * (-( Dy(k) - Dy(k+1) ) / ( x(k+1) - x(k) )) ;
    
    int(v) = series; % store results.
    
    v = v+1;
    
end

    
end


int = sum(int);

    
    

end