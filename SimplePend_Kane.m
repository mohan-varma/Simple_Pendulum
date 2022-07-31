function dyvar = SimplePend_Kane(~,yvar)

global IA massA FGA TorqA
angA = yvar(1,1);
dangA = yvar(2,1);

dyvar(1,1) = dangA;

Pos = SimplePend_getPositions(angA);
dangA_temp = 1;
[CVel,Comg] = SimplePend_getVelocities(dangA_temp,Pos);

for fn = fieldnames(Comg)'
   omega.(fn{1}) = dangA*Comg.(fn{1});
end

d2angA_temp = 0;
[Accl_k,alpha_k] = SimplePend_getAccelerations(d2angA_temp,Pos,omega);


LHS = TorqA'*Comg.A + FGA'*CVel.AO + (-massA*Accl_k.AO)'*CVel.AO;
CoeffRHS = (IA*Comg.A)'*Comg.A + massA*CVel.AO'*CVel.AO;

d2angA = LHS/CoeffRHS;

dyvar(2,1) = d2angA;
end
