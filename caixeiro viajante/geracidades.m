function [cidades, distancias] = geracidades (nCidades, espacoDeBusca)

% cria cidades aleatoriamente
cidades = round(espacoDeBusca * rand(nCidades, 2));

% calcula distancias entre cidades
distancias = zeros(nCidades); % gera matriz zerada 10x10
for i = 1:(nCidades-1)
  c1 = cidades(i,:); % seleciona primeira cidade
  for j = (i + 1):nCidades
    c2 = cidades(j,:); % seleciona segunda cidade
    d = c2 - c1;
    distSq = sqrt(d(1)^2 + d(2)^2);
    distancias(i, j) = distSq;
    distancias(j, i) = distSq;
  end
end