function [Cn,Ca] = TrapezoidRule(Cp_upper,Cp_lower,N,c,t)
%TrapezoidRule
% Inputs:
%           Cp_upper:   Cp for upper surface
%           Cp_lower:   Cp for the lower surface
%           N:          Number of integration points
%           c:          chord length
%           t:          Thickness/chord
%
%Outputs:
%           Cn:         Coefficient of Pressure in normal direction
%           Ca:         Coefficient of Pressure in axial direction

%y function for given x value
y_t_func = @(x) (t/0.2)*c .* ( 0.2969.*sqrt(x./c) - 0.1260.*(x./c) - 0.3516.*(x./c).^2 + 0.2843.*(x./c).^3 - 0.1036.*(x./c).^4 ); % [m]
%Preallocate Cn and Ca
Cn = 0;
Ca = 0;
%create x vector from 0 to c
x_vec = linspace(0,c,N+1);
y_vec = y_t_func(x_vec);
%find the change in x and y positions
deltax = diff(x_vec);
deltay = diff(y_vec);
%calculate cp for upper and lower surfaces using given struct
c_p_upper = fnval(Cp_upper,x_vec/c);
c_p_lower = fnval(Cp_lower,x_vec/c);
for i = 1:N
    %trapezoid rule
    trap_up = (c_p_upper(i+1) + c_p_upper(i))/2;
    trap_low = (c_p_lower(i+1) + c_p_lower(i))/2;
    %multiply by the change in x for cn and sum
    Cn = Cn + deltax(i)*(trap_low - trap_up);
    %multiply by the change in y for ca and sum
    %airfoil is symmetric
    Ca = Ca + deltay(i)*(trap_up + trap_low);
end
%Divide by chord
Ca = Ca/c;
Cn = Cn/c;
end

