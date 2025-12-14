SELECT
	t.name,
	t.year,
	t.location,
	tm.name AS winner
FROM tournament t
LEFT JOIN team tm ON tm.id = t.winner_team_id;


SELECT
	t.name AS tournament,
	tm.name AS team,
	tm.captain_name
FROM team_tournament tt
JOIN tournament t ON t.id = tt.tournament_id
JOIN team tm ON tm.id = tt.team_id
WHERE t.id = 1;


SELECT 
	first_name,
    last_name,
    date_of_birth,
    position,
    number
FROM player
WHERE team_id = 1;


SELECT
	m.match_datetime,
	ht.name AS home,
	at.name AS away,
	mt.name AS phase,
	m.home_score,
	m.away_score
FROM match m
JOIN team ht ON ht.id = m.home_team_id
JOIN team at ON at.id = m.away_team_id
JOIN match_type mt ON mt.id = m.match_type_id
WHERE m.tournament_id = 1;


SELECT
    tr.name AS tournament,
    m.match_datetime,
    ht.name AS home,
    at.name AS away,
    mt.name AS phase,
    m.home_score,
    m.away_score
FROM team t
JOIN tournament tr ON tr.id = m.tournament_id
JOIN team ht ON ht.id = m.home_team_id
JOIN team at ON at.id = m.away_team_id
JOIN match_type mt ON mt.id = m.match_type_id
WHERE m.home_team_id = 1 OR m.away_team_id = 1;


SELECT
    me.event_type,
    me.minute,
    p.first_name,
    p.last_name
FROM match_event me
JOIN player p ON p.id = me.player_id
WHERE me.match_id = 1;


SELECT
    tr.name AS tournament,
    te.name AS team,
    p.first_name,
    p.last_name,
    me.event_type,
    me.minute
FROM match_event me
JOIN match m ON m.id = me.match_id
JOIN tournament tr ON tr.id = m.tournament_id
JOIN team te ON te.id = me.team_id
JOIN player p ON p.id = me.player_id
WHERE tr.id = 1
  AND me.event_type IN ('yellow_card','red_card');

SELECT
    p.first_name,
    p.last_name,
    te.name AS team,
    COUNT(*) AS goals
FROM match_event me
JOIN match m ON m.id = me.match_id
JOIN player p ON p.id = me.player_id
JOIN team te ON te.id = me.team_id
WHERE me.event_type = 'goal'
  AND m.tournament_id = 1
GROUP BY p.first_name, p.last_name, te.name
ORDER BY goals DESC;


SELECT
    te.name AS team,
    tt.points,
    tt.goals_scored - tt.goals_taken AS goal_diff,
    tt.position
FROM team_tournament tt
JOIN team te ON te.id = tt.team_id
WHERE tt.tournament_id = 1
ORDER BY tt.position;


SELECT
	mt.name,
	tr.name AS tournament,
	ht.name AS home_team,
	at.name AS away_team
FROM match m
JOIN match_type mt ON mt.id = m.match_type_id
JOIN tournament tr ON tr.id = m.tournament_id
JOIN team ht ON ht.id = m.home_team_id
JOIN team at ON at.id = m.away_team_id
WHERE mt.name = 'final';


SELECT
	mt.name,
	COUNT(*) AS number_of_games
FROM match_type mt
JOIN match m ON m.match_type_id = mt.id
GROUP BY mt.name;


SELECT
    m.match_datetime,
    ht.name,
    at.name,
    mt.name,
    m.home_score,
    m.away_score
FROM match m
JOIN team ht ON ht.id = m.home_team_id
JOIN team at ON at.id = m.away_team_id
JOIN match_type mt ON mt.id = m.match_type_id
WHERE DATE(m.match_datetime) = CURRENT_DATE;


SELECT
	p.first_name,
	p.last_name,
	COUNT(*) AS goals
FROM match_event me
JOIN match m ON m.id = me.match_id
JOIN player p ON p.id = me.player_id
WHERE me.event_type = 'goal'
AND m.tournament_id = 1
GROUP BY p.first_name, p.last_name
ORDER BY goals DESC;


SELECT
    tr.name,
    tr.year,
    tt.position
FROM team_tournament tt
JOIN tournament tr ON tr.id = tt.tournament_id
WHERE tt.team_id = 1;


SELECT
    te.name,
    tt.points
FROM team_tournament tt
JOIN team te ON te.id = tt.team_id
WHERE tt.tournament_id = 1
ORDER BY tt.points DESC
LIMIT 1;


SELECT
    tr.name,
    COUNT(DISTINCT tt.team_id) AS teams,
    COUNT(DISTINCT p.id) AS players
FROM tournament tr
JOIN team_tournament tt ON tt.tournament_id = tr.id
JOIN player p ON p.team_id = tt.team_id
GROUP BY tr.name;


SELECT DISTINCT ON (te.id)
    te.name AS team,
    p.first_name,
    p.last_name,
    COUNT(*) OVER (PARTITION BY te.id, p.id) AS goals
FROM match_event me
JOIN player p ON p.id = me.player_id
JOIN team te ON te.id = me.team_id
WHERE me.event_type = 'goal'
ORDER BY te.id, goals DESC;


SELECT
    r.first_name,
    r.last_name,
    m.match_datetime,
    ht.name AS home_team,
    at.name AS away_team
FROM match m
JOIN referee r ON r.id = m.referee_id
JOIN team ht ON ht.id = m.home_team_id
JOIN team at ON at.id = m.away_team_id
WHERE r.id = 1;
















