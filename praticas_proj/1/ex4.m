%% 4a)  ##########################################
%% para estar num de intereferencia -> 10^-3 e 10^-2

% normal state

state6 =  1 / (1 + (8 / 600) + (5 / 200) * (8 / 600) + (2 / 50) * (5 /200) * (8 / 600) + (1 / 5) * (2 / 50) * (5 / 200) * (8 / 600))
state5 = (8 / 600) / (1 + (8 / 600) + (5 / 200) * (8 / 600) + (2 / 50) * (5 / 200) * (8 / 600) + (1 / 5) * (2 / 50) * (5 / 200) * (8 / 600))
state4 = (5 / 200) * (8 / 600) / (1 + (8 / 600) + (5 / 200) * (8 / 600) + (2 / 50) * (5 / 200) * (8 / 600) + (1 / 5) * (2 / 50) * (5 / 200) * (8 /600))


probNormal = state6 + state5 + state4
             
% intereference state
state3 = (2 / 50) * (5 / 200) * (8 / 600) / (1 + (8 / 600) + (5 / 200) *(8 / 600) + (2 / 50) * (5 / 200) * (8 / 600) + (1 / 5) * (2 / 50) * (5 /200) * (8 / 600));

state2 = (1 / 5) * (2 / 50) * (5 / 200) * (8 / 600) / (1 + (8 / 600) + (5/ 200) * (8 / 600) + (2 / 50) * (5 / 200) * (8 / 600) + (1 / 5) * (2 /50) * (5 / 200) * (8 / 600));


probInterefence = state3 + state2
%% 4b)  ##########################################

% normal state
state6 = 1 / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state5 = (8/600) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state4 = (8/600*5/200) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);

% intereference state
state3 = (8/600*5/200*2/50) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state2 = (8/600*5/200*2/50*1/5) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);

ber6 = state6 * 10^-6;
ber5 = state5 * 10^-5;
ber4 = state4 * 10^-4;

% normal average
normalAverage = (ber6 + ber5 + ber4)/ ( state6 + state5 + state4)

ber3 = state3 * 10^-3;
ber2 = state2 * 10^-2;

% intereference average
intereferenceAverage = (ber3 + ber2) / (state3 + state2) 


%% 4c)  ##########################################

packetsize = linspace(64*8,200*8);

% normal state
state6 = 1 / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state5 = (8/600) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state4 = (8/600*5/200) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);

% intereference state
state3 = (8/600*5/200*2/50) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state2 = (8/600*5/200*2/50*1/5) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);

% 1 - ( nchoosek(n,i) * p^i * (1-p)^(n-i) )
% i = 0 (zero erros)
probEestado6 = 1 - ( 1 * (10^-6)^0 * (1-(10^-6)).^packetsize )
probEestado5 = 1 - ( 1 * (10^-5)^0 * (1-(10^-5)).^packetsize );
probEestado4 = 1 - ( 1 * (10^-4)^0 * (1-(10^-4)).^packetsize );
probEestado3 = 1 - ( 1 * (10^-3)^0 * (1-(10^-3)).^packetsize );
probEestado2 = 1 - ( 1 * (10^-2)^0 * (1-(10^-2)).^packetsize );

prob6dadoE = ( probEestado6 .* state6 ) ./ ( ( probEestado6 .* state6 ) + ( probEestado5 .* state5 ) + ( probEestado4 .* state4 ) + ( probEestado3 .* state3 ) + ( probEestado2 .* state2 ) )
prob5dadoE = ( probEestado5 .* state5 ) ./ ( ( probEestado6 .* state6 ) + ( probEestado5 .* state5 ) + ( probEestado4 .* state4 ) + ( probEestado3 .* state3 ) + ( probEestado2 .* state2 ) )
prob4dadoE = ( probEestado4 .* state4 ) ./ ( ( probEestado6 .* state6 ) + ( probEestado5 .* state5 ) + ( probEestado4 .* state4 ) + ( probEestado3 .* state3 ) + ( probEestado2 .* state2 ) )

probNdadoE = ( prob6dadoE + prob5dadoE + prob4dadoE)

figure(1)
plot(packetsize/8,probNdadoE * 100,'b-')
grid on
title('Probab. of being on Normal state given errors')
xlabel('Packet Size (Bytes)')

%% 4d)  ##########################################


packetsize = linspace(64*8,200*8);

% normal state
state6 = 1 / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state5 = (8/600) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state4 = (8/600*5/200) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);

% intereference state
state3 = (8/600*5/200*2/50) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);
state2 = (8/600*5/200*2/50*1/5) / (1 + 8/600 + 8/600*5/200 + 8/600*5/200*2/50 + 8/600*5/200*2/50*1/5);

% 1 - ( nchoosek(n,i) * p^i * (1-p)^(n-i) )
% i = 0 (zero erros)
probEestado6 = ( 1 * (10^-6)^0 * (1-(10^-6)).^packetsize )
probEestado5 = ( 1 * (10^-5)^0 * (1-(10^-5)).^packetsize );
probEestado4 = ( 1 * (10^-4)^0 * (1-(10^-4)).^packetsize );
probEestado3 = ( 1 * (10^-3)^0 * (1-(10^-3)).^packetsize );
probEestado2 = ( 1 * (10^-2)^0 * (1-(10^-2)).^packetsize );

prob3dadoE = ( probEestado3 .* state3 ) ./ ( ( probEestado6 .* state6 ) + ( probEestado5 .* state5 ) + ( probEestado4 .* state4 ) + ( probEestado3 .* state3 ) + ( probEestado2 .* state2 ) )
prob2dadoE = ( probEestado2 .* state2 ) ./ ( ( probEestado6 .* state6 ) + ( probEestado5 .* state5 ) + ( probEestado4 .* state4 ) + ( probEestado3 .* state3 ) + ( probEestado2 .* state2 ) )


probNdadoE = ( prob3dadoE + prob2dadoE)

figure(2)
plot(packetsize/8,probNdadoE * 100,'b-')
grid on
title('Probab. of being on Interference state given errors')
xlabel('Packet Size (Bytes)')


