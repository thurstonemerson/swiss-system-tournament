-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- create database tournament;

create table players (
	id serial PRIMARY KEY,
	name text
);

create table tournaments (
	id serial PRIMARY KEY,
	name text,
	startdate date,
	UNIQUE (name, startdate)
);

create table registered_players (
	player integer REFERENCES players (id),
	tournament integer REFERENCES tournaments (id),
	PRIMARY KEY (player, tournament)
);

create table matches (
	id serial PRIMARY KEY,
	player1 integer REFERENCES players (id),
	player2 integer REFERENCES players (id),
	winner integer REFERENCES players (id)
);

create table rounds (
	tournament int REFERENCES tournaments (id),
	round int,
	match int REFERENCES matches (id),
	PRIMARY KEY (tournament, round, match)
);


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

-- view showing the matches played for each round in a tournament
CREATE VIEW tournament_matches_per_round AS
	select tournament, round, player1, player2, winner
	from rounds, matches
	where rounds.match = matches.id;

-- view showing the number of matches played for each player registered for a tournament
CREATE VIEW tournament_matches_per_reg_player AS
	select p.tournament, p.registered_player, count(m.player) as matches_played
	from (select player as registered_player, tournament from registered_players) p left join 
    ((select player1 as player, tournament from tournament_matches_per_round) union all (select player2 as player, tournament from tournament_matches_per_round)) m
    on p.registered_player = m.player and p.tournament = m.tournament
    group by p.tournament, p.registered_player order by p.tournament, p.registered_player;

--view showing the number of matches won for each player registered for a tournament
CREATE VIEW tournament_matches_won_per_reg_player AS
	select p.tournament, p.registered_player, count(tournament_matches_per_round.winner) as matches_won
    from (select player as registered_player, tournament from registered_players) p left join tournament_matches_per_round
	on p.registered_player = tournament_matches_per_round.winner and p.tournament = tournament_matches_per_round.tournament
    group by p.tournament, p.registered_player order by p.tournament, p.registered_player;

--view showing the player rankings for each player registered for a tournament
CREATE VIEW tournament_player_rankings AS
	select tournament, registered_player, matches_won as score from tournament_matches_won_per_reg_player
	order by tournament, score desc;

-- view showing the sum of wins for match opponents for each player registered for a tournament
CREATE VIEW tournament_match_opponent_wins AS
	select p.tournament, p.registered_player, sum(mw.matches_won) as sum_opponent_wins
	from (select player as registered_player, tournament from registered_players) p, 
    ((select player1 as player, player2 as opponent, tournament from tournament_matches_per_round) union all (select player2 as player, player1 as opponent, tournament from tournament_matches_per_round)) m,
    tournament_matches_won_per_reg_player mw
    where p.registered_player = m.player and p.tournament = m.tournament and m.opponent = mw.registered_player and p.tournament = mw.tournament
    group by p.tournament, p.registered_player order by p.tournament, p.registered_player;

-- player rankings based on score next to opponent wins
select mw.tournament, mw.registered_player, mw.matches_won, ow.sum_opponent_wins from tournament_matches_won_per_reg_player mw, tournament_match_opponent_wins ow
	where mw.registered_player = ow.registered_player and mw.tournament = ow.tournament
	order by mw.tournament, mw.matches_won desc;


--select player, count(*)
--    from ((select player1 as player from matches) union all (select player2 as player from matches)) m
--   group by player order by player;
-- CREATE VIEW tournament_match_opponents AS
-- 	select p.tournament, p.registered_player, m.opponent
-- 	from (select player as registered_player, tournament from registered_players) p, 
--     ((select player1 as player, player2 as opponent, tournament from tournament_matches_per_round) union all (select player2 as player, player1 as opponent, tournament from tournament_matches_per_round)) m
--     where p.registered_player = m.player and p.tournament = m.tournament
--     order by p.tournament, p.registered_player;

--     select mo.tournament, mo.registered_player, sum(mw.matches_won) as sum_opponent_wins from tournament_match_opponents mo, tournament_matches_won_per_reg_player mw
--     where mo.opponent = mw.registered_player and mo.tournament = mw.tournament
--     group by mo.tournament, mo.registered_player;
