function [Accl,alpha] = SimplePend_getAccelerations(d2angA,Pos,omega)

alpha.A = [0;0;d2angA];
Accl.AO = cross(alpha.A,Pos.AO) + cross(omega.A,cross(omega.A,Pos.AO));

end
