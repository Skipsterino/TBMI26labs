function H = adaBoost(x, y, haar)

T = 50;

M = length(y);

d = ones(M,T)/M;

eOpt = ones(T,1)*Inf;
pOpt = ones(T,1);
thresholdOpt = zeros(T,1);
h = zeros(M,T);
alph = zeros(T,1);
haarOpt = zeros(T,1);

for t = 1:T
    for haf=1:haar
        inp = x(haf,:);
        for i = inp;
           [e, he] = errorf(d(:,t), y, x, i, haar);

           p = 1;
           if e > 0.5
                p = -1;
                e = 1 - e;
           end

           if e < eOpt(t)
              eOpt(t) = e;
              pOpt(t) = p;
              thresholdOpt(t) = i;
              h(:,t) = he;
              haarOpt(t) = haf;
           end
        end
    end

    alph(t) = 0.5*log((1-eOpt(t))/eOpt(t));
    d(:,t + 1) = d(:,t) .* exp(-alph(t).*y(t).*pOpt(t).*h(:,t));
    d(:,t + 1) = d(:,t + 1)./sum(d(:,t + 1));

 
end

H = zeros(T,1);
for k = 1:M
    H = H + alph.*h(k,:)';
end
H = sign(H);

end