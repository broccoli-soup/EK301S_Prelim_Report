clear nodes; 

nodes(1).label = "A"; nodes(1).pos = [0, 0]; nodes(1).external_force = [0, 0]; nodes(1).reactions = [[1, 0]; [0, 1]];

nodes(2).label = "B"; nodes(2).pos = [8, 0]; nodes(2).external_force = [0, 0]; nodes(2).reactions = [[]];

nodes(3).label = "C"; nodes(3).pos = [17, 0]; nodes(3).external_force = [0, 0]; nodes(3).reactions = [[]];

nodes(4).label = "D"; nodes(4).pos = [26, 0]; nodes(4).external_force = [0, 0]; nodes(4).reactions = [[]];

nodes(5).label = "E"; nodes(5).pos = [34, 0]; nodes(5).external_force = [0, 0]; nodes(5).reactions = [[0, 1]];

nodes(6).label = "F"; nodes(6).pos = [4, a]; nodes(6).external_force = [0, 0]; nodes(6).reactions = [[]];

nodes(7).label = "G"; nodes(7).pos = [12, a]; nodes(7).external_force = [0, 0]; nodes(7).reactions = [[]];

nodes(8).label = 'H'; nodes(8).pos = [20, a]; nodes(8).external_force = [0, -32]; nodes(8).reactions = [[]];

nodes(9).label = "I"; nodes(9).pos = [30, a]; nodes(9).external_force = [0, 0]; nodes(9).reactions = [[]];

str_connections = ["AF", "FG", "GH", "HI", "IE", "ED", "DC", "CB", "BA", "FB", "BG", "GC", "CH", "HD", "DI"]
