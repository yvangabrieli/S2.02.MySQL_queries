USE Tienda;

-- 1. List the name of all products\
SELECT nombre FROM producto;

-- 2. List the names and prices of all products\
SELECT nombre, precio FROM producto;

-- 3. List all columns from the product table\
SELECT * FROM producto;

-- 4. List the name, price in euros, and price in US dollars (assuming 1\'80 = 1.07 USD)\
SELECT nombre, precio AS euros, (precio * 1.07) AS dollars FROM producto;

-- 5. Same as above, but with custom column aliases\
SELECT nombre AS 'product name', precio AS euros, (precio * 1.07) AS dollars FROM producto;

-- 6. List names and prices, converting names to uppercase\
SELECT UPPER(nombre) AS name, precio FROM producto;

-- 7. List names and prices, converting names to lowercase\
SELECT LOWER(nombre) AS name, precio FROM producto;

-- 8. List manufacturer names and the first two letters in uppercase\
SELECT nombre, UPPER(LEFT(nombre, 2)) AS initials FROM fabricante;

-- 9. List names and prices rounded to the nearest integer\
SELECT nombre, ROUND(precio) AS rounded_price FROM producto;

-- 10. List names and truncated prices (no decimals)\
SELECT nombre, TRUNCATE(precio, 0) AS truncated_price FROM producto;

-- 11. List manufacturer codes that have products\
SELECT codigo_fabricante FROM producto;

-- 12. List distinct manufacturer codes that have products (no duplicates)\
SELECT DISTINCT codigo_fabricante FROM producto;

-- 13. List manufacturer names in ascending order\
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- 14. List manufacturer names in descending order\
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 15. List products ordered by name ascending, then price descending\
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- 16. Return the first 5 rows from the manufacturer table\
SELECT * FROM fabricante LIMIT 5;

-- 17. Return 2 rows starting from the 4th row (including the 4th)\
SELECT * FROM fabricante LIMIT 3, 2;

-- 18. Show the cheapest product (using ORDER BY and LIMIT)\
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- 19. Show the most expensive product (using ORDER BY and LIMIT)\
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20. List all products whose manufacturer code equals 2\
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 21. List product name, price, and manufacturer name for all products\
SELECT p.nombre, p.precio, f.nombre AS manufacturer
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 22. Same as above, ordered alphabetically by manufacturer name\
SELECT p.nombre, p.precio, f.nombre AS manufacturer
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre;

-- 23. List product code, name, manufacturer code, and manufacturer name\
SELECT p.codigo, p.nombre, p.codigo_fabricante, f.nombre AS manufacturer
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 24. Show the cheapest product with its manufacturer\
SELECT p.nombre, p.precio, f.nombre AS manufacturer
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio ASC LIMIT 1;

-- 25. Show the most expensive product with its manufacturer\
SELECT p.nombre, p.precio, f.nombre AS manufacturer
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio DESC LIMIT 1;

-- 26. List all products from manufacturer Lenovo\
SELECT p.nombre, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo';
\
-- 27. List all products from manufacturer Crucial with price > 200\'80\
SELECT p.nombre, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Crucial' AND p.precio > 200;

-- 28. List products from Asus, Hewlett-Packard, and Seagate (without using IN)\
SELECT p.nombre, p.precio, f.nombre AS manufacturer
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';\

-- 29. Same as above, but using IN\
SELECT p.nombre, p.precio, f.nombre AS manufacturer
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 30. List products where the manufacturer\'92s name ends with the vowel "e"\
SELECT p.nombre, p.precio, f.nombre AS manufacturer
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%e';

-- 31. List products where the manufacturer\'92s name contains the letter "w"\
SELECT p.nombre, p.precio, f.nombre AS manufacturer
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%w%';

-- 32. List products with price >= 180\'80, ordered by price (desc) then name (asc)\
SELECT p.nombre, p.precio, f.nombre AS manufacturer
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;
\
-- 33. List manufacturer codes and names that have products\
SELECT DISTINCT f.codigo, f.nombre
FROM fabricante f
JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 34. List all manufacturers with their products (including those with none)\
SELECT f.nombre AS manufacturer, p.nombre AS product
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 35. List only manufacturers that have no products\
SELECT f.nombre
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.codigo IS NULL;

-- 36. List all products from Lenovo (without using INNER JOIN)\
SELECT nombre, precio
FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

-- 37. List products that have the same price as Lenovo\'92s most expensive product\
SELECT *
FROM producto
WHERE precio = (
  SELECT MAX(precio) FROM producto
  WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo')
);

-- 38. Show the name of Lenovo\'92s most expensive product\
SELECT nombre
FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo')
ORDER BY precio DESC LIMIT 1;

-- 39. Show the name of Hewlett-Packard\'92s cheapest product\
SELECT nombre
FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard')
ORDER BY precio ASC LIMIT 1;

-- 40. List all products with price >= Lenovo\'92s most expensive product\
SELECT *
FROM producto
WHERE precio >= (
  SELECT MAX(precio) FROM producto
  WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo')
);

-- 41. List all Asus products priced above the average of Asus products\
SELECT *
FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus')
  AND precio > (
    SELECT AVG(precio)
    FROM producto
    WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus')
  );

 -- 42. Avarage precio fro Asus
   SELECT AVG(precio) FROM producto
   WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus')
   ;
}