function dyvar = SimplePend_NE(~,yvar)

global IA massA FGA TorqA
angA = yvar(1,1);
dangA = yvar(2,1);

dyvar(1,1) = dangA;

Pos = SimplePend_getPositions(angA);
[~,omega] = SimplePend_getVelocities(dangA,Pos);
dangA_temp = 1;
[CVel,~] = SimplePend_getVelocities(dangA_temp,Pos);


d2angA_temp = 0;
[Accl_omega,~] = SimplePend_getAccelerations(d2angA_temp,Pos,omega);

rvec = Pos.AO;
rtilde = make_tilde(rvec);

    MAT = zeros(3,3);
    MAT(1:2,1:2) = eye(2,2);
    MAT(3,1:2) = rtilde(3,1:2);
    MAT(:,3) = [-massA*CVel.AO(1:2,1);IA(3,3)];
    VEC = [(massA*Accl_omega.AO(1:2))-FGA(1:2,1); TorqA(3,1)];

    sol = MAT\VEC;
    d2angA = sol(3,1);

    dyvar(2,1) = d2angA;
end
