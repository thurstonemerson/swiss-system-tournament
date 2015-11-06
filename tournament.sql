-- Table definitions for the tournament project.
-- \i tournament.sql 

drop database if exists tournament;
create database tournament;

\c tournament;

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


-- view showing the matches played for each round in a tournament
CREATE VIEW tournament_matches_per_round AS
	select tournament, round, player1, player2, winner
	from rounds, matches
	where rounds.match = matches.id;

CREATE VIEW registered_player_names AS
	select registered_players.tournament, registered_players.player, players.name
	from registered_players left join players
	on registered_players.player = players.id;

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
    from (select player as registered_player, name, tournament from registered_player) p left join tournament_matches_per_round
	on p.registered_player = tournament_matches_per_round.winner and p.tournament = tournament_matches_per_round.tournament
    group by p.tournament, p.registered_player order by p.tournament, p.registered_player;

--view showing the player rankings for each player registered for a tournament
CREATE VIEW tournament_player_rankings AS
	select tmw.tournament, tmw.registered_player, rpn.name, tmw.matches_won as wins, tmp.matches_played as matches
	from tournament_matches_won_per_reg_player tmw, registered_player_names rpn, tournament_matches_per_reg_player tmp
	where tmw.registered_player = rpn.player and tmw.tournament = rpn.tournament and tmw.registered_player = tmp.registered_player and tmw.tournament = tmp.tournament 
	order by tmw.tournament, wins desc;

-- view showing the sum of wins for match opponents for each player registered for a tournament
CREATE VIEW tournament_match_opponent_wins AS
	select p.tournament, p.registered_player, sum(mw.matches_won) as sum_opponent_wins
	from (select player as registered_player, tournament from registered_players) p, 
    ((select player1 as player, player2 as opponent, tournament from tournament_matches_per_round) union all (select player2 as player, player1 as opponent, tournament from tournament_matches_per_round)) m,
    tournament_matches_won_per_reg_player mw
    where p.registered_player = m.player and p.tournament = m.tournament and m.opponent = mw.registered_player and p.tournament = mw.tournament
    group by p.tournament, p.registered_player order by p.tournament, p.registered_player;

-- player rankings based on score next to opponent wins
---select mw.tournament, mw.registered_player, mw.matches_won, ow.sum_opponent_wins from tournament_matches_won_per_reg_player mw, tournament_match_opponent_wins ow
--	where mw.registered_player = ow.registered_player and mw.tournament = ow.tournament
	--order by mw.tournament, mw.matches_won desc;


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
