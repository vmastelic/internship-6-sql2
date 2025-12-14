# internship-6-sql2

This project represents database for organising and manageing sport tournaments.
Database allows storing data for tournaments, teams, players, games, referees and match events(fouls and goals).

Database has following entities:
- tournament
- team
- player
- referee
- match_type – phases of games (group stage, semifinals...)
- match
- match_event
- team_tournament – table for connecting teams and tournaments since they are in N:M realation

Data was seeded using SQL scripts with PostgreSQL functions such as generate_series() and random().
Bulk insert statements were used to generate realistic data for teams, tournaments, players, matches, and events.
Tournament winners were determined dynamically based on team performance data.

Quieries:
1. Display a list of all tournaments  
   Show the tournament name, year, location, and the overall winner.

2. Display all teams participating in a specific tournament  
   For a given tournament, list all teams and their team representative.

3. Display all players from a specific team  
   Retrieve a list of all players, their birth years, and other relevant details.

4. Display all matches of a specific tournament  
   Show match dates and times, participating teams, match type (stage), and final result.

5. Display all matches of a specific team across all tournaments  
   Retrieve all matches in which the team participated, including results and competition stages.

6. List all events (goals, cards) for a specific match  
   Show the event type and the name of the player who performed the event.

7. Display all players who received a yellow or red card during an entire tournament  
   Include the team, match, and the minute when the card was given.

8. Display all goal scorers of a tournament  
   Retrieve players who scored goals, the number of goals scored, and their team.

9. Display the points table for a specific tournament  
   For each team, list the total points, goal difference, and final ranking.

10. Display all final matches in history  
    Retrieve matches whose stage is “final” and display the winner.

11. Display all match types  
    For example: group stage, quarterfinal, semifinal, final – along with the number of matches of each type.

12. Display all matches played on a specific date  
    Show the teams, match type, and final result.

13. Display players who scored the most goals in a specific tournament  
    Sort the results by the number of goals in descending order.

14. Display all tournaments in which a specific team participated  
    For each tournament, show the year and the achieved placement.

15. Determine the winner of a tournament based on played matches  
    Retrieve the team with the highest number of points or the winner of the final match, depending on the tournament structure.

16. For each tournament, display the number of teams and players.

17. Top goal scorers per team  
    For each team, display the best goal scorer across all tournaments in which the team participated.

18. Matches officiated by a specific referee  
    For a given referee, list all matches they officiated.


Indexes:
CREATE INDEX idx_player_team_id
ON player(team_id);

CREATE INDEX idx_team_tournament_tournament_id
ON team_tournament(tournament_id);

CREATE INDEX idx_team_tournament_team_id
ON team_tournament(team_id);

CREATE INDEX idx_match_tournament_id
ON match(tournament_id);

CREATE INDEX idx_match_home_team_id
ON match(home_team_id);

CREATE INDEX idx_match_away_team_id
ON match(away_team_id);

CREATE INDEX idx_match_referee_id
ON match(referee_id);

CREATE INDEX idx_match_match_date
ON match ((DATE(match_datetime)));

CREATE INDEX idx_match_event_match_id
ON match_event(match_id);

CREATE INDEX idx_match_event_player_id
ON match_event(player_id);

CREATE INDEX idx_match_event_event_type
ON match_event(event_type);

CREATE INDEX idx_match_type_name
ON match_type(name);

CREATE INDEX idx_match_event_goal
ON match_event(match_id)
WHERE event_type = 'goal';



Here is table of compared execution times for quieries before and after adding indexes.

| Query| Time before adding indexes | Time after adding indexes (ms)|   +/-   |
|------|----------------------------|-------------------------------|---------|
| 1    | 0.070                      | 0.102                         | +0.032  |
| 2    | 0.817                      | 0.098                         | -0.719  |
| 3    | 0.148                      | 0.051                         | -0.097  |
| 4    | 3.294                      | 0.171                         | -3.123  |
| 5    | 0.273                      | 0.259                         | -0.014  |
| 6    | 0.343                      | 0.059                         | -0.284  |
| 7    | 0.679                      | 0.839                         | +0.160  |
| 8    | 0.728                      | 0.817                         | +0.089  |
| 9    | 0.150                      | 0.193                         | +0.043  |
| 10   | 0.529                      | 0.352                         | -0.177  |
| 11   | 0.549                      | 0.504                         | -0.045  |
| 12   | 0.261                      | 0.111                         | -0.150  |
| 13   | 0.918                      | 0.513                         | -0.405  |
| 14   | 0.137                      | 0.067                         | -0.070  |
| 15   | 0.098                      | 0.126                         | +0.028  |
| 16   | 19.790                     | 16.471                        | -3.319  |
| 17   | 4.940                      | 2.961                         | -1.979  |
| 18   | 0.161                      | 0.257                         | +0.096  |
