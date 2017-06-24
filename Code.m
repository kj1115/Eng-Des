
a = serial('com5');
set(a,'BaudRate', 9600);
fopen(a);
data = 1000;
cf = 130;
i = 1;
elapsedTime = zeros(1,data);
Q = zeros(1,data);
V = zeros(1,data);
r = 0.03;
Tq = 0;
Ts = zeros(1,data);
figure
pause(0.00001);
frame_h = get(handle(gcf),'JavaFrame');
set(frame_h,'Maximized',1); 
subplot(2,2,1)
s = animatedline;
xlabel('Time (s)')
ylabel('Count')
title('Count vs Time')
subplot(2,2,3)
h = animatedline;
xlabel('Time (s)')
ylabel('Flow Rate (l/s)')
title('Flow Rate vs Time')
subplot(2,2,2)
v = animatedline;
xlabel('Time (s)')
ylabel('Volume (l)')
title('Volume vs Time')
subplot(2,2,4)
w = animatedline;
xlabel('Time (s)')
ylabel(' Flow Rate (l/s)')
title('Filtered flow rate')
MAF_6 = [0,0,0,0,0,0,0];

while(i<=data)
    beat = fscanf(a, '%d');
    volume = beat/cf;
    tic
    speed = 1/elapsedTime(i);
    speed2 = speed*2*pi;
    tspeed = speed2*r;
    Q(i) = cf*tspeed*pi*r^2;
    MAF_6(1) = (MAF_6(2) + MAF_6(3) + MAF_6(4)+ MAF_6(5) + MAF_6(6)+ MAF_6(7))/6;
    MAF_6(2) = MAF_6(3);
    MAF_6(3) = MAF_6(4);
    MAF_6(4) = MAF_6(5);
    MAF_6(5) = MAF_6(6);
    MAF_6(6) = MAF_6(7);
    MAF_6(7) = Q(i);
    Filtered_value = MAF_6(1);
    Ts(i) = Tq + elapsedTime(i);
    Tq = Ts(i);
    addpoints(s,Ts(i),beat);
    drawnow
    addpoints(h,Ts(i),Q(i));
    drawnow
    addpoints(w,Ts(i),Filtered_value);
    drawnow
    addpoints(v,Ts(i),volume);
    drawnow
    i=i+1;
    elapsedTime(i) = toc;
end
fclose(a);






