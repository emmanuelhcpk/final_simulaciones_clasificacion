
clc
%clear all
close all
Rept=10;
boxConstraint=100;%[0.01 0.1 1 10 100];
eficiencia = zeros(10,1);
sensibTest= zeros(1, Rept);
especifi= zeros(1, Rept);
error = zeros(10,1);
for gamma=[0.01 0.1 1 10 100];
    NumClases=length(unique(Y)); %%% Se determina el n???mero de clases del problema.
    EficienciaTest=zeros(1,Rept);
    NumMuestras=size(X,1);
    rng('default');
    particion=cvpartition(NumMuestras,'Kfold',Rept);
    disp('el gamma')
    gamma
    for fold=1:Rept

        %%% Se hace la partici???n de las muestras %%%
        %%%      de entrenamiento y prueba       %%%
        Xtrain=X(particion.training(fold),:);
        Xtest=X(particion.test(fold),:);
        Ytrain=Y(particion.training(fold),:);
        Ytest=Y(particion.test(fold));

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%% Se normalizan los datos %%%

        [Xtrain,mu,sigma]=zscore(Xtrain);
        Xtest=(Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        Modelo = entrenarSVM(Xtrain,Ytrain,'classification',boxConstraint,gamma);
        Yest = testSVM(Modelo,Xtest);

        MatrizConfusion=zeros(NumClases,NumClases);
        for i=1:size(Xtest,1)
            MatrizConfusion(Yest(i)+1,Ytest(i)+1)=MatrizConfusion(Yest(i)+1,Ytest(i)+1) + 1;
        end
        EficienciaTest(fold)=sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));
        sensibTest(fold) = (MatrizConfusion(1,1)/sum(MatrizConfusion(1,1)+MatrizConfusion(2,1)));
        especifi(fold) = (MatrizConfusion(2,2)/sum(MatrizConfusion(2,2)+MatrizConfusion(1,2)));


    end
    Eficiencia = mean(EficienciaTest);
    IC = std(EficienciaTest);
    sensi = mean(sensibTest);
    IcSensi = std(sensibTest);
    especi = mean (especifi);
    IcEspe = std(especifi);
    Texto=['La eficiencia obtenida fue = ', num2str(Eficiencia),' +- ',num2str(IC)];
    disp(Texto);
    fprintf('La sensibilidad obtenida = %3.3f +- %3.3f \n', sensi,IcSensi);
    fprintf('La especificidad obtenida = %3.3f +- %3.3f \n', especi,IcEspe);
    

    %%% Fin punto de clasificaci???n %%%

    
end


