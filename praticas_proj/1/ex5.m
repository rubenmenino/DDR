% sempre erros                     -> intereferencia
% se pelo menos um nao tiver erros -> normal

% falso positivo -> recebe todos com erro e está no normal
% falso negativo -> recebe pelo menos um sem erro e está no intereferencia

%% 5a)

frameSize = (64 * 8);

% normal state
state6 = 1 / (1 + 8/600 + (8/600) * (5/200) + (8/600) * (5/200) * (2/50) + (8/600) * (5/200) * (2/50) * (1/5));
state5 = (8/600) / (1 + (8/600) + (8/600)*(5/200) + (8/600)*(5/200)*(2/50) + (8/600)*(5/200)*(2/50)*(1/5));
state4 = ((8/600)*(5/200)) / (1 + (8/600) + (8/600)*(5/200) + (8/600)*(5/200)*(2/50) + (8/600)*(5/200)*(2/50)*(1/5));

% intereference state
state3 = ((8/600)*(5/200)*(2/50)) / (1 + (8/600) + (8/600)*(5/200) + (8/600)*(5/200)*(2/50) + (8/600)*(5/200)*(2/50)*(1/5));
state2 = ((8/600)*(5/200)*(2/50)*(1/5)) / (1 + (8/600) + (8/600)*(5/200) + (8/600)*(5/200)*(2/50) + (8/600)*(5/200)*(2/50)*(1/5));

probEestado6 = 1 - ( 1 * (10^-6)^0 * (1-(10^-6)) ^ frameSize );
probEestado5 = 1 - ( 1 * (10^-5)^0 * (1-(10^-5)) ^ frameSize );
probEestado4 = 1 - ( 1 * (10^-4)^0 * (1-(10^-4)) ^ frameSize );
probEestado3 = 1 - ( 1 * (10^-3)^0 * (1-(10^-3)) ^ frameSize );
probEestado2 = 1 - ( 1 * (10^-2)^0 * (1-(10^-2)) ^ frameSize );

probFalsePositives = [0,0,0,0];
i = 1;
for n = 2:1:5
    n6 = probEestado6 ^ n;
    n5 = probEestado5 ^ n;
    n4 = probEestado4 ^ n;
    n3 = probEestado3 ^ n;
    n2 = probEestado2 ^ n;

    prob6dadoE = ( n6 .* state6 ) ./ ( ( n6 .* state6 ) + ( n5 .* state5 ) + ( n4 .* state4 ) + ( n3 .* state3 ) + ( n2 .* state2 ) )
    prob5dadoE = ( n5 .* state5 ) ./ ( ( n6 .* state6 ) + ( n5 .* state5 ) + ( n4 .* state4 ) + ( n3 .* state3 ) + ( n2 .* state2 ) )
    prob4dadoE = ( n4 .* state4 ) ./ ( ( n6 .* state6 ) + ( n5 .* state5 ) + ( n4 .* state4 ) + ( n3 .* state3 ) + ( n2 .* state2 ) )

    probNdadoE = ( prob6dadoE + prob5dadoE + prob4dadoE)


    probFalsePositives(i) = probNdadoE
    i = i + 1;
end


figure(1)

semilogy(linspace(2,5,4), probFalsePositives * 100, 'b-')
grid on
title('Prob of false positives')
xlabel('Number of frames')

%%

%% 5b)

frameSize = (64 * 8);

% normal state
state6 = 1 / (1 + 8/600 + (8/600) * (5/200) + (8/600) * (5/200) * (2/50) + (8/600) * (5/200) * (2/50) * (1/5));
state5 = (8/600) / (1 + (8/600) + (8/600)*(5/200) + (8/600)*(5/200)*(2/50) + (8/600)*(5/200)*(2/50)*(1/5));
state4 = ((8/600)*(5/200)) / (1 + (8/600) + (8/600)*(5/200) + (8/600)*(5/200)*(2/50) + (8/600)*(5/200)*(2/50)*(1/5));

% intereference state
state3 = ((8/600)*(5/200)*(2/50)) / (1 + (8/600) + (8/600)*(5/200) + (8/600)*(5/200)*(2/50) + (8/600)*(5/200)*(2/50)*(1/5));
state2 = ((8/600)*(5/200)*(2/50)*(1/5)) / (1 + (8/600) + (8/600)*(5/200) + (8/600)*(5/200)*(2/50) + (8/600)*(5/200)*(2/50)*(1/5));

probEestado6 = 1 - ( 1 * (10^-6)^0 * (1-(10^-6)) ^ frameSize );
probEestado5 = 1 - ( 1 * (10^-5)^0 * (1-(10^-5)) ^ frameSize );
probEestado4 = 1 - ( 1 * (10^-4)^0 * (1-(10^-4)) ^ frameSize );
probEestado3 = 1 - ( 1 * (10^-3)^0 * (1-(10^-3)) ^ frameSize );
probEestado2 = 1 - ( 1 * (10^-2)^0 * (1-(10^-2)) ^ frameSize );

probFalsePositives = [0,0,0,0];
i = 1;
for n = 2:1:5
    n6 = 1 - probEestado6 ^ n;
    n5 = 1 - probEestado5 ^ n;
    n4 = 1 - probEestado4 ^ n;
    n3 = 1 - probEestado3 ^ n;
    n2 = 1 - probEestado2 ^ n;

    prob3dadoE = ( n3 .* state3 ) ./ ( ( n6 .* state6 ) + ( n5 .* state5 ) + ( n4 .* state4 ) + ( n3 .* state3 ) + ( n2 .* state2 ) )
    prob2dadoE = ( n2 .* state2 ) ./ ( ( n6 .* state6 ) + ( n5 .* state5 ) + ( n4 .* state4 ) + ( n3 .* state3 ) + ( n2 .* state2 ) )

    probIdadoE = ( prob3dadoE + prob2dadoE)


    probFalseNegatives(i) = probIdadoE
    i = i + 1;
end




semilogy(linspace(2,5,4), probFalseNegatives * 100, 'b-')
grid on
title('Prob of false negatives')
xlabel('Number of frames')




