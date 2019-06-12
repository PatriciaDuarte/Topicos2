clear all;
close all;
clc;

tcro = 22;    %tamanho do cromossomo (para termos maior precisao)
pop  = 30;    %tamanho da populacao 30 cromossomos de tamanho 22
xmin = -256;  %intervalo minimo
xmax = 512;   %intervalo maximo
format short; %para trabalhar com 4 casas decimais

%criando população inicial
for i=1:pop
	[x(i,:)]        = round(rand(1,tcro)); %gera um vetor com 30 individuos de zeros e uns (decimais)
    [vlrxbi(i,:)]   = de2bi(x(i,:));       %transforma os decimais gerados em binarios
    [vlrxreal(i,:)] = bi2de(x(i,:));       %gera o valor real de cada binario em real (b10 da formula dos slides)
    [xreal(i,:)]    = xmin + ((xmax - xmin).*vlrxreal(i,:)./(2^tcro - 1)); %mapeia cada x para o intervalo [-256, 512]
    [fitx(i)]       = -abs(xreal(i,:).*(sin(sqrt(abs(xreal(i,:)))))); %calculando o fitness
end;    

%mandem exibir o valor de cada variavel gerado no for
%o resto eh com voces!!!