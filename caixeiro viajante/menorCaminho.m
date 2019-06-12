function [melhor, fitness] = menorCaminho(populacao)
    global nPopulacao

    melhor  = populacao(1, :);
    distMelhor = distanciaCaminho(melhor);
    fitness(1) = distMelhor;
    for i = 2:nPopulacao
        caminho = populacao(i, :);
        dist = distanciaCaminho(caminho);
        if dist < distMelhor
            melhor = caminho;
            distMelhor = dist;
        end
        fitness(i) = dist;
    end
end

