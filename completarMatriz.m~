function matrizCompleta = completarMatriz(a, columnascontinuas)
    [nroFilas, nroColumnas] = size(a)
    matrizCompleta = num2cell(zeros(nroFilas,nroColumnas));
    for k=1:(nroColumnas)
        columna = table2array(a(:,k));
        if(~ismember(columnascontinuas, k)) % si es una variable categorica
            indexCompleta = ~ismember(columna, '?'); % Indice de los elementos en la matriz diferentes de ?
            columna = remplazarLetras(columna) % remplaza clasificadores de dos o mas letras por una sola
            moda = mode(cell2mat(columna(indexCompleta))); % Halla la moda de los datos existentes
            columna(ismember(columna,'?')) = {moda};
        else
            if(iscell(columna)) % si contiene un ?
                indexCompleta = ~ismember(columna, '?'); % Indice de los elementos en la matriz diferentes de ? 
                columnaNumerica = str2double(columna(indexCompleta)) % Se combierten a doubles todos los valores numericos en la matriz
                media = mean(columnaNumerica); % Se halla la media
                columna(ismember(columna, '?')) = {media}%se remplezan los valores de ? por la media
            else
                columna = arrayfun(@num2str, columna, 'Uniform', false);
            end
        end
        matrizCompleta(:,k) = columna;
    end
end