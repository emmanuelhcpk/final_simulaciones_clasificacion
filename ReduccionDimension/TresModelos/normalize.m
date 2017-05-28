function matrix = normalize(matrix, mean, std)
    N = size(matrix, 1);            % Obteniendo el tama�o de la matriz.

    % Aplicando la formulaci�n de Normalizaci�n por ZSCORE.
    matrix = (matrix - ones(N, 1) * mean) ./ (ones(N, 1) * std);