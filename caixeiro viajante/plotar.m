function plotar(nGeracao, cidades, minCaminho)
    global caminhoGrafico

    if (nGeracao < 1)
        cidadeGrafico = plot(cidades(:,1),
            cidades(:,2),
            'bo',
            'MarkerFaceColor', 'r');

        tituloGrafico = title({[' ----- Geracao:' num2str(nGeracao)];
                ['Melhor caminho: ' num2str(minCaminho)];
                ['Distancia percorrida: ' num2str(distanciaCaminho(minCaminho))]});
        hold on;
        
        caminhoGrafico = plot([cidades(minCaminho, 1)' cidades(minCaminho(1), 1)], % todos os x e repete o primeiro
            [cidades(minCaminho, 2)' cidades(minCaminho(1), 2)], % todos os y e repete o primeiro
            'b-');
    else 
        tituloGrafico = title({[' ----- Geracao:' num2str(nGeracao)];
                ['Melhor caminho: ' num2str(minCaminho)];
                ['Distancia percorrida: ' num2str(distanciaCaminho(minCaminho))]});
        
        set(caminhoGrafico,
            'XData', [cidades(minCaminho, 1)' cidades(minCaminho(1), 1)],
            'YData', [cidades(minCaminho, 2)' cidades(minCaminho(1), 2)])
    end
end