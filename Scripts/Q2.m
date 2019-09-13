%% question 2: NACA 0012

% you're given information about Cp disturbution NACA 0012 lower and upper
% surface estimate lift and drag using numerical integraiton,
% mainly Trapazoidal rule


%% define ocnstants

c = 2; % chord length [m]
alpha = 9; % AOA [Degrees]
V_inf = 30; % Free-stream flow speed [m/s]
roh_inf = 1.225; % Free-stream flow density [kg/m];
P_inf = 101.3*10^3 ; % free-stream pressure (statics)[Pa];


%% Airfoil information: NACA 0012

% integration the Coefficient of Axial force using equation 1.16 will
% require you to know the change in height of the airfoil over the change
% of the horizontal distance of the airfoil, therefore we need to define
% the thickness or yt of the airfoil:


% NACA Naming follows the following convention:

% NACA MPXX
%   example : NACA 2412
%     M is the maximum camber divided by 100. In the example M=2 so the camber is 0.02 or 2% of the chord
%     P is the position of the maximum camber divided by 10. In the example P=4 so the maximum camber is at 0.4 or 40% of the chord.
%     XX is the thickness divided by 100. In the example XX=12 so the thiickness is 0.12 or 12% of the chord.


% more info:

% http://airfoiltools.com/airfoil/naca4digit


% since it's NACA 0012 %thickness is t = 12/100

% In our example, M = 0; Therfore, gradient change is 0.
t = 12/100;

% since our airfoil isn't cambered, we can say that from equations in the
% website:

% since it's symmetric airfoil, we will see that everything cancels and the
% y location simply becomes 

syms x
yt = (t/0.2).*c .* ( 0.2969.*sqrt(x./c) -0.1260*(x./c) - 0.3516.*(x./c).^2 + 0.2843.*(x./c).^3 - 0.1036.*(x./c).^4 ) ;


Yu = yt;
Yl =  -1.*(t/0.2).*c .* ( 0.2969.*sqrt(x./c) -0.1260*(x./c) - 0.3516.*(x./c).^2 + 0.2843.*(x./c).^3 - 0.1036.*(x./c).^4 ) ;


% for Ca we would need to know how the lower and upper surface change
% curvature, so we would need the derivative with respect to x.

dYu_dx = diff(Yu);
dYl_dx = diff(Yl);


%% info

% since it was given that the airfoil is at 9-degrees AOA, we know that
% integration over the surface will give us normal and axial forces, and
% those can be converted to lift and drag using AOA.


% using equation 1.15, 1.16 from Anderson's Fundemental of aerodynamics,
% page 26 in 6th edition:

% TrapezoidalRule will give out results from definite integral, there's no
% need to concern ourselves with skin friction pressure for now.

%% integration

% open up the spline function
Spline = open('Cp.mat');

% get upper and lower spline data
Cp_upper = Spline.Cp_upper;
Cp_lower = Spline.Cp_lower;


numSeg = 1000; % how many panels used to integrate?

lower_limit = 0;
x = linspace(lower_limit,c,numSeg); % create segments that we will integrate along


% important: getting to Cp's must be through x/c not x !
Cpu = fnval(Cp_upper, x./c); % evaluate the upper surface Cp's along that segment
Cpl = fnval(Cp_lower, x./c); % evaluate the lower surface Cp's along that segment


% since dx is fixed because points in x are equispaced, the change in y 

Dyu= double(subs(Yu, x));% evaluate surface of airfoil : top
Dyl= double(subs(Yl, x)); % height of c


% because if we start from 0, division will be 0/0, thus NAN, eliminate
% that


Dyu(isnan(Dyu)) = 0;

Dyl(isnan(Dyl)) = 0;

Cn = (1/c) * (  TrapezoidalRule(x,Cpl,lower_limit,c,numSeg,'Cn',0) - TrapezoidalRule(x,Cpu,lower_limit,c,numSeg,'Cn',0)  ) ;

% for Ca
Ca = (1/c) * ( TrapezoidalRule(x,Cpu,lower_limit,c,numSeg,'Ca',Dyu) - TrapezoidalRule(x,Cpl,lower_limit,c,numSeg,'Ca',Dyl) ) ;


Cl = Cn*cosd(alpha) - Ca*sind(alpha);
Cd = Cn*sind(alpha) + Ca*cosd(alpha);

%% 


Up = fnval(Cp_upper, [0:0.001:1]);
Down = fnval(Cp_lower, [0:0.001:1]);

plot([0:0.001:1],-Up,'LineWidth',2)
hold on
plot([0:0.001:1],-Down,'LineWidth',2)
ylabel('-C_p');
xlabel('x/c');
grid minor