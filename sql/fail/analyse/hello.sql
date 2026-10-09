SELECT
    g.message,
    l.name
FROM greetings AS g
INNER JOIN languages AS l ON g.id = l.id
WHERE message = 'Hello, world';
