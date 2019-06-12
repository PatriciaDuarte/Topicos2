function nvPopulacao = crossover(populacao, fit)
    global nPopulacao
    global nCidades

    taxaCrossovers = 0.9;
    nCrossovers = round(taxaCrossovers * nPopulacao);
    nvPopulacao = populacao;

    % escolhe individuos para crossover
    indiceIndividuos = randperm(nPopulacao, nCrossovers);
    
    for k = 1:2:length(indiceIndividuos)
        
        individuo1 = populacao(indiceIndividuos(k), :);
        
        % tratando o segundo individuo caso o numero de inviduos seja impar
        if k+1 > length(indiceIndividuos)
            index2 = 1;
        else 
            index2 = k+1;
        end
        individuo2 = populacao(indiceIndividuos(index2), :);

        % seleciona o tamanho do primeiro segmento de corte
        corte1 = randi([3, nCidades - 2]);

        % faz o primeiro corte (seleciona do 1º elemento ate o corte1)
        filho1(:, 1:corte1) = individuo1(:, 1:corte1);
        filho2(:, 1:corte1) = individuo2(:, 1:corte1);

        p1 = individuo1;
        p2 = individuo2;
        for j = 1 : corte1
            index = find(p2 == p1(j));
            p2(index) = p2(j);              
            p2(j) = p1(j);                  
        end
        filho1(1, corte1 + 1:nCidades) = p2(1, corte1 + 1:nCidades);
        
        p2 = individuo2;
        for j = 1 : corte1
            if p1(j) ~= p2(j)
                index = find(p1 == p2(j));
                p1(index) = p1(j);
                p1(j) = p2(j);
            end
        end
        filho2(1, corte1 + 1:nCidades) = p2(1, corte1 + 1:nCidades);

        % retorna a populacao
        nvPopulacao(indiceIndividuos(k),:) = filho1;
        nvPopulacao(indiceIndividuos(index2),:) = filho2;
    end
end