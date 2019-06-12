function[nvovlrands50] = mutacao(nvovlrands50, decimais)

  matrizbinarios = zeros(1,50);

  for i = 1:size(nvovlrands50,2)
    indiv1real = nvovlrands50(1, i);
    indiv1indice = find(decimais == indiv1real);
    indiv1indice = indiv1indice-1;
    indiv1bin = dec2bin(indiv1indice, 10);
  
    for(j=1:10)
      r=rand;
      if(r<=0.01)
        if(indiv1bin(1, j)==1)
          indiv1bin(1, j)='0';
        else
          indiv1bin(1, j)='1';
      end;
    end;
  end;
  matrizbinarios(1, i) = str2num(indiv1bin);
end;

for i=1:size(nvovlrands50, 2)
  nvoindiv1bin = int2str(matrizbinarios(1, i));
  nvoindiv1indice = bin2dec(nvoindiv1bin);
  nvoindiv1indice = nvoindiv1indice +1;
  nvoindiv1real = decimais(nvoindiv1indice, 1);
  nvovlrands50(1, i) = nvoindiv1real;
end;