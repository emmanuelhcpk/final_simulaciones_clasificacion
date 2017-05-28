clc;
clear all;
close all;
a=readtable('crx.data.txt');
[~,numcolumnas] = size(a);
columnascontinuas = [2,3,8,11,14,15] % columnas con valores continuos
X = zeros(690,1)
Y = []
a = completarMatriz(a, columnascontinuas);
for i=1:(numcolumnas) % Cambia las clases por valores numericos mediante 1-to-k
    column = a(:,i);
    if(i ~= columnascontinuas)
        categorias = unique(column);
        [nromuestras, ~] = size(column);
        arr = zeros(nromuestras, 1);
        for j=1:size(categorias)
            arr = arr + ismember(column, categorias(j))*j;
        end
        vectors = length(arr);
        column = full(sparse(arr,1:vectors,ones(1,vectors)))';
    end
    if(iscell(column))
        column = str2double(column);
    end
        
    X = horzcat(X,column);
end
Y = X(:, 48);
X = X(:,2:47);

save('datos.mat', 'X', 'Y');
%for i = 1:sizeKeys
%    a(:,1) == keys(i,1)
%end


%[~, loc] = ismember(a(:,1), unique(a(:,1))) % carga las categorias de la primera fila a,b
%y_one_hot = ind2vec(loc')'
%array2table(full(y_one_hot), 'VariableNames', unique(a(:,1)))


%b=a;
%b(:,[2,15,16])=[];
%DatosBalanceados=table2array(a)
%X=DatosBalanceados(:,(1:15))
%Y=DatosBalanceados(:,16)
%save('datos.mat')