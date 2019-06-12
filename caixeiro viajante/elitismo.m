% Funcao de elitismo pegando os melhores resultados entre as duas geracoes
function [melhores] = elitismo(nvPopulacao, populacao)
    global nPopulacao;

    taxaElitismo = 0.5;
    melhores = nvPopulacao;

    % calculando os fitness
    [nvMenor, fitNvPopulacao] = menorCaminho(nvPopulacao);
    [menor, fitPopulacao] = menorCaminho(populacao);

    % uni e ordena todos os elementos em um unico vetor
    [fitGeral, fitGeralIndex] = sort([fitNvPopulacao fitPopulacao]);
    nGeral = length(fitGeral);
    
    for i = 1:round(nPopulacao * taxaElitismo)
        indice = fitGeralIndex(i);
        if indice > nPopulacao
            % trata o indice para encontrar o individuo correspondente no vetor de populacao antiga
            if (indice == nGeral)
                indice = nPopulacao;
            else 
                indice = mod(indice, nPopulacao);
            end;
            melhores(i,:) = populacao(indice,:);
        else 
            melhores(i,:) = nvPopulacao(indice,:);
        end
    end
end