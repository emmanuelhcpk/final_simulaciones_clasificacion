function criterial = criterio( Xtrain, Ytrain, Xtest, Ytest)

[XtrainN,mu,sigma] = zscore(Xtrain);
XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
Modelo = TreeBagger(20,XtrainN,Ytrain,'Method', 'classification');
CLASS = Modelo.predict(XtestN);
CLASS = str2double(CLASS);

criterial = sum(CLASS ~= Ytest);


