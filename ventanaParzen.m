function f = ventanaParzen(Xval,Xent,Yent,h,tipo)

    M=size(Xval,1);
    N=size(Xent,1);
    suma1=zeros(N,1);
    suma2=zeros(N,1);
    dis=zeros(N,1);
    f=zeros(M,1);

    if strcmp(tipo,'regress')
    
		for j=1:M
			%%% Complete el codigo %%%
            for i=1:N
                suma1(i)=gaussianKernel(abs(Xval(j)-Xent(i))/h)*Yent(i);
                suma2(i)=gaussianKernel(abs(Xval(j)-Xent(i))/h);
            end
            f(j)=sum(suma1)/sum(suma2);
			%%%%%%%%%%%%%%%%%%%%%%%%%%
		end
    
    elseif strcmp(tipo,'class')
        
        for j=1:M
            %%% Complete el codigo %%%

            %%%%%%%%%%%%%%%%%%%%%%%%%%
        end
        
    end

end
