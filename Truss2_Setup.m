clear nodes; 

nodes(1).label = "A"; 
nodes(1).pos = [-17, 0];
nodes(1).reactions = [[1, 0]; [0, 1]];

nodes(2).label = "B"; 
nodes(2).pos = [-12.8, 6.809*b];

nodes(3).label = "C"; 
nodes(3).pos = [-7.418, 12.73*b];

nodes(4).label = "D"; 
nodes(4).pos = [0, 15.72*b]; % + 1

nodes(5).label = 'E'; 
nodes(5).pos = [7.418, 12.73*b]; 

nodes(6).label = 'F'; 
nodes(6).pos = [12.8, 6.809*b];

nodes(7).label = 'G';
nodes(7).pos = [17, 0]; 
nodes(7).reactions = [[0, 1]];

nodes(8).label = "H"; 
nodes(8).pos = [-5, 2.9544]; 

nodes(9).label = "I"; 
nodes(9).pos = [3, 1.02]; 
nodes(9).external_force = [0, -20]; 

str_connections = ["AB", "BC", "CD", "DE", "EF", "FG", "BH", "CH", "DH", "DI", "EI", "FI", "AH", "HI", "GI"]