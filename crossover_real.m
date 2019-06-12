clear all;
close all;
clc;

% Autores: Larissa, Patrícia e Hallefy
% Trabalho de crossover e mutacao em valores reais

tcro = 22;    %tamanho do cromossomo (para termos maior precisao)
pop  = 30;    %tamanho da populacao 30 cromossomos de tamanho 22

geracao = 50;
metade = round((pop+1)/2) - 1;

xmin = -256;  %intervalo minimo
xmax = 512;   %intervalo maximo
format short; %para trabalhar com 4 casas decimais

x1 = -256:512;
y = -abs(x1.*(sin(sqrt(abs(x1)))));
plot(x1,y);

%criando população inicial
for i=1:pop
	  [x(i,:)]        = round(rand(1,tcro)); %gera um vetor com 30 individuos de zeros e uns (decimais)
    [vlrxbi(i,:)]  = dec2bin(x(i,:));       %transforma os decimais gerados em binarios
    [vlrxreal(i,:)] = bin2dec(vlrxbi(i,:));       %gera o valor real de cada binario em real (b10 da formula dos slides)
    [xreal(i,:)]    = xmin + ((xmax - xmin).*vlrxreal(i,:)./(2^tcro - 1)); %mapeia cada x para o intervalo [-256, 512]
    [fitx(i)]       = -abs(xreal(i,:).*(sin(sqrt(abs(xreal(i,:)))))); %calculando o fitness
    
    hold on;
    plot(xreal(i,:),fitx(i),'-ro','LineWidth', 0.5,'MarkerEdgeColor','r','MarkerFaceColor','r', 'MarkerSize',5);
end;    

%achandoo valor de y para cada x do vetor
for k = 1:geracao
  if (k > 1)
    for i = 1:pop
      fitx(i) = -abs(xreal(i).*(sin(sqrt(abs(xreal(i)))))); %calculando o fitness
    end; 
  end;
  
  % achando a soma de fitness da populacao
  s = sum(fitx);
  
  %achando a probabilidade de cada funcao fitness
  for i = 1:pop
    p(i) = fitx(i)/s;
  end;
  
  %probabilidade acumulativa
  c = cumsum(p);
  
  %usando metodo da roleta
  nvoxreal = 0;
  indice = 1;
  poselem = 1;
  while(max(size(nvoxreal))~= pop)
    r = rand;
    if (r < c(1))
      poselem = 1;
    else
      for j = 2:max(size(c))
        if (r > c(j-1)) & (r <= c(j))
          poselem = j;
          break;
        end;
      end;
    end;
    
    nvoxreal(indice) = xreal(poselem);
    indice = indice + 1;
  end;
  
  % fazendo cruzamento da metade dos pares
  for i = 1:metade
    %primeiro pai
    poselem1 = -1;
    r = rand;
    if (r < c(1))
      poselem1 = 1;
    else
      for j = 2:max(size(c))
        if (r > c(j-1)) & (r <= c(j))
          poselem1 = j;
          break;
        end;
      end;
    end;
    
    %segundo pai
    poselem2 = -1;
    r = rand;
    if (r < c(1))
      poselem2 = 1;
    else
      for v = 2:max(size(c))
        if (r > c(v-1)) & (r <= c(v))
          poselem2 = v;
          break;
        end;
      end;
    end;
    
    % pegando 2 valores randomicos no vetor 
    indiv1real = nvoxreal(poselem1);
    indiv2real = nvoxreal(poselem2);
    
    % crossover por média
    %if (fitx(1,poselem1) < fitx(1,poselem2))
    %   nvoxreal(1,poselem1) = (indiv1real + indiv2real)./2;  
    %else
    %   nvoxreal(1,poselem2) = (indiv1real + indiv2real)./2;
    %end;
 
    % crossover heuristico 
    % c = p1 + r(p1 - p2 ) onde fit(p1) > fit(p2) e r?U(0,1). 
    c1 = xmin-1;
    % verifica qual o pai com o pior fitness, para ser substituido
    if (fitx(1,poselem1) < fitx(1,poselem2))
      % verifica se esta fora do intervalo
      while (c1 < xmin || c1 > xmax)
        r = rand;
        c1 = indiv2real + r.*(indiv2real - indiv1real);   
      endwhile;
      % atribui o filho no lugar do pior pai
      nvoxreal(1,poselem2) = c1;  
    else
      % verifica se esta fora do intervalo
      while (c1 < xmin || c1 > xmax)
        r = rand;
        c1 = indiv1real + r.*(indiv1real - indiv2real);
      endwhile; 
      % atribui o filho no lugar do pior pai
      nvoxreal(1,poselem1) = c1;
    endif;    
  endfor;
  
  
  % seleciona cromossomo aleatorio para mutacao
  pos = round(pop.*rand);
  while (pos < 1)
    pos = round(pop.*rand);
  endwhile;
  
  % converte real para string para selecionar gene separadamente
  numstring = num2str(nvoxreal(pos));
  
  % seleciona gene aleatorio para mutacao
  posgene = round(size(numstring,2).*rand);
  while (posgene < 1)
    posgene = round(size(numstring,2).*rand);
  endwhile;
  
  if ((numstring(posgene) == '.') || (numstring(posgene) == '-'))
    posgene = posgene + 1;
  endif;
  
  % mutacao creep alternativa, com a adicao de r?U(0,1)
  r = rand;
  numstring(posgene) = num2str(round(str2num(numstring(posgene)).*r));
  mutado = str2num(numstring);
  while (mutado < xmin || mutado > xmax)
    numstring = num2str(nvoxreal(pos));
    r = rand;
    numstring(posgene) = num2str(round(str2num(numstring(posgene)).*r));
    mutado = str2num(numstring);
  endwhile;
  
  nvoxreal(pos) = mutado;
  xreal = nvoxreal;
end;

for i = 1:pop
  hold on;
  x = xreal(i);
  y = -abs(x.*(sin(sqrt(abs(x)))));
  plot(x,y,'-ro','LineWidth', 0.5,'MarkerEdgeColor','c','MarkerFaceColor','c', 'MarkerSize',5);
end;