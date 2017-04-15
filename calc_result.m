function I = calc_result(a,b)
%calc_result - Description
%
% Syntax: I = calc_result(i,j)
%
% Long description
    global Xlim;
    global Ylim;
    global Zlim;
    global Xdiv;
    global Ydiv;
    global Zdiv;
    global Xsize;
    global Ysize;
    global Zsize;
    global Xl;
    global Yl;
    global Zl;
    global Xr;
    global Yr;
    global Zr;
    I = zeros(Xsize,Ysize,Zsize,'single');
    X = zeros(Xsize,Ysize,Zsize,'single');
    Y = zeros(Xsize,Ysize,Zsize,'single');
    X0 = zeros(Xsize,Ysize,Zsize,'single');
    Y0 = zeros(Xsize,Ysize,Zsize,'single');
    X1 = zeros(Xsize,Ysize,Zsize,'single');
    Y1 = zeros(Xsize,Ysize,Zsize,'single');
    D1 = zeros(Xsize,Ysize,Zsize,'single');
    D2 = zeros(Xsize,Ysize,Zsize,'single');
    D3 = zeros(Xsize,Ysize,Zsize,'single');
    D4 = zeros(Xsize,Ysize,Zsize,'single');
    D = zeros(Xsize,Ysize,Zsize,'single');
    Z = zeros(Xsize,Ysize,Zsize,'single');
    data = xlsread(['data_laser_scan\analysis_',num2str(a),'_',num2str(b),'.xlsx']);
    D4 = 1;
    D1 = norm([a-Xl,b-Yl,1]);
    for i = 1:Xsize
        X(i,:,:)=Xlim(1) + (i-1)*Xdiv;
    end
    for i = 1:Ysize
        Y(:,i,:)=Ylim(1) + (i-1)*Ydiv;
    end
    for i = 1:Zsize
        Z(:,:,i)=Zlim(1) + (i-1)*Zdiv;
    end
    X0 = a;
    Y0 = b;
    X1 = Xr;
    Y1 = Yr;
    I = gpuArray(I);
    X = gpuArray(X);
    Y = gpuArray(Y);
    Z = gpuArray(Z);
    X0 = gpuArray(X0);
    Y0 = gpuArray(Y0);
    X1 = gpuArray(X1);
    Y1 = gpuArray(Y1);
    D1 = gpuArray(D1);
    D2 = gpuArray(D2);
    D3 = gpuArray(D3);
    D4 = gpuArray(D4);
    D= gpuArray(D);
    for i = 1:size(data,1)
        D = data(i,3)*0.01+4.0932;
        D2 = sqrt((X-X0).^2+(Y-Y0).^2);
        D3 = sqrt((X-X1).^2+(Y-Y1).^2);
        D = abs(D1+D2+D3+D4-D);
        D(D>0.001)=0;
        D(D~=0)=1;
        I = I + D.*D2.*D3.*data(i,4);
    end
    I = gather(I);
end