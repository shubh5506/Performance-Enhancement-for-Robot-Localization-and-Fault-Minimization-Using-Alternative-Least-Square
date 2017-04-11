clear all;
close all;
clc;
    data = xlsread('data.csv', 'Data', 'A:H'); % Read curve's points from the Excel file
    dataU = data(:,1); % Extract RowCo-ordinate
    dataI = data(:,2); % Extract col
    clear data
    
    %Define fault rate
    Va = 0:0.01:1.665;
    
    Ns = 4; %
    Va0 = 0:0.01:0.665; % Voltage vector of one cell [V]
    Ia1 = faultDetectedParameterMachine(Va0,1,25); % Compute current from voltage vector [A]

    %Do "coerce" to limit extrap values to positive values
    Va1 = max(Ns*interp1(Ia1, Va0, 0:0.001:ceil(max(Ia1)*100)/100, 'linear', 'extrap'), 0);

    Ia2 = faultDetectedParameterMachine(Va0,1,50);
    Va2 = max(Ns*interp1(Ia2, Va0, 0:0.001:ceil(max(Ia2)*100)/100, 'linear', 'extrap'), 0);

    Ia3 = faultDetectedParameterMachine(Va0,0.8,25);
    Va3 = max(Ns*interp1(Ia3, Va0, 0:0.001:ceil(max(Ia3)*100)/100, 'linear', 'extrap'), 0);

    Ia4 = faultDetectedParameterMachine(Va0,0.5,25);
    Va4 = max(Ns*interp1(Ia4, Va0, 0:0.001:ceil(max(Ia4)*100)/100, 'linear', 'extrap'), 0);

    Ia5 = faultDetectedParameterMachine(Va0,0.2,25);
    Va5 = max(Ns*interp1(Ia5, Va0, 0:0.001:ceil(max(Ia5)*100)/100, 'linear', 'extrap'), 0);

    figure('Color', 'w')
    title('fault Detection rate minimization as per coverage distance')
    hold on
    plot(Va1,0:0.001:ceil(max(Ia1)*100)/100, 'k')
    plot(Va2,0:0.001:ceil(max(Ia2)*100)/100, 'c')
    plot(Va3,0:0.001:ceil(max(Ia3)*100)/100, 'r')
    plot(Va4,0:0.001:ceil(max(Ia4)*100)/100, 'g')
    plot(Va5,0:0.001:ceil(max(Ia5)*100)/100, 'b')
    xlabel('Energy Level');
    ylabel('Fault Detection Rate');
    legend({'Model @ 1000 mm / 25°C' ...
            'Model @ 1000 mm / 50°C', ...
            'Model @ 800 mm / 25°C', ...
            'Model @ 500 mm / 25°C', ...
            'Model @ 200 mm / 25°C'}, ...
            'Location', 'NorthWest');
    grid on
    
n = 1000; d = Ns; mu0 = zeros(d,1); Sigma0=diag(ones(d,1)); X = randn(n,d);
w0 = mvnrnd(mu0, Sigma0)'; %ground truth hyperplane
z0 = randn(n,1) + X*w0;    %ground truth z_i
y = sign(z0);              %ground truth labels \in {+1,-1}
%% machiene 
machineEff=1e2; w=zeros(d,machineEff);
%sigmoid function
sigm = @(X,y,w) 1./(1+exp(-y.*(X*w)));
%init w
w(:,1)=zeros(d,1);

%prior / regularization for numerical stability
lambda=1e-4; vInv = 2*lambda*eye(d);

for k=1:machineEff
    
    mu_k = sigm(X,y,w(:,k));        %bernoulli probability   
    Sk = mu_k.*(1-mu_k) + eps;      %weight matrix 
    z_k = X*w(:,k)+(1-mu_k).*y./Sk; %response update
    
    %w(:,k+1)=inv(X'*Sk*X + vInv)*(X'*Sk*z_k); %w update
    Xd=X'*sparse(diag(Sk)); R=chol(Xd*X+vInv);
    w(:,k+1)=R\(R'\Xd*z_k);
    
    %check convergence
    fprintf('iteration: %d, |Fault minimization Rate|= %.6f\n', k, norm(w(:,k+1)-w(:,k),2));
    if (norm(w(:,k+1)-w(:,k),2) < 1e-6), break; end
end
w=w(:,1:k);

%% compute MSE
MSE = (cummean(w,2)-repmat(w0,1,size(w,2))).^2;

%% plot MSE
figure; legendInfo={};
for dim=1:d
    legendInfo{dim} = ['dim = ', num2str(dim)];
    plot(1:size(w,2),MSE(dim,:),'color',rand(1,3),'linewidth',2.0); hold on; grid on;
end
xlabel('iterations'); ylabel('MSE'); legend(legendInfo);
title('MSE vs iterations for Least Square Machine learning for faults');
xlim([1 4]);