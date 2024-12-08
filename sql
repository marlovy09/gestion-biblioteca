-- Crear la base de datos
CREATE DATABASE Biblioteca;

-- Usar la base de datos creada
USE Biblioteca;

-- Crear la tabla Libros
CREATE TABLE Libros (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    anio_publicacion INT NOT NULL
);

-- Creando la tabla Prestamos
CREATE TABLE Prestamos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    libro_id INT,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NOT NULL,
    FOREIGN KEY (libro_id) REFERENCES Libros(id)
);


-- Insertar datos en la tabla Libros
INSERT INTO Libros (id, titulo, autor, anio_publicacion) VALUES
(1, 'Cien años de soledad', 'Gabriel García Márquez', 1967),
(2, 'Don Quijote de la Mancha', 'Miguel de Cervantes', 1605),
(3, '1984', 'George Orwell', 1949),
(4, 'El resplandor', 'Stephen King', 1977),
(5, 'it', 'Stephen King', 1986);

-- Insertar datos en la tabla Prestamos
INSERT INTO Prestamos (id, libro_id, fecha_prestamo, fecha_devolucion) VALUES
(1, 1, '2024-01-01', '2024-01-15'),
(2, 2, '2024-01-10', '2024-02-10'),
(3, 1, '2024-02-01', '2024-02-15');



-- 1. Consulta todos los libros prestados cuya fecha de devolución es después de la fecha actual
SELECT L.titulo, P.fecha_prestamo
FROM Libros L
JOIN Prestamos P ON L.id = P.libro_id
WHERE P.fecha_devolucion > CURDATE();

-- 2. Consulta los libros que fueron prestados más de una vez
SELECT L.titulo, COUNT(P.id) AS cantidad_prestamos
FROM Libros L
JOIN Prestamos P ON L.id = P.libro_id
GROUP BY L.titulo
HAVING COUNT(P.id) > 1;



-- Actualizar la fecha de devolución de un préstamo a la fecha actual
UPDATE Prestamos
SET fecha_devolucion = CURDATE()
WHERE id = 1; -- Cambia el ID del préstamo que desees actualizar

-- Eliminar un préstamo vencido (donde la fecha_devolucion es anterior a la fecha actual)
DELETE FROM Prestamos
WHERE fecha_devolucion < CURDATE();
