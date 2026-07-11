function strength = createArchTruss(x1, y1, y2)
    nodes(1).label = "A"; 
    nodes(1).pos = [-17, 0];
    nodes(1).reactions = [[1, 0]; [0, 1]];
    
    nodes(2).label = "B"; 
    nodes(2).pos = [-12.8, 6.809];
    
    nodes(3).label = "C"; 
    nodes(3).pos = [-7.418, 12.73];
    
    nodes(4).label = "D"; 
    nodes(4).pos = [0, 15.72]; % + 1
    
    nodes(5).label = 'E'; 
    nodes(5).pos = [7.418, 12.73]; 
    
    nodes(6).label = 'F'; 
    nodes(6).pos = [12.8, 6.809];
    
    nodes(7).label = 'G';
    nodes(7).pos = [17, 0]; 
    nodes(7).reactions = [[0, 1]];
    
    nodes(8).label = "H"; 
    nodes(8).pos = [x1, y1]; 
    
    nodes(9).label = "I"; 
    nodes(9).pos = [3, y2]; 
    nodes(9).external_force = [0, -1]; 
    
    str_connections = ["AB", "BC", "CD", "DE", "EF", "FG", "BH", "CH", "DH", "DI", "EI", "FI", "AH", "HI", "GI"];
    
    for i = 1:length(nodes)
        if ~isfield(nodes(i), "external_force") || isempty(nodes(i).external_force)
            nodes(i).external_force = [0, 0];
        end
    
        if ~isfield(nodes(i), "reactions") || isempty(nodes(i).reactions)
            nodes(i).reactions = [];
        end
    end
    
    nodeLabels = string({nodes.label});
    
    connections_idx = zeros(length(str_connections), 2);
    
    for k = 1:length(str_connections)
    
        member = str_connections(k);
    
        label1 = extractBetween(member, 1, 1);
        label2 = extractBetween(member, 2, 2);
    
        connections_idx(k,1) = find(nodeLabels == label1);
        connections_idx(k,2) = find(nodeLabels == label2);
    
    end
    
    connections = connections_idx;
    
    % This section creates the "b" vector, which
    % Logically, it must have length 2N, where N is the number of nodes since
    % [..]
    
    N = length(nodes);
    
    b = zeros(2*N,1);
    n_loading = 0; 
    primary_load_index = 0; % meaningless if there's more than one...
    for i = 1:N
        if ~(isequal(nodes(i).external_force, [0, 0]))
            n_loading = n_loading + 1;
            primary_load_index = i;
        end 
        b(2*i - 1) = -nodes(i).external_force(1);
        b(2*i)     = -nodes(i).external_force(2);
    end
    
    
    mat = zeros(2*N, 2*N);
    
    % This section looks at the joints and updates the matrix accordingly 
    
    M = size(connections, 1);
    
    buckle_loads = zeros(M, 1); % At what compressive load will it buckle?
    
    for m = 1:M;
        
        i = connections(m, 1);
        j = connections(m, 2);
        vec = nodes(j).pos - nodes(i).pos;
   
        buckle_loads(m) = 2219 / (norm(vec) ^ 1.89);
        
        vec = vec / norm(vec);
        mat(2*i - 1, m) = vec(1);
        mat(2*i, m) = vec(2);
        mat(2*j - 1, m) = -vec(1);
        mat(2*j, m) = -vec(2);
        labels(m) = "Member " + nodes(i).label + "" + nodes(j).label;
    end;
    % This section looks at the reaction forces 
    
    m = M;
    for i = 1:N; 
        r = nodes(i).reactions;
        if ~ (isempty(r));
            m = m + 1;
    
            label = "Reaction force on " + nodes(i).label;
            
            if isequal(r(1, :), [1, 0])
                direction = " in x-direction";
            elseif isequal(r(1, :), [0, 1])
                direction = " in y-direction";
            else 
                direction = " in direction [" + join(string(r(1,:)), ", ") + "]";
            end 
    
            labels(m) = label + direction;
    
            mat(2*i - 1, m) = r(1, 1); 
            mat(2*i, m) = r(1, 2);
        end
        if size(r, 1) == 2;
            m = m + 1;
    
            label = "Reaction force on " + nodes(i).label;
            
            if isequal(r(2, :), [1, 0])
                direction = " in x-direction";
            elseif isequal(r(2, :), [0, 1])
                direction = " in y-direction";
            else 
                direction = " in direction [" + join(string(r(2,:)), ", ") + "]";
            end 
    
            labels(m) = label + direction;
    
            mat(2*i - 1, m) = r(2, 1); 
            mat(2*i, m) = r(2, 2);
        end
    end;
   
    x = mat\b;
    
    %% -------------------------------------------------------------
    % Probabilistic Buckling Analysis
    % -------------------------------------------------------------
    
    if n_loading == 1
    
        % Compression forces only (member forces are x(1:M))
        member_forces = max(0, -x(1:M));
    
        % Critical applied load for each member
        req = Inf(M,1);
    
        compressive = member_forces > 1e-8;
        req(compressive) = buckle_loads(compressive) ./ member_forces(compressive);
    
        % Deterministic result
        [minValue, minIndex] = min(req);
    
        current_load = norm(nodes(primary_load_index).external_force);
    
        strength = current_load * minValue
    end
end
