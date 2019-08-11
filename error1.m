orig = double(imread('p2.jpg'));
I = [1, 10, 100];
l = zeros(3, 8);
l(1, :) = [0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000];  
l(2, :) = [0.01, 0.05, 0.1, 0.5, 1, 10, 100, 0.001];
l(3, :) = [ 0.001, 0.005, 0.01, 0.05, 0.1, 1, 10, 0.0001];
ms = zeros(size(l, 2),  30, 3);
relms = zeros(size(l, 2),  30, 3);
minm = 100000000 * ones(30, 3);
relminm = minm;
for Ii = 1:1
%   
%     orig = (orig / sum(sum(orig))) * I(Ii);
%     load(strcat(num2str(Ii-1), 'poisson.mat'));
%     
for p = 1: 10

a = double(imread(strcat('p2_',num2str(p), '.jpg')));
% a = double(rgb2gray(a));

% a = poiss(:, :, p)
m = size(a, 1);
%pX = poissrnd(a);
n = size(a, 2);
M = dctmtx(8);

U = kron(M', M');
tot = mean(mean(orig));
% origms = mse(orig, a)
% origrelms = origms / (tot * tot)
c = (m - 7) * (n - 7);





for k = 1:8
    
    an = zeros(64, (m - 7) * (n- 7)); 
    summ = zeros(m, n);
    count = zeros(m, n);
    lambda = l(Ii, k);
    
    parfor b = 1:c
        if mod(b, 20) == 0
           fprintf('%d Completed\n', b);
        end;
        i = floor(b / (n - 7)) + 1;
        j = mod(b, n - 7);
        if j == 0
            i = i - 1;
            j = n - 7;
        end;
        x = a(i:i + 7, j: j + 7);
        x = reshape(x, 64, 1);
        
        theta  = minEstimate(x, lambda, U);
        
        an(:, b) = theta;
    
    end;
    %save(strcat(num2str(lambda), 'an.mat'), 'an');
    for b = 1:(m - 7)*(n - 7)
        i = floor(b / (n - 7)) + 1;
        j = mod(b, n - 7);
        if j == 0
            i = i - 1;
            j = n - 7;
        end;
        theta = U * an(:, b);
        summ(i : i + 7, j : j + 7) = summ(i : i + 7, j : j + 7) + reshape(theta, 8, 8);
        count(i : i + 7, j : j + 7) = count(i : i + 7, j : j + 7) + ones(8);
    end;
    final = summ ./ count;
    imwrite(final/max(max(final)), strcat(num2str(lambda), strcat(num2str(Ii),strcat(num2str(p),'lambda.jpg'))), 'JPEG');
    
    ms(k, p, Ii) = mse(final, orig);
    relms(k, p, Ii) = ms(k, p, Ii) / (tot * tot);
    if minm(p, Ii) > ms(k, p, Ii)
        minm(p, Ii) = ms(k, p, Ii);
        relminm(p, Ii) = relms(k, p, Ii);
    end;
end;
fprintf('MSE for %d %d is %f\n', p, Ii, minm(p, Ii));
fprintf('Rel. MSE for %d %d is %f\n', p, Ii, relminm(p, Ii));
    

end;

end;