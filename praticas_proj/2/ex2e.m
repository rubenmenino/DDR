Re = 100000;
Se = 10000;
pe = 24;
lambdae = 100000/24;
ne = 7;
We = 0;
fname='movies.txt';
for j=1:1
    [bHD(j) b4K(j)] = simulator2(lambdae,pe,ne,Se,We,Re,fname);
end
alfa= 0.1; %90% confidence interval%
media4k = mean(b4K);
mediahd = mean(bHD);

fprintf('n = %.1e W = %.1e\n',ne,We)
fprintf('blocking probability 4K = %.4e\n',media4k)
fprintf('blocking probability HD = %.10e\n',mediahd)