% function Modelo = EntrenarGMM(Xtrain,Ytrain,Nc,M) entrena un sistema de
% clasificación basado en GMMs. 
%
% Inputs:
%
%           Xtrain es una matriz que contiene los datos de entrenamiento,
%           las columnas son caracteríasticas y las filas son muestras.
%
%           Ytrain son las etiquetas de clase de cada unas de las muestras
%           en Xtrain.
%
%           Nc es el número de clases a reconocer
%
%           M es el número de funciones Gausianas a utilizar en los GMMs
%
% Salidas:
%
%           Modelo es una estructura que contiene el modelo por cada clase
%           Ej:
%
%           Modelo.Clase(1).mix
%
%           mix es la estructura retornada por el toolbox netlab.



function Modelo = EntrenarAD(X,Y)
Modelo = classregtree(X,Y,'method','classification');
view(Modelo)