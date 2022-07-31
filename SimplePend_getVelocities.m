function [Vel,omega] = SimplePend_getVelocities(dangA,Pos)

omega.A = [0;0;dangA];
Vel.AO = cross(omega.A,Pos.AO);

end
