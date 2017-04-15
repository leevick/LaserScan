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
Xlim = [0,1];   %X 网格范围
Ylim = [0,1];   %Y 网格范围
Zlim = [0,1];   %Z 网格范围
Xdiv = 0.01;    %X 精度
Ydiv = 0.01;    %Y 精度
Zdiv = 0.01;    %Z 精度
Xsize = ceil((Xlim(2)-Xlim(1))/Xdiv)+1; %网格矩阵维度1
Ysize = ceil((Ylim(2)-Ylim(1))/Ydiv)+1; %网格矩阵维度2
Zsize = ceil((Zlim(2)-Zlim(1))/Zdiv)+1; %网格矩阵维度3
Xl = 1; %激光器x坐标
Yl = 1; %激光器y坐标
Zl = 1; %激光器z坐标
Xr = 1; %接收器x坐标
Yr = 1.03; %接收器y坐标
Zr = 1; %接收器z坐标
I = zeros(Xsize,Ysize,Zsize,'single');  %结果矩阵
cells = cell(11,1);
for i=1:11
    for j=1:11
    disp([i,j]);
        I = I + calc_result(i,j);
    end
end
