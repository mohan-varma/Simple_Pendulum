% Forward Dynamics using Kane's Equation

clear all
clc
close all
global localvec IA massA FGA TorqA


massA = 5;
lengthA = 5;
IA(3,3) = (massA*lengthA^2)/12;
localvec.AO_AN = [0;0.5*lengthA;0];
%localvec.AO_AB = [0;-0.5*lengthA;0];

FGA = [0;-9.81;0]*massA;
TorqA = [0;0;-50];

% Initial Values
angA0 = deg2rad(45); %rad
dangA0 = 0; % rad/sec

initvalues = [angA0;dangA0];


%[T,Y] = ode45(@SimplePend_NE,[0 10],initvalues);
[T,Y] = ode45(@SimplePend_Kane,[0 10],initvalues);

% Inverse dynamics to find reaction forces
[lenT,~] = size(T);
for ii = 1:length(T)

    angA = Y(ii,1);
    dangA = Y(ii,2);
    DY = SimplePend_Kane(T(ii),Y(ii,:)');
    d2angA = DY(2,1);
    Y(ii,3) = d2angA;
    Pos = SimplePend_getPositions(angA);
    [Vel,omega] = SimplePend_getVelocities(dangA,Pos);
    [Accl,alpha] = SimplePend_getAccelerations(d2angA,Pos,omega);

    FNA(:,ii) = massA*Accl.AO - FGA;

    linexy = [[0;0;0] Pos.AO];% Pos.AB];

    figure(1)
    plot(linexy(1,:),linexy(2,:),'*')
    hold on
    plot(linexy(1,:),linexy(2,:),'-')
    hold off
    axis([-10 10 -10 10])
    pause(0.01)

end

%
figure(2)
subplot(311)
plot(T,Y(:,1))
subplot(312)
plot(T,Y(:,2))
subplot(313)
plot(T,Y(:,3))

% figure(3)
% plot(T,Tor(3,:))
save('SimplePend_FwdDyn_Data.mat','T','Y')

