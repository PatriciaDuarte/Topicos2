% Autores: Larissa e Patricia
% data: 08/11/2018
% Descri��o: Solu��o para o problemas da mochila multidimensional com AG.
clear all;
close all;
clc;

global nPopulacao
global nItens
global nCompartimentos
nPopulacao = 10; % tamanho da populacao 
geracao = 10; % numero de geracoes que serao processadas
nItens = 20; % quantidade de itens combinados
nCompartimentos = 4; % quantidade de compartimentos da mochila

% criando benecifios e pesos aleatorios
global capacidades
global beneficios
global itensPorCompartimento
geraproblema(nItens, nCompartimentos);

% criando populacao inicial
populacao = zeros(nPopulacao, nItens); % (nPopulacao x nItens)
for i = 1:nPopulacao
    populacao(i,:) = round(rand(1,nItens)); % uma solu��o aleatoria, seja viav�l ou n�o
endfor

% achando o melhor individuo da geracao
[melhorSolucao, fit] = melhorResultado(populacao);

% plotando o melhor resultado da primeira geracao
plotar(0, melhorSolucao);

for i = 1:geracao
	nvPopulacao = crossover(populacao, fit);
  	nvPopulacao = mutacao(nvPopulacao);
    populacao = elitismo(nvPopulacao, populacao);

    % achando o melhor individuo da geracao para plotar como exemplo
    [melhorSolucao, fit] = melhorResultado(populacao, nPopulacao);
    pause(0.05);
	
	plotar(i, melhorSolucao);
endfor
