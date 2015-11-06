-- some sample values
--setup the players and tournaments
insert into tournaments (name, startdate) values ('Millionaire Chess', '2015-10-08');
insert into tournaments (name, startdate) values ('FIDE World Cup', '2015-09-10');
insert into players (name) values ('Bears');
insert into players (name) values ('Dogs');
insert into players (name) values ('Foxes');
insert into players (name) values ('Apes');
insert into players (name) values ('Hares');
insert into players (name) values ('Colts');
insert into players (name) values ('Eels');
insert into players (name) values ('Jackels');
insert into players (name) values ('Gators');
insert into players (name) values ('Ibises');
insert into registered_players (player, tournament) values (1, 1);
insert into registered_players (player, tournament) values (2, 1);
insert into registered_players (player, tournament) values (3, 1);
insert into registered_players (player, tournament) values (4, 1);
insert into registered_players (player, tournament) values (5, 1);
insert into registered_players (player, tournament) values (6, 1);
insert into registered_players (player, tournament) values (7, 1);
insert into registered_players (player, tournament) values (8, 1);
insert into registered_players (player, tournament) values (9, 1);
insert into registered_players (player, tournament) values (10, 1);
insert into registered_players (player, tournament) values (1, 2);
insert into registered_players (player, tournament) values (2, 2);
insert into registered_players (player, tournament) values (3, 2);
insert into registered_players (player, tournament) values (4, 2);
insert into registered_players (player, tournament) values (5, 2);

--round 1
insert into matches (player1, player2, winner) values (1, 6, 1);
insert into matches (player1, player2, winner) values (2, 7, 2);
insert into matches (player1, player2, winner) values (3, 8, 3);
insert into matches (player1, player2, winner) values (4, 9, 4);
insert into matches (player1, player2, winner) values (5, 10, 5);
insert into rounds (tournament, round, match) values (1, 1, 1);
insert into rounds (tournament, round, match) values (1, 1, 2);
insert into rounds (tournament, round, match) values (1, 1, 3);
insert into rounds (tournament, round, match) values (1, 1, 4);
insert into rounds (tournament, round, match) values (1, 1, 5);

--round 2
insert into matches (player1, player2, winner) values (1, 3, 1);
insert into matches (player1, player2, winner) values (2, 4, 4);
insert into matches (player1, player2, winner) values (5, 6, 6);
insert into matches (player1, player2, winner) values (7, 9, 7);
insert into matches (player1, player2, winner) values (10, 8, 10);
insert into rounds (tournament, round, match) values (1, 2, 6);
insert into rounds (tournament, round, match) values (1, 2, 7);
insert into rounds (tournament, round, match) values (1, 2, 8);
insert into rounds (tournament, round, match) values (1, 2, 9);
insert into rounds (tournament, round, match) values (1, 2, 10);
