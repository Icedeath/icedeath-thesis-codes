var= vars;
k=8;
ix = 1:25;
[idx,C]=kmeans(var',k);

means=zeros(k,1);
for i = 1:k
    means(i,1)=mean(var(idx==i));
end

id = 1:k;
j = id(means==min(means));
fe_idx = ix(idx==j)