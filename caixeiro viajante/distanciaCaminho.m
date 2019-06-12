function dist = distanciaCaminho(caminho)
    global distancias
    dist = 0;
    for i = 1 : max(size(caminho)) - 1
        origem = caminho(i);
        destino   = caminho(i + 1);
        dist = dist + distancias(origem, destino);
    end
end