INSERT INTO moderators(person_id) VALUES ((SELECT id FROM person WHERE user_name = 'WriteCoin'));
INSERT INTO operators(person_id) VALUES ((SELECT id FROM person WHERE user_name = 'WriteCoin'));