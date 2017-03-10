%close all;
clear all;
k = 4;
episodes = 5000;
gamma = 0.8;
alpha = 0.4;
epsistart = 0.5
Qfig = 3;
Vfig = 4;
gwinit(k);
s = gwstate();
GWXSIZE = s.xsize;
GWYSIZE = s.ysize;

Q = rand(GWXSIZE, GWYSIZE, 4);

for ep = 1:episodes
    gwinit(k);
    s = gwstate();
    if mod(ep, 10) == 0
        ep
    end
    %gwdraw;
    epsi = epsistart * (episodes - ep)/episodes;
    while ~s.isterminal
        if ~s.isvalid
            2
        end
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
        while ~s.isvalid
            gwaction(action);
            s = gwstate;
        end
        
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
    end
end
plotQ(Qfig,Vfig,Q)



