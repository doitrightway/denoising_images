orig = double(imread('p2.jpg'));    
I = [1000, 10000, 100000];
l = zeros(2, 5);
l(1, :) = [0.5, 0.1, 0.5, 1, 10];
l(2, :) = [0.5, 0.01, 0.05, 0.1, 10];
l(3, :) = [0.5, 0.01, 0.05, 0.1, 10];
 ms1 = zeros(size(l, 2),  30, 3);
relms1 = zeros(size(l, 2),  30, 3);
minm1 = 100000000 * ones(30, 3);
    relmin1 = minm1;
for Ii = 0:0

    orig = (orig / sum(sum(orig))) * I(Ii);
    load(strcat(num2str(Ii), 'poisson.mat'));

for p = 6:10

% a = double(imread('Poissonp22.jpg'));
% a = double(rgb2gray(a));

a = poiss(:, :, p);
m = size(a, 1);
%pX = poissrnd(a);
n = size(a, 2);
M = dctmtx(8);

U = kron(M', M');
tot = mean(mean(orig));
% origms = mse(orig, a)
% origrelms = origms / (tot * tot)
c = (m - 7) * (n - 7);





for k = 1:1
    tic;
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
    imwrite(final/255, strcat(num2str(lambda), strcat(num2str(Ii),strcat(num2str(p),'lambda.jpg'))), 'JPEG');
    
    ms1(k, p, Ii) = mse(final, orig);
    relms1(k, p, Ii) = ms1(k, p, Ii) / (tot * tot);
    if minm1(p, Ii) > ms1(k, p, Ii)
        minm1(p, Ii) = ms1(k, p, Ii);
        relmin1(p, Ii) = relms1(k, p, Ii);
        
    end;
    toc
end;
fprintf('MSE for %d %d is %f\n', p, Ii, minm1(p, Ii));
fprintf('Rel. MSE for %d %d is %f\n', p, Ii, relminm1(p, Ii));
    

end;

end;