%Script para pruebas de clasificación Taller No 3. Asignatura Simulación de
%Sistemas, Dpto. Ingeniería de Sistemas, Universidad de Antioquia.

load('Data.mat');
M = 6;
disp(Data(1,1));
%Separación de características y variables a predecir
X = Data(:,1:6);
Y = Data(:,end);
%--------------------------------------------------------------------------
Nd = size(X,1); % Número de muestras en la base de datos
Nc = length(unique(Y)); %Número de clases
Rept = 10;
ErrorTest = zeros(1,Rept);

MatrizConfusionAcumulada = zeros(Nc,Nc);
cv = cvpartition(Nd,'Kfold',Rept); %Generación de folds para crossvalidation
for fold = 1:Rept
    %Separación de los conjuntos de entrenamiento y validación
    Xtrain = X(cv.training(fold),:);
    Xtest = X(cv.test(fold),:);
    Ytrain = Y(cv.training(fold));
    Ytest = Y(cv.test(fold));
    %----------------------------------------------------------------------
    %------------- Normalización ------------------------------------------
    [XtrainN,mu,sigma] = zscore(Xtrain);
    XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
    %----------------------------------------------------------------------
    %------------- Entrenamiento ------------------------------------------
    
    Modelo = EntrenarAD(X,Y);
    %disp('MODELO: ');
    %disp(Modelo.Clase(1).mix)
    %disp('--------------------');
    %----------------------------------------------------------------------
    %------------- Validación
    %---------------------------------------------
    Yest = ValidarAD(Modelo,XtestN);
    %disp('VALIDACION: ');
    %disp(Yest');
    %disp('--------------------');
   %-----------------------------------------------------------------------
   %-------------- Cálculo del error --------------------------------------
   MatrizConfusion = zeros(Nc,Nc);
   for i=1:size(Xtest,1)
       MatrizConfusion(Yest(i),Ytest(i)) = MatrizConfusion(Yest(i),Ytest(i)) + 1;
   end
   disp('Matriz de confusi�n: ');
   disp(MatrizConfusion);
   MatrizConfusionAcumulada = MatrizConfusionAcumulada + MatrizConfusion;
   disp('--------------------');
   
   EfiTest(fold) = sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));
end
disp('Matriz de confusi�n acumulada: ');
disp('--------------------');
disp(MatrizConfusionAcumulada);
Efi = mean(EfiTest);
IC = std(EfiTest);
disp('El error obtenido fue = ');
disp(num2str(1-Efi));
disp(' +- ');
disp(num2str(IC));
    