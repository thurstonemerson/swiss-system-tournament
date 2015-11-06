#!/usr/bin/env python
# 
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2



def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament")


def deleteMatches():
    """Remove all the match records from the database."""
    try:
      connection = connect()
      cursor = connection.cursor()

      cursor.execute("DELETE from rounds;")
      cursor.execute("DELETE from matches;")
      connection.commit()

    except psycopg2.DatabaseError, e:
      print 'Error %s' % e    
      connection.rollback();
      raise e
    
    finally:
      if connection:
        connection.close()

def deleteTournaments():
    """Remove all the tournament records from the database."""
    try:
      connection = connect()
      cursor = connection.cursor()

      cursor.execute("DELETE from tournaments;")
      connection.commit()

    except psycopg2.DatabaseError, e:
      print 'Error %s' % e    
      connection.rollback();
      raise e
    
    finally:
      if connection:
        connection.close()

def deletePlayers():
    """Remove all the player records from the database."""
    try:
      connection = connect()
      cursor = connection.cursor()

      cursor.execute("DELETE from registered_players;")
      cursor.execute("DELETE from players;")
      connection.commit()

    except psycopg2.DatabaseError, e:
      print 'Error %s' % e    
      connection.rollback();
      raise e
    
    finally:
      if connection:
        connection.close()


def countPlayers(tournamentName="Millionaire Chess", startdate="2015-10-08"):
    """Returns the number of players currently registered to a tournament."""

    try:
      connection = connect()
      cursor = connection.cursor()

      cursor.execute("select count(*) from registered_players where tournament = (select id from tournaments where name = %s and startdate = %s);", (tournamentName, startdate))
      count = cursor.fetchone()[0]

    except psycopg2.DatabaseError, e:
      print 'Error %s' % e    
      raise e
    
    finally:
      if connection:
        connection.close()

    return count

def countTournaments():
    """Returns the number of tournaments in the database."""

    try:
      connection = connect()
      cursor = connection.cursor()

      cursor.execute("select count(*) from tournaments;")
      count = cursor.fetchone()[0]

    except psycopg2.DatabaseError, e:
      print 'Error %s' % e    
      raise e
    
    finally:
      if connection:
        connection.close()

    return count



def addTournament(tournamentName, startdate):
    """Extra credit: Adds a tournament to the tournament database.

    Args:
      tournamentName
      startdate
      The tournament name and start date must be a unique combination in the database

    Returns:
      The ID of the newly created tournament 
    """
    try:
      connection = connect()
      cursor = connection.cursor()

      cursor.execute("INSERT into tournaments (name, startdate) values (%s, %s) RETURNING id;", (tournamentName, startdate))
      tournamentID = cursor.fetchone()[0]
      connection.commit()

    except psycopg2.DatabaseError, e:
      print 'Error %s' % e    
      connection.rollback()
      raise e
    
    finally:
      if connection:
        connection.close()

    return tournamentID


def registerPlayer(name, tournamentName="Millionaire Chess", startdate="2015-10-08"):
    """Adds a player for a particular tournament to the database.
    The database assigns a unique serial id number for the player.
  
    Args:
      name: the player's full name (need not be unique).
      tournamentName: Name and starting date of the tournament the player is registered to
      startdate:
    """
    try:
      connection = connect()
      cursor = connection.cursor()

      cursor.execute("select id from tournaments where name = %s and startdate = %s;", (tournamentName, startdate))
      tournamentID = cursor.fetchone()[0]

      cursor.execute("INSERT into players (name) values (%s) RETURNING id;", (name,))
      playerID = cursor.fetchone()[0]
      cursor.execute("INSERT into registered_players (player, tournament) values (%s, %s);", (playerID, tournamentID))
      connection.commit()

    except psycopg2.DatabaseError, e:
      print 'Error %s' % e    
      connection.rollback()
      raise e
    
    finally:
      if connection:
        connection.close()

def playerStandings(tournamentName="Millionaire Chess", startdate="2015-10-08"):
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    try:
      connection = connect()
      cursor = connection.cursor()

      cursor.execute("select registered_player as id, name, wins, matches from tournament_player_rankings where tournament = (select id from tournaments where name = %s and startdate = %s);", (tournamentName, startdate))
      rows = cursor.fetchall()

      playerRankings = [(row[0], row[1], row[2], row[3]) for row in rows]

    except psycopg2.DatabaseError, e:
      print 'Error %s' % e    
      raise e
    
    finally:
      if connection:
        connection.close()

    return playerRankings

def reportMatch(winner, loser):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
    """
 
 
def swissPairings():
    """Returns a list of pairs of players for the next round of a match.
  
    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.
  
    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """


