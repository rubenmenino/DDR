% normal state

state6 = 1 / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state5 = (8/600) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state4 = (8/600*5/200) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);

probNormal = state6 + state5 + state4
             
% interference state
state3 = (8/600*5/200*2/50) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state2 = (8/600*5/200*2/50*1/5) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);

probInterefence = state3 + state2