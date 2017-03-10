function [] = plotQ(fig1,fig2, Q)

global GWXSIZE
global GWYSIZE

figure(fig1)

for row = 1:GWXSIZE
    for col = 1:GWYSIZE
        actions = [];
        if row == 1
            actions = [actions, 1];
        elseif row == GWXSIZE
            actions = [actions, 2];
        else
            actions = [actions, 1, 2];
        end
        if col == 1
            actions = [actions, 3];
        elseif col == GWYSIZE
            actions = [actions, 4];
        else
            actions = [actions, 3, 4];
        end
        Qtmp = Q(row,col,actions);
        Q(row,col,:) = -inf;
        Q(row,col,actions) = Qtmp;
    end
end


imagesc(max(Q,[],3));
colorbar;
figure(fig2);
gwdraw;
for row = 1:GWXSIZE
    for col = 1:GWYSIZE
        actions = [];
        if row == 1
            actions = [actions, 1];
        elseif row == GWXSIZE
            actions = [actions, 2];
        else
            actions = [actions, 1, 2];
        end
        if col == 1
            actions = [actions, 3];
        elseif col == GWYSIZE
            actions = [actions, 4];
        else
            actions = [actions, 3, 4];
        end
        [~, maxind] = max(Q(row, col, actions));
        gwplotarrow([row col]', actions(maxind));
    end
end
end

