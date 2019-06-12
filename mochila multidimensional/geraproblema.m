function geraproblema (nItens, nCompartimentos)
	global capacidades
	global beneficios
	global itensPorCompartimento

	% cria vetor de benecifios aleatoriamente
	% os valores de beneficios estara ligado a quantidade de itens
	beneficios = randi(nItens, 1, nItens); % (1 x nItens)

	% gera tabela de pesos por compartimento
	% os valores de peso estara ligado a quantidade de itens
	itensPorCompartimento = randi(nItens, nCompartimentos, nItens); % (nCompartimentos x nItens)

	% cria vetor com pesos maximos de cada compartimento
	% os compartimentos terão capacidade máxima d 70% da soma de todos os itens
	capacidades = round(0.7 * sum(itensPorCompartimento')); % ( 1 x nCompartimentos);
end