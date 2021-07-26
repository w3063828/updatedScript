SET input TO LIST(LIST( V(1,2,3)       ,V(2,5,-1)        ,V(-1.5,2.7,3.3))).

SET weights TO LISt(LIST( V(0.2,0.8,-0.5),V(0.5,-0.91,0.26),V(-0.26,-0.27,0.17))).
input:ADD(weights).
SET bias TO LIST( LIST(2,3,0.5)).

FOR var in input {         // --.
  print var.             //   |-- Print all the contents of FOO.
}.
