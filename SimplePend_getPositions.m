function Pos = SimplePend_getPositions(angA)
global localvec

    N_A = [cos(angA) -sin(angA) 0;
           sin(angA)  cos(angA) 0;
           0 0 1];


    Pos.AO = -N_A*localvec.AO_AN;
    %Pos.AB = Pos.AO + N_A*localvec.AO_AB;

end
