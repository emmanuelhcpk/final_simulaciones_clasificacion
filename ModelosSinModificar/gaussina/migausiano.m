function Yest= migausiano(Xtrain,Xval,Ytrain)


labels= unique(Ytrain);
Ne= length(labels);
for i =1:Ne
    Xtem=Xtrain(Ytrain==labels(i),:);
    Modelo(i).media= mean(Xtem);
    Modelo(i).cova= cov(Xtem);
end
%vect[];
[N,D]= size(Xval);
for j=1:N
    
    f1=(1/(2*(pi^(D/2))*det(Modelo(1).cova)^0.5))* exp(-0.5*(Xval(j,:)-Modelo(1).media)*inv(Modelo(1).cova)*(Xval(j,:)-Modelo(1).media)');
    f2=(1/(2*(pi^(D/2))*det(Modelo(2).cova)^0.5))* exp(-0.5*(Xval(j,:)-Modelo(2).media)*inv(Modelo(2).cova)*(Xval(j,:)-Modelo(2).media)');
    if f1>f2,

        Yest(j) = 0;
    
    else

        Yest(j) = 1;
    end
end

Yest = Yest';

end
