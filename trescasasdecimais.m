clear all;
close all;
clc;
disp('Processando...');
%gerando um vetor de 50 numeros randomicos
[vlrands50] = round(512*rand(1,50));
x = -256:512;
y = -abs(x.*(sin(sqrt(abs(x)))));
plot(x,y);
%loop para imprimir os valores q estao no vetor vlrands50
for i=1:max(size(vlrands50))
    hold on;            
	x = vlrands50(i);
	y = -abs(x.*(sin(sqrt(abs(x)))));
	plot(x,y,'-ro','LineWidth',0.5,...
                   'MarkerEdgeColor','r',...
                   'MarkerFaceColor','r',...
                   'MarkerSize',5);    
end;    
decimais = 0:1024;
decimais = decimais'; 
for k=1:30       
    %Achando o valor de y para cada x do vetor vlrands50
	for i=1:max(size(vlrands50))
        fxvlrands50(i) = -abs(vlrands50(i).*(sin(sqrt(abs(vlrands50(i))))));
	end;        
    %Achando a soma de fitness f(x) da populacao
	S = sum(fxvlrands50);	        
	%Achando a probabilidade
	for i=1:max(size(vlrands50))
        p(i) = fxvlrands50(i)/S;
	end;	
	%Achando a probabilidade acumulativa
	c = cumsum(p);
    
	indiv1bin = zeros(1, 10);
	indiv2bin = zeros(1, 10);
        
	nvoindiv1bin = zeros(1, 10);
	nvoindiv2bin = zeros(1, 10);
	
    nvovlrands50 = 0;    
    indiv1real = 0;
    indiv2real = 0;
 
    poselem = 0;    
    indice = 1;
    
    %Usando m�todo da roleta
    while(max(size(nvovlrands50))~=50)
        r = rand;
        if (r < c(1))
            poselem = 1;
        else
            for j=2:max(size(c))
                if(r > c(j-1)) & (r <= c(j))
                    poselem = j;
                    break;        
                end;    
            end;
        end;
        nvovlrands50(1, indice) = vlrands50(1, poselem); 
        indice = indice + 1;
    end;
    
	%gerando pares para o cruzamento
	%serah gerado um total de 25 pares
	for i=1:25
        
        poselem1 = -1;
        r = rand;
        if (r < c(1))
            %j = 1;
            poselem1 = 1;
        else
            for j=2:max(size(c))
                if(r > c(j-1)) & (r <= c(j))
                    poselem1 = j;
                    break;        
                end;    
            end;
        end;
        
        poselem2 = -1;
        r = rand;
        if (r < c(1))
            %v = 1;
            poselem2 = 1;
        else
            for v=2:max(size(c))
                if(r > c(v-1)) & (r <= c(v))
                    poselem2 = v;
                    break;        
                end;    
            end;
        end;
        
        %pegando 2 valores randomicos reais q estao no vetor vlrands50
        indiv1real = nvovlrands50(1, poselem1); 
        indiv2real = nvovlrands50(1, poselem2);   
        
        %descobrindo o indice dos valores selecionados nas linhas anteriores
        indiv1indice = find(decimais == indiv1real);    
        indiv2indice = find(decimais == indiv2real);    
        
        %subtraindo 1 de indiv1indice pq com 10 bits o maximo
        %q eu consigo eh 1023
        indiv1indice = indiv1indice - 1;
        indiv2indice = indiv2indice - 1;
        
        %gerando um binario de 10 bits para cada um dos num. gerados anteriormente
        indiv1bin = dec2bin(indiv1indice, 10);
        indiv2bin = dec2bin(indiv2indice, 10);
        
        %gerando num. randomico para saber apartir de qual posicao do 
        %numero binario serah feito o crossover.
        cortar = fix(10*rand);
                
        %fazendo o crossover e gerando 2 novos individuos
        nvoindiv1bin = [indiv1bin(1:cortar) '' indiv2bin((cortar + 1):10)];
        nvoindiv2bin = [indiv2bin(1:cortar) '' indiv1bin((cortar + 1):10)];
        
        %achando o valor em real, correspondente a um valor binario
        nvoindiv1indice = bin2dec(nvoindiv1bin);
        nvoindiv2indice = bin2dec(nvoindiv2bin);
        
        %somando 1 pq a matriz decimais vai ateh 1024 e 
        %bin2dec(nvoindiv2bin) pode retornar de 0 a 1023
        nvoindiv1indice = nvoindiv1indice + 1;
        nvoindiv2indice = nvoindiv2indice + 1;
        
        %procurando na matriz decimais qual o valor dos novos individuos
        %referentes aos indices anteriores
        nvoindiv1real = decimais(nvoindiv1indice, 1);
        nvoindiv2real = decimais(nvoindiv2indice, 1);
        
        %substituindo o valor antigo pelo novo
        nvovlrands50(1, poselem1) = nvoindiv1real;
        nvovlrands50(1, poselem2) = nvoindiv2real;
        
         
        
	end; %for i=1:25   

for i=1:max(size(vlrands50))
    hold on;            
	x = vlrands50(i);
	y = -abs(x.*(sin(sqrt(abs(x)))));
 	plot(x,y,'-rs','LineWidth',0.5,...
                   'MarkerEdgeColor','k',...
                   'MarkerFaceColor','k',...
                   'MarkerSize',5);    
end;    
end;