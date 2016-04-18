# Swiss System Chess Tournament

Python module which can be used to store the details of multiple chess tournaments. Game players can be registered into tournaments, and matches between players can be recorded. Player matches are scheduled using the Swiss pairing system where the goal is to pair (as close as possible) each player with an similar-skilled opponent. Players are ranked according to the number of matches won within a tournament,
if the players are tied then they are ranked according to the number of matches won by their opponents. 


## Environment

You'll need the following for your development environment:

- [Python] (http://www.python.org)
- [PostgreSQL] (http://www.postgresql.org/)
- [virtualenv] (https://python-guide.readthedocs.org/en/latest/dev/virtualenvs/#virtualenv) (recommended)

## Local Installation

The following assumes you have all of the tools listed above installed.

1. Clone the project:

    ```
	$ git clone https://github.com/thurstonemerson/swiss-system-tournament.git
	$ cd swiss-system-tournament
    ```

1. Create and initialize virtualenv for the project:

    ```
	$ mkvirtualenv swiss-system-tournament
	$ pip install -r requirements.txt
    ```

1. This module has a PostgreSQL backend. The database can be created using the script provided:

    ```
	$ psql
	\i tournament.sql
    ```
	
## Testing:

Run unit tests using the test script provided:

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

## Known Issues:

- Rematches between players during multiple rounds of a single tournament are allowed
- It is not possible to register an odd number of players into a tournament

## License

The MIT License (MIT)

Copyright (c) 2016 Thurston Emerson

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
