function D=Unwrap2D(A)

S=size(A);
S=S.*2;

fx = 1/(S(1)-1)*[-S(1)/2:S(1)/2-1];
    fy = 1/(S(2)-1)*[-S(2)/2:S(2)/2-1];
    [X, Y] = meshgrid(fy, fx);
        K = X.^2 + Y.^2 + eps;
        K = fftshift(K);
        
D= [[exp(1i.*A),fliplr(exp(1i.*A))];flipud([exp(1i.*A),fliplr(exp(1i.*A))])];
D = ifftn( fftn(imag(ifftn(K.*fftn(D))./D))./K );
D=D(1:size(K,1)/2,1:size(K,2)/2);
Q = round( (D - A)/(2*pi) );
D = abs(A + 2*pi*(Q)); 