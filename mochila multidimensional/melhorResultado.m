function [melhor, todosFitness] = melhorResultado(populacao)
    global nPopulacao

    melhor = populacao(1, :);
    fitMelhor = fitness(melhor);
    todosFitness(1) = fitMelhor;

    % percorre todas as solucoes, calcula o fitness de cada e testa com a melhor encontrada
    for i = 2:nPopulacao
        solucao = populacao(i, :);
        fit = fitness(solucao);
        if fit > fitMelhor
            melhor = solucao;
            fitMelhor = fit;
        endif
        todosFitness(i) = fit;
    endfor
end

