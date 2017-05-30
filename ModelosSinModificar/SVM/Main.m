
clc
%clear all
close all

Rept=10;

punto=input('Ingrese 1 para regresi???n ??? 2 para clasificaci???n: ');
boxConstraint=100;%[0.01 0.1 1 10 100];
for gamma=[0.01 0.1 1 10 100];
    if punto==2
        
        %%% punto clasificaci???n %%%
        
        NumClases=length(unique(Y)); %%% Se determina el n???mero de clases del problema.
        EficienciaTest=zeros(1,Rept);
        NumMuestras=size(X,1);
        rng('default');
        particion=cvpartition(NumMuestras,'Kfold',Rept);
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
            
        end
        Eficiencia = mean(EficienciaTest);
        IC = std(EficienciaTest);
        Texto=['La eficiencia obtenida fue = ', num2str(Eficiencia),' +- ',num2str(IC)];
        disp(Texto);
        
        %%% Fin punto de clasificaci???n %%%
        
    end
end


