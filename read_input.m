function [Xo, Yo, Zo, Umag0, theta, phi, omgX, omgY, omgZ] = read_input(inputfile,shot_num)
param = importdata(inputfile, ' ', 5);
if all(shot_num ~= param.data(:,1)) 
    disp('Invalid shot number');
    Xo = NaN;
    Yo = NaN;
    Zo = NaN;
    Umag0 = NaN;
    theta = NaN;
    phi = NaN;
    omgX = NaN;
    omgY = NaN;
    omgZ = NaN;
    return;
else
    Xo = param.data(shot_num,2);
    Yo = param.data(shot_num,3);
    Zo = param.data(shot_num,4);
    Umag0 = param.data(shot_num,5);
    theta = param.data(shot_num,6);
    phi = param.data(shot_num,7);
    omgX = param.data(shot_num,8);
    omgY = param.data(shot_num,9);
    omgZ = param.data(shot_num,10);
end
end
