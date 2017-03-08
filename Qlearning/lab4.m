%close all;
clear all;
k = 4;
figure(5)
episodes = 5000;
gamma = 0.8;
alpha = 0.1;
epsi = 0.4;

gwinit(k);
s = gwstate();
GWXSIZE = s.xsize;
GWYSIZE = s.ysize;

Q = zeros(GWXSIZE, GWYSIZE, 4);

for ep = 1:episodes
    gwinit(k);
    s = gwstate();
    if mod(ep, 10) == 0
        ep
    end
    %gwdraw;
    while ~s.isterminal
        oldpos = s.pos;
        actions = [];
        if oldpos(1) == 1
            actions = [actions, 1];
        elseif oldpos(1) == GWXSIZE
            actions = [actions, 2];
        else
            actions = [actions, 1, 2];
        end
        if oldpos(2) == 1
            actions = [actions, 3];
        elseif oldpos(2) == GWYSIZE
            actions = [actions, 4];
        else
            actions = [actions, 3, 4];
        end

        [~, maxind] = max(Q(oldpos(1), oldpos(2), actions));
        probs = zeros(1,length(actions));
        probs(:) = epsi / (length(actions) - 1);
        probs(maxind) = 1 - epsi;
       
        
        action = sample(actions, probs);
        gwaction(action);
        s = gwstate;
        
        actions = [];
        if s.pos(1) == 1
            actions = [actions, 1];
        elseif s.pos(1) == GWXSIZE
            actions = [actions, 2];
        else
            actions = [actions, 1, 2];
        end
        if s.pos(2) == 1
            actions = [actions, 3];
        elseif s.pos(2) == GWYSIZE
            actions = [actions, 4];
        else
            actions = [actions, 3, 4];
        end
        
        Q(oldpos(1), oldpos(2), action) = (1 - alpha)*Q(oldpos(1), oldpos(2), action) +...
            alpha * (s.feedback + gamma * max(Q(s.pos(1), s.pos(2), actions)));
        %gwdraw;
    end
    
    
    1;
end
Q(Q == 0) = -inf;
figure(5)
gwdraw;
for row = 1:GWXSIZE
    for col = 1:GWYSIZE
        [~, maxind] = max(Q(row, col, :));
        gwplotarrow([row col]', maxind);
    end
end


