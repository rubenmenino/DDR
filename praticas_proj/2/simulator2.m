function [bHD b4K]= simulator2(lambda,p,n,S,W,R,fname)
    %lambda = request arrival rate (in requests per hour)
    %p      = percentage of requests for 4K movies (in %)
    %n      = number of servers
    %S      = interface capacity of each server (in Mbps)
    %W      = resource reservation for 4K movies (in Mbps)
    %R      = stop simulation on ARRIVAL no. R
    %fname  = filename with the duration of each movie
    
    invlambda=60/lambda;     % average time between requests (in minutes)
    invmiu= load(fname);     % duration (in minutes) of each movie
    Nmovies= length(invmiu); % number of movies
    C = n*S;                 % Internet connection capacity (in Mbps)
    throughput_HD = 5;       % throughput of HD format
    throughput_4K = 25;      % throughput of 4K format
    
    %Events definition:
    ARRIVAL = 0;            % movie request
    DEPARTURE_HD = 1;       % termination of a HD movie transmission
    DEPARTURE_4K = 2;       % termination of a 4K movie transmission
    %State variables initialization:
    STATE = zeros(1, n);
    STATE_HD = 0;
    %Statistical counters initialization:
    NARRIVALS = 0;
    REQUESTS_HD = 0;
    REQUESTS_4K = 0;
    BLOCKED_HD = 0;
    BLOCKED_4K = 0;
    %Simulation initial List of Events:
    %%[Lower, i] = min(STATE);
    EventList= [ARRIVAL exprnd(invlambda) 0];  %% 0
 
    while NARRIVALS < R
        event= EventList(1,1);
        Clock= EventList(1,2);
        OldIdx = EventList(1,3);
        EventList(1,:)= [];
        if event == ARRIVAL
            [Lower, i] = min(STATE);
            EventList= [EventList; ARRIVAL Clock+exprnd(invlambda) 0];
            NARRIVALS= NARRIVALS+1;
            
            
            if (rand(1) > p/100)
                % if HD movie requested, it starts being transmitted by the least loaded server if it has
                % at least 5 Mbps of unused capacity and the total throughput of HD movies does not become
                % higher than C – W Mbps; 
                REQUESTS_HD = REQUESTS_HD+1;
                if STATE_HD + throughput_HD <= C-W && Lower <= S - throughput_HD
                    STATE_HD = STATE_HD + throughput_HD;
                    STATE(i) = STATE(i)+ throughput_HD;
                    EventList= [EventList; DEPARTURE_HD Clock+invmiu(randi(Nmovies)) i];
                else
                    % otherwise, the request is blocked
                    BLOCKED_HD = BLOCKED_HD+1;
                end
            else
                % if 4k movie is requested, it starts being transmitted by the least loaded server if it has
                % at least 25 Mbps of unused capacity;
                REQUESTS_4K = REQUESTS_4K+1;
                if Lower <= S - throughput_4K % state(i) lower
                    STATE(i) = STATE(i) + throughput_4K;
                    EventList= [EventList; DEPARTURE_4K Clock+invmiu(randi(Nmovies)) i];
                else
                    % otherwise, the request is blocked.
                    BLOCKED_4K = BLOCKED_4K+1;
                end
            end
        elseif event == DEPARTURE_HD
            STATE_HD = STATE_HD - throughput_HD;
            % total throughput of the movies in transmission by server i (
            STATE(OldIdx) = STATE(OldIdx) - throughput_HD;
        else 
            STATE(OldIdx) = STATE(OldIdx) - throughput_4K;
        end
        EventList= sortrows(EventList,2);
    end
    bHD = 100 * BLOCKED_HD / REQUESTS_HD;    % blocking probability of HD in %
    b4K = 100 * BLOCKED_4K / REQUESTS_4K;    % blocking probability of 4K in %
end
