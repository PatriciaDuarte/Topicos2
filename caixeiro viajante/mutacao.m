function nvPopulacao = mutacao(populacao)
    global nPopulacao

    taxaMutacoes = 0.065;
    nMutacoes = round(taxaMutacoes * nPopulacao);
    nvPopulacao = populacao;

    % escolhe individuos para mutacao
    indiceIndividuos = randperm(nPopulacao, nMutacoes);
    
    for k = 1:length(indiceIndividuos)
        individuo = populacao(indiceIndividuos(k), :);
        len = length(individuo);

        % Mutacao Normal aleatoria (cidades trocadas aleatoriamente)
        for i = 1:len
            parte = individuo(i:len);
            if rand() < taxaMutacoes
                aux = parte(1);
                index = randi(length(parte));
                parte(1) = parte(index); 
                parte(index) = aux;
                individuo(i:len) = parte;
            end
        end

        nvPopulacao(indiceIndividuos(k), :) = individuo;
        individuo
    end 
end