CREATE TABLE team(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	country VARCHAR(100),
	captain_name VARCHAR(255),
	email VARCHAR(255),
	phone VARCHAR(50),
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE tournament(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	year INT NOT NULL,
	location VARCHAR(255),
	winner_team_id INT NULL REFERENCES team(id),
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW()	
);

CREATE TABLE team_tournament(
	id SERIAL PRIMARY KEY,
	tournament_id INT NOT NULL REFERENCES tournament(id),
	team_id INT NOT NULL REFERENCES team(id),
	points INT DEFAULT 0,
	position INT,
	stage_reached VARCHAR(100),
	goals_scored INT DEFAULT 0,
	goals_taken INT DEFAULT 0,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
	UNIQUE(tournament_id, team_id)	
);
