
Data = [X Y]
%Separaci??n de caracter??sticas y variables a predecir

%--------------------------------------------------------------------------

Rept = 10;
Nc = 2 ;% n??mero de clases
tiempo = 0;
EfiTest= zeros(1, Rept);
NumArboles = 50;
sensibTest= zeros(1, Rept);
especifi= zeros(1, Rept);
ErrorTest = zeros(1,Rept);
Pres = zeros(1,Rept);
time= tic;
for fold = 1:Rept
    disp(fold)
    %Separaci??n de los conjuntos de entrenamiento y validaci??n
    [ Xtrain , Ytrain, Xtest, Ytest] = splitData(Data,70);
    %----------------------------------------------------------------------
    %------------- Normalizaci??n ------------------------------------------
    %[XtrainN,mu,sigma] = zscore(Xtrain);
    %XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
    %----------------------------------------------------------------------
    %------------- Entrenamiento ------------------------------------------  
    perm = randperm(5);
    Modelo = TreeBagger(NumArboles, Xtrain, Ytrain, 'oobpred', 'on','NVarToSample',perm(3));     % Obteniendo ???r.
    
     %----------------------------------------------------------------------
    %------------- Validaci???n ---------------------------------------------
    
    Yest = predict(Modelo, Xtest);        % Invocaci???n a la validaci???n.
    Yest = convertcell2double(Yest);            % M???todo de utilidad.
    
   MatrizConfusion = zeros(Nc,Nc);
   for i=1:size(Xtest,1)
     MatrizConfusion(Yest(i)+1,Ytest(i)+1) = MatrizConfusion(Yest(i)+1,Ytest(i)+1) + 1;
   end
   EfiTest(fold) = sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));
   sensibTest(fold) = (MatrizConfusion(1,1)/sum(MatrizConfusion(1,1)+MatrizConfusion(2,1)));
   especifi(fold) = (MatrizConfusion(2,2)/sum(MatrizConfusion(2,2)+MatrizConfusion(1,2)));
   Pres(fold) = MatrizConfusion(1,1) / ( (MatrizConfusion(1,1) +MatrizConfusion(1,2)));
   
   
end
tiempoEnt = tiempo/Rept;
Efi = mean(EfiTest);
IC = std(EfiTest);
sensi = mean(sensibTest);
IcSensi = std(sensibTest);
especi = mean (especifi);
IcEspe = std(especifi);
presi = mean(Pres);
IcPresi = std(Pres);

disp(tiempoEnt);
toc(time);
fprintf('El error obtenido fue = %3.3f  +- %3.3f \n ', 1-Efi,IC);
fprintf('El Eficiencia obtenido fue = %3.3f  +- %3.3f \n', Efi,IC);
fprintf('La sensibilidad obtenida = %3.3f +- %3.3f \n', sensi,IcSensi);
fprintf('La especificidad obtenida = %3.3f +- %3.3f \n', especi,IcEspe);
fprintf('La presicion obtenida = %3.3f +- %3.3f \n', presi,IcPresi);