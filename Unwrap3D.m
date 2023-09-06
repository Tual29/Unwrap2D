function D=Unwrap3D(A)

S=size(A);
S=S.*2;

fx = 1/(S(1)-1)*[-S(1)/2:S(1)/2-1];
    fy = 1/(S(2)-1)*[-S(2)/2:S(2)/2-1];
    fz = 1/(S(3)-1)*[-S(3)/2:S(3)/2-1];
    [X, Y, Z] = meshgrid(fy, fx,fz);
        K = X.^2 + Y.^2 + Z.^2 + eps;
        K = fftshift(K);
        
D= [[exp(1i.*A),fliplr(exp(1i.*A))];flipud([exp(1i.*A),fliplr(exp(1i.*A))])];

D=cat(3,D,flip(D,3));


D = ifftn( fftn(imag(ifftn(K.*fftn(D))./D))./K );


D=D(1:size(K,1)/2,1:size(K,2)/2,1:size(K,3)/2);
Q = round( (D - A)/(2*pi) );
D = abs(A + 2*pi*(Q)); 