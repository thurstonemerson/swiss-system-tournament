# #Swiss System Tournament

(Project in fulfillment of Udacity's Full-Stack Web Developer Nanodegree)

##What is it?

This Python module can be used to register game players into multiple tournaments, and record matches between players.
Player matches are scheduled using the Swiss pairing system. This module has a PostgreSQL backend.

##How to run:

The database can be created from psql using the script provided:

	\i tournament.sql

Test cases for the module are included and can be run via the following command:

	python tournament_test.py.py

##Release plans:

###TODO:
- Prevent rematches between players during multiple rounds of a single tournament
- Allow odd number of players to be registered into a tournament