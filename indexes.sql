
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
