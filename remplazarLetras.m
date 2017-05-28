function columna = remplazarLetras(col)
    columna = col;
    variablesUnicas = unique(col);
    [nroVariables,~] = size(variablesUnicas);
    valoresPosibles = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
    nroValoresPosibles = length(valoresPosibles);
    for j=1:nroVariables
        caracter = cell2mat(variablesUnicas(j));
        len = size(caracter,2);
        if(len > 1)
            for k=1:nroValoresPosibles
                if(~ismember(valoresPosibles(k), variablesUnicas));
                    index = ismember(columna, caracter);
                    columna(index) = {valoresPosibles(k)};
                    variablesUnicas = unique(columna);
                    break
                end
        end
        
    end
end