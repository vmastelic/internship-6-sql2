INSERT INTO team (name, country, captain_name, email, phone)
SELECT
    'Team ' || i,
    (ARRAY['Croatia','Germany','Spain','Italy','France'])[floor(random()*5+1)],
    'Captain ' || i,
    'team' || i || '@mail.com',
    '+385 91 ' || (100000 + i)
FROM generate_series(1, 200) i;

INSERT INTO tournament (name, year, location)
SELECT
    'Tournament ' || i,
    (2015 + (i % 10)),
    (ARRAY['Zagreb','Split','Berlin','Rome','Madrid'])[floor(random()*5+1)]
FROM generate_series(1, 30) i;


INSERT INTO referee (first_name, last_name, date_of_birth, nationality)
SELECT
    'RefFn' || i,
    'RefLn' || i,
    DATE '1960-01-01' + (random()*15000)::int,
    (ARRAY['Croatia','England','France','Italy'])[floor(random()*4+1)]
FROM generate_series(1, 100) i;


INSERT INTO match_type (name) VALUES
('group'),
('quarterfinal'),
('semifinal'),
('final');


INSERT INTO player (team_id, first_name, last_name, date_of_birth, position, number)
SELECT
    (random()*199 + 1)::int,
    'PlayerFirstName' || i,
    'PlayerLastName' || i,
    DATE '1988-01-01' + (random()*8000)::int,
    (ARRAY['GK','DF','MF','FW'])[floor(random()*4+1)],
    (random()*98 + 1)::int
FROM generate_series(1, 2000) i;


INSERT INTO team_tournament
(tournament_id, team_id, points, position, stage_reached, goals_scored, goals_taken)
SELECT
    (random()*29 + 1)::int,
    (random()*199 + 1)::int,
    (random()*15)::int,
    (random()*16 + 1)::int,
    (ARRAY['group','quarterfinal','semifinal','final'])[floor(random()*4+1)],
    (random()*20)::int,
    (random()*20)::int
FROM generate_series(1, 1200)
ON CONFLICT (tournament_id, team_id) DO NOTHING;


INSERT INTO match
(tournament_id, match_type_id, home_team_id, away_team_id,
 referee_id, match_datetime, venue, home_score, away_score)
SELECT
    (random()*29 + 1)::int,
    (random()*3 + 1)::int,
    t1.id,
    t2.id,
    (random()*99 + 1)::int,
    NOW() - (random()*1000 || ' days')::interval,
    (ARRAY['Arena','Stadium','Field'])[floor(random()*3+1)],
    (random()*5)::int,
    (random()*5)::int
FROM
    (SELECT id FROM team ORDER BY random() LIMIT 1000) t1
JOIN
    (SELECT id FROM team ORDER BY random() LIMIT 1000) t2
ON t1.id <> t2.id
LIMIT 1000;


INSERT INTO match_event
(match_id, team_id, player_id, event_type, minute)
SELECT
    (random()*999 + 1)::int,
    (random()*199 + 1)::int,
    (random()*1999 + 1)::int,
    (ARRAY['goal','yellow_card','red_card'])[floor(random()*3+1)],
    (random()*89 + 1)::int
FROM generate_series(1, 5000);


