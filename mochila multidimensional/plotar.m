function plotar(nGeracao, melhorResultado)
    global capacidades
    global beneficios
    global itensPorCompartimento

    if (nGeracao < 1)
        
        disp ('Beneficios: ');
        disp(num2str(beneficios));
        disp (['Capacidades: ' num2str(capacidades)]);
        
        disp ('Itens por Compartimento: ');
        disp(num2str(itensPorCompartimento));
        disp("-----------------------------------------------");
    endif
    
    disp("");
    disp(["Geração -> " num2str(nGeracao)]);
    disp (["Melhor Resultado: " num2str(melhorResultado)]);
    
    [fit, compartimentos] = fitness(melhorResultado);
    disp (["Fitness do Melhor Resultado: " num2str(fit)]);
    disp (["Uso por compartimento: " num2str(compartimentos)]);
end