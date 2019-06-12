% Autores: Larissa e Patricia
% data: 16/10/2018
% Descrição: Solução para o problemas do caixeiro viajante com AG.
clear all;
close all;
clc;

global nPopulacao
global nCidades
nPopulacao = 100; % tamanho da populacao 
geracao = 200; % numero de geracoes que serao processadas
nCidades = 20; % quantidade de cidades combinadas
espacoDeBusca = 100; % valor máximo para X e Y das coordenadas das cidades

% criando cidades aleatorias
global distancias
[cidades, distancias] = geracidades(nCidades, espacoDeBusca);


% criando populacao inicial
populacao = zeros(nPopulacao, nCidades);
for i = 1:nPopulacao
    populacao(i,:) = randperm(nCidades, nCidades); % gera tour aleatorio sem repetir cidade
end
% achando o melhor individuo da geracao
[minCaminho, fit] = menorCaminho(populacao, nPopulacao);

% plotando o grafico com o melhor caminho da primeira geracao
global caminhoGrafico
plotar(0,cidades, minCaminho);

for i = 1:geracao
	nvPopulacao = crossover(populacao, fit);
  	nvPopulacao = mutacao(nvPopulacao);
    populacao = elitismo(nvPopulacao, populacao);

    % achando o melhor individuo da geracao para plotar como exemplo
    [minCaminho, fit] = menorCaminho(populacao, nPopulacao);
    pause(0.05);
	
	plotar(i, cidades, minCaminho);
end
