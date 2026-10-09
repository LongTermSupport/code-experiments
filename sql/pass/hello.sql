CREATE TABLE greetings (
    id INT NOT NULL PRIMARY KEY,
    message VARCHAR(100) NOT NULL
);

INSERT INTO greetings (id, message) VALUES (1, 'Hello, world');

SELECT message
FROM greetings
WHERE id = 1;
