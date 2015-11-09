#Swiss System Chess Tournament

(Project in fulfillment of Udacity's Full-Stack Web Developer Nanodegree)

##What is it?

This Python module can be used to store the details of multiple chess tournaments. Game players can be registered into tournaments, and matches between players can be recorded. Player matches are scheduled using the Swiss pairing system where the goal is to pair (as close as possible) each player with an similar-skilled opponent. Players are ranked according to the number of matches won within a tournament,
if the players are tied then they are ranked according to the number of matches won by their opponents. 


##How to run:

This module has a PostgreSQL backend. The database can be created from psql using the script provided:

	\i tournament.sql

Test cases for the module are included and can be run via the following command:

	$ python tournament_test.py
	1. Old matches can be deleted.
	2. Player records can be deleted.
	Extra credit: Tournament records can be deleted.
	Extra credit: After adding a tournament, countTournaments() returns 1.
	3. After deleting, countPlayers() returns zero.
	4. After registering a player, countPlayers() returns 1.
	5. Players can be registered and deleted.
	6. Newly registered players appear in the standings with no matches.
	Extra credit: Tied players are ordered by opponent match wins.
	7. After a match, players have updated standings.
	8. After one match, players with one win are paired.
	Success!  All tests pass!

##Release plans:

###TODO:
- Prevent rematches between players during multiple rounds of a single tournament
- Allow odd number of players to be registered into a tournament