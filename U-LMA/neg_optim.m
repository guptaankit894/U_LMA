function[bpr]=neg_optim(x_new)
rng(0);
W=rand(3,3);
y0=W*x_new;
W=W/sqrt(norm(W*W));
y=zeros(size(y0));
for it=1:1000
    if y ~= y0
        W=1.5*W-0.5*(W*W')*W;
        y=W*x_new;
    end
end
bpr=y(2,:);

return
