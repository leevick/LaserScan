clear
clc
xlsstr={};
xlsdata={};
a=dir;
b=struct2cell(a);
c=b(1,:);
[h,l]=size(c);
jj=0;
%%%%%%%%%%%% divide the volumn into voxels of 0.1*0.1*0.1 and initial all
%%%%%%%%%%%% f(x,y,z) to 1
RecSpa=xlsread('..\reconstruction_space.xlsx');
RecSpa = single(RecSpa);
RecSpa = gpuArray(RecSpac);

[RSsize,xx]=size(RecSpa);
f=zeros(100*100*100,1);
xl=1
yl=1;
zl=1;
xr=1;
yr=1.03;
zr=1;
xrw=1;
yrw=1.03;
zrw=0;
%%%%%%%%%%%%%% receiver ponit on the wall is fixed at 
zlw=0;
XLW=0.5:0.1:1.5;
YLW=0.5:0.1:1.5;
RV=[xr-xrw yr-yrw zr-zrw];
d4=norm(RV);
ValueI=zeros(1000000,1);
  
for ii=1:l
    if strfind(c{ii},'.xlsx')
        jj=jj+1
        [xlsstr{jj},xlsdata{jj}]=xlsread(c{ii});
        DATA=xlsstr{jj};
        [m,n]=size(DATA);
        xlw=XLW(DATA(1,1));
        ylw=YLW(DATA(1,2));
        IV=[xlw-xl ylw-yl zlw-zl];
        d1=norm(IV); 
           for j=1:m     
                I=RecSpa-repmat([xlw ylw zlw],[RSsize,1]);
               D2=sqrt(I(:,1).*I(:,1)+I(:,2).*I(:,2)+I(:,3).*I(:,3));
               R=repmat([xrw yrw zrw],[RSsize,1])-RecSpa;
               D3=sqrt(R(:,1).*R(:,1)+R(:,2).*R(:,2)+R(:,3).*R(:,3));
               D=d1+D2+D3+d4;
              d=DATA(j,3)*0.001+4.0932;
              intensity=DATA(j,4);        
              dd=D-d;
              dd(dd<0.001)=1;
              dd(dd~=1)=0;
              Int=repmat(intensity,[RSsize,1]).*D2.*D3;
              Innt=Int.*dd;
              ValueI=ValueI+Innt;
                        end
           end
       end
  
       
