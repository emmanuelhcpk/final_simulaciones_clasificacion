muestras = [X Y];

%X1 = muestras(:, 1:end-1);
%Y1 = muestras(:, end);
%----- First output.

opts = statset('display','iter');

indices  = sequentialfs(@criterio, X, Y,'options',opts);

indices = [indices,1];

muestrasSFS = muestras(:,(indices==1));
