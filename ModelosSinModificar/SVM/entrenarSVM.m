function Modelo = entrenarSVM(X,Y,tipo,boxConstraint,sigma)
    %Kernel para clasificaci?n%
    
    Modelo=trainlssvm({X,Y,tipo,boxConstraint,sigma,'RBF_kernel'});
end
