function atilde = make_tilde(avec)


atilde = [0 -avec(3,1) avec(2,1);
          avec(3,1) 0 -avec(1,1);
          -avec(2,1) avec(1,1) 0];
end
