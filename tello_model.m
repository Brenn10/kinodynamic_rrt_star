dt = 0.05;
Ad = diag([1.0, 1.0, 1.0, 0.97, 0.97, 0.97]);
Ad(1:3, 4:6) = dt * eye(3);
Bd = [zeros(3); diag([0.055, 0.055, 0.095])];
Cd = zeros(1,6);
Dd = zeros(1,3);
dsys = ss(Ad,Bd,Cd,Dd,"Ts",.05)
csys = d2c(dsys)
A = csys.A;
B=csys.B;
vel_limits = [-8.,.8;-.8,.8;-.8,.8];
input_limits = vel_limits;
save("drone_model.mat","A", "B","input_limits","vel_limits")