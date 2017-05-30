function Modelo = entrenarSVM(X,Y,tipo,boxConstraint,sigma)
    %Kernel para clasificaci?n%
    
    Modelo=trainlssvm({X,Y,tipo,boxConstraint,sigma,'lin_kernel'});
end
