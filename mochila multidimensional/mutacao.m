function nvPopulacao = mutacao(populacao)
    global nPopulacao
    global nItens

    taxaMutacoes = 0.065;
    nMutacoes = round(taxaMutacoes * nPopulacao);
    nvPopulacao = populacao;

    % escolhe individuos para mutacao
    indiceIndividuos = randperm(nPopulacao, nMutacoes);
    
    for k = 1:nMutacoes
        individuo = populacao(indiceIndividuos(k), :);

        % Mutacao Normal aleatoria 
        for i = 1:nItens
            parte = individuo(i:nItens);
            if rand() < taxaMutacoes
                if individuo(i) == 0
                    individuo(i) = 1;
                else
                    individuo(i) = 0;
                endif
            endif
        endfor

        nvPopulacao(indiceIndividuos(k), :) = individuo;
    endfor
end