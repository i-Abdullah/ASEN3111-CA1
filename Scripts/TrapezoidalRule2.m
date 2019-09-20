function [ Cn Ca ] = TrapezoidalRule2(x,Up,Low,a,b,n,Dyu,Dyl)
% This function will perform numerical line integration using 
% Trapezoidal rule, the user will pass in the interval of integration
% and also the number of segments (panels). the code
% will return the result of the definite integral.
% 
% - - - - - - - - - - - - - - - - - - - - - - - - - -
%
%       Inputs:
%               1- x: x interval you integrating along
%               2- Up: values for coefficient of pressure for Upper
%               surface
%               3- Low: values for coefficient of pressure for Lower
%               surface
%               4- a: Lower bound of integration
%               5- b: Upper bound of integration
%               6- n: number of points (panels)
%               7- Dyu: y height of airfoil (Upper)
%               8- Dyl: y height of airfoil (Lower)
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

Cn = 0;
Ca = 0;

% if we integrating for coefficient of normal force

    
for k = 1:(n-1)
    
    series_Cn =  (( x(k+1) - x(k) ) * (Low(k+1) + Low(k))/2 ) - (( x(k+1) - x(k) ) * (Up(k+1) + Up(k))/2 )  ;
    
        
    series_Ca = (( x(k+1) - x(k) ) * (Up(k+1) + Up(k))/2) * (-( Dyu(k) - Dyu(k+1) ) / ( x(k+1) - x(k) )) -...
        (( x(k+1) - x(k) ) * (Low(k+1) + Low(k))/2) * (-( Dyl(k) - Dyl(k+1) ) / ( x(k+1) - x(k) ));
   
    Cn(v) = series_Cn; % store results.
    Ca(v) = series_Ca; % store results.
    v = v+1;
    
end

Cn = sum(Cn);
Ca = sum(Ca);

    
end

    
 