function faultDigModel
clc; clear all; close all; warning off; %#ok
%fault diag model for preserving

FileName = 'dimUpdate.mat' ;
dttt = 0.2 ;
figu = 1 ;

global AAr;
AAr = [0:360]*pi/360 ;
load(FileName) ;
L = size(LASER) ; L=L(1) ;
Time = double(TLsr) ; clear TLsr;
horoz = cos(AAr) ;
vert = sin(AAr) ;
coverage=LASER;
global pCircles ;
nc = 9 ; aaa = [0:nc]*2*pi/nc ; pCircles = [ cos(aaa); sin(aaa) ] ;
s_input = struct('V_POSITION_X_INTERVAL',[-50 50],...%(m)
    'V_POSITION_Y_INTERVAL',[-50 50],...%(m)
    'V_SPEED_INTERVAL',[0.2 1],...%(m/s)
    'V_PAUSE_INTERVAL',[4 5],...%pause time (s)
    'V_WALK_INTERVAL',[4.00 6.00],...%walk time (s)
    'V_DIRECTION_INTERVAL',[-180 180],...%(degrees)
    'SIMULATION_TIME',10,...%(s)
    'NB_NODES',1);

figure(1) ;
for i=1:L,
    
    zoom on ;
    nodeMove =plot(0,0,'+','erasemode','xor') ;   %coverage range
    hold on;
    hhh1 =plot(0,0,'+') ;
    hold on;
    hhh2=plot(0,0,'ro','erasemode','xor') ;  % landmarks centers
    hold on;
    hhh3=plot(50,5,'g') ;   % approx. landm. circles
    hold on;
    
    
    %
    
    
    
    
    Mask13 = uint16(2^13 -1) ;
    MaskA  = bitcmp(Mask13,16) ;
    
    
    RR = double(  bitand( Mask13,coverage(i,:)) ) ;
    a  = uint16(  bitand( MaskA ,coverage(i,:)) ) ;
    ii = find(a>0) ;
    RR = RR/100 ;
    xra=detectFaults(RR) ;
    
    ii2 = find(RR<75) ;
    xx = RR(ii2).*horoz(ii2) ;
    yy = RR(ii2).*vert(ii2) ;
    hold on;
    set(nodeMove,'XData',xx,'YData',yy) ;
    
    hold on;
    s_mobility = MobileRobot(s_input);
    timeStep = 0.01;%(s)
    hold on;
    RobotDesign(s_mobility,s_input,timeStep);
    xl = xra(1,:).*cos(xra(2,:)) ;
    yl = xra(1,:).*sin(xra(2,:)) ;
    set(hhh2,'XData',xl,'YData',yl) ;
    RobotDefectFinder(xl,yl,xra(3,:),hhh3) ;
    
    
    axis([-100,100,-100,100]);
    
    
    
    pause(dttt) ;
    
    
    
    
    
end;
%axis([-50,50,-50,50]);







% --------------------------------------------


function RobotDefectFinder(xl,yl,rl,hdl)
global pCircles ;
xyCi = pCircles ;
nc = size(xyCi) ; nc = nc(2) ;
nl = length(xl) ;
u=1 ;
z=1 ;
xyAllC = zeros(2,nc*nl+nl) ;
xxx    = zeros(2,nl) ;

for i=1:nl,
    Ri=rl(i)*0.6 ;
    xyCi(1,:)= pCircles(1,:)*Ri + xl(i) ;
    xyCi(2,:)= pCircles(2,:)*Ri + yl(i) ;
    xyAllC(:,u:u+nc-1)=xyCi ;
    xxx(:,nl-i+1) = xyCi(:,1) ;
    u=u+nc ;
end ;
xyAllC(:,u:end) = xxx ;
set(hdl,'XData',xyAllC(1,:),'YData',xyAllC(2,:)) ;
return ;
% --------------------------------------------