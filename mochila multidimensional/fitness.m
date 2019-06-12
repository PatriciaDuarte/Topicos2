function [result, pesos] = fitness(solucao)
    global nItens
    global nCompartimentos
    global capacidades
	global beneficios
	global itensPorCompartimento

	result = 0;
	pesos = zeros(1, nCompartimentos);
    % somar os pesos por compartimento
	for i = 1 : nCompartimentos
		for j = 1 : nItens
			pesos(i) = pesos(i) + (itensPorCompartimento(i,j) * solucao(j));    
		endfor
	endfor

	factivel = true;
    % testar capacidades dos compartimentos
    for i = 1 : nCompartimentos
    	if pesos(i) >= capacidades(i) 
    		factivel = false;
    		break;
    	endif
	endfor

    % se o peso estiver dentro do aceitavel
    if factivel
    	for i = 1 : nItens
			result = result + (beneficios(i) * solucao(i));    
		endfor
    endif

end