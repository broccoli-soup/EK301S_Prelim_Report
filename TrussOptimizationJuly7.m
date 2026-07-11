f = @(v) -createArchTruss(v(1), v(2), v(3));

x0 = [-5, 3, 2];

lb = [-7, 0, 1.02];
ub = [-3, 5, 5];

options = optimoptions('fmincon', ...
    'Display', 'iter', ...
    'MaxIterations', 100, ...
    'MaxFunctionEvaluations', 500);

[v_opt, fval] = fmincon(f, x0, [], [], [], [], lb, ub, [], options);

best_strength = -fval;

v_opt