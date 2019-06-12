function nvPopulacao = crossover(populacao, fit)
    global nPopulacao
    global nItens
    global nCompartimentos
    
    taxaCrossovers = 0.9;
    nCrossovers = round(taxaCrossovers * nPopulacao);
    nvPopulacao = populacao;

    % achando a soma de fitness da populacao
    s = sum(fit);

    % achando a probabilidade de cada funcao fitness
    for i = 1:nPopulacao
        p(i) = fit(i)/s;
    endfor;

    % calculando a probabilidade acumulativa
    c = cumsum(p);

    % usando metodo da roleta
    indice = 1;
    poselem = 0;
    while (indice < nPopulacao)
        r = rand;
        if (r < c(1))
            poselem = 1;
        else
            for j = 2:nPopulacao
                if (r > c(j-1)) & (r <= c(j))
                    poselem = j;
                    break;
                endif;
            endfor;
        endif;
    
        nvPopulacao(indice, :) = populacao(poselem, :);
        indice = indice + 1;
    endwhile;

    % fazendo cruzamento de pares
    for k = 1:nCrossovers
        
        individuo1 = nvPopulacao(k, :);
        
        % tratando o segundo individuo caso o numero de inviduos seja impar
        if k+1 > nCrossovers
            index2 = 1;
        else 
            index2 = k+1;
        endif
        individuo2 = nvPopulacao(index2, :);
        
        % seleciona posicao de corte entre itens da quarta e antepenultima posicao
        cortar = randi([3, nItens - 3]);

        % faz o crossover e gera 2 novos individuos novos
        filho1 = [individuo1(1:cortar) individuo2((cortar+1):nItens)];
        filho2 = [individuo2(1:cortar) individuo1((cortar+1):nItens)];
        
        % retorna a populacao
        nvPopulacao(k,:) = filho1;
        nvPopulacao(index2,:) = filho2;
    endfor
end