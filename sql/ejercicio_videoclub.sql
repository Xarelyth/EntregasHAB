create database ejercicio_videoclub;

use ejercicio_videoclub;


CREATE TABLE IF NOT EXISTS peliculas (
id_pelicula INT NOT NULL AUTO_INCREMENT,
titulo VARCHAR(100) NULL,
genero VARCHAR(45) NULL,
año VARCHAR(45) NULL,
nacionalidad VARCHAR(45) NULL,
PRIMARY KEY (id_pelicula)
);


CREATE TABLE IF NOT EXISTS participantes (
id_trabajadorpelicula INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(50) NULL,
apellidos VARCHAR(100) NULL,
tipo_colaboracion VARCHAR(100) NULL,
tipo_colaboracion2 VARCHAR(100) NULL,
tipo_colaboracion3 VARCHAR(100) NULL,
PRIMARY KEY (id_trabajadorpelicula)
);


CREATE TABLE IF NOT EXISTS actuaciones (
PELICULAS_id_pelicula INT NOT NULL,
PARTICIPANTES_id_trabajadorpelicula INT NOT NULL,
PRIMARY KEY (PELICULAS_id_pelicula, PARTICIPANTES_id_trabajadorpelicula),
INDEX fk_PELICULAS_has_PARTICIPANTES_PARTICIPANTES1_idx (PARTICIPANTES_id_trabajadorpelicula ASC),
INDEX fk_PELICULAS_has_PARTICIPANTES_PELICULAS1_idx (PELICULAS_id_pelicula ASC),
CONSTRAINT fk_PELICULAS_has_PARTICIPANTES_PELICULAS1
FOREIGN KEY (PELICULAS_id_pelicula)
REFERENCES peliculas (id_pelicula)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT fk_PELICULAS_has_PARTICIPANTES_PARTICIPANTES1
FOREIGN KEY (PARTICIPANTES_id_trabajadorpelicula)
REFERENCES participantes (id_trabajadorpelicula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
);



CREATE TABLE IF NOT EXISTS copias (
PEGI VARCHAR(100) NOT NULL,
formato VARCHAR(100) NULL,
tarifa DECIMAL(10,0) NULL,
PELICULAS_id_pelicula INT NOT NULL,
numero_copia INT NULL,
PRIMARY KEY (PEGI, PELICULAS_id_pelicula),
INDEX fk_COPIAS_PELICULAS1_idx (PELICULAS_id_pelicula ASC),
CONSTRAINT fk_COPIAS_PELICULAS1
FOREIGN KEY (PELICULAS_id_pelicula)
REFERENCES peliculas (id_pelicula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
);


CREATE TABLE IF NOT EXISTS clientes (
id_cliente INT NOT NULL,
nombre VARCHAR(100) NULL,
apellidos VARCHAR(100) NULL,
DNI VARCHAR(100) NULL,
fecha_nacimiento DATE NULL,
fecha_alta DATE NULL,
PRIMARY KEY (id_cliente)
);


CREATE TABLE IF NOT EXISTS alquileres (
COPIAS_PEGI VARCHAR(100) NOT NULL,
COPIAS_PELICULAS_id_pelicula INT NOT NULL,
CLIENTES_id_cliente INT NOT NULL,
fecha_alquiler DATE NULL,
fecha_devolucion DATE NULL,
pagado TINYINT(1) NULL,
PRIMARY KEY (COPIAS_PEGI, COPIAS_PELICULAS_id_pelicula, CLIENTES_id_cliente),
INDEX fk_COPIAS_has_CLIENTES_CLIENTES1_idx (CLIENTES_id_cliente ASC),
INDEX fk_COPIAS_has_CLIENTES_COPIAS1_idx (COPIAS_PEGI ASC, COPIAS_PELICULAS_id_pelicula ASC),
CONSTRAINT fk_COPIAS_has_CLIENTES_COPIAS1
FOREIGN KEY (COPIAS_PEGI , COPIAS_PELICULAS_id_pelicula)
REFERENCES copias (PEGI , PELICULAS_id_pelicula)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT fk_COPIAS_has_CLIENTES_CLIENTES1
FOREIGN KEY (CLIENTES_id_cliente)
REFERENCES clientes (id_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
);


CREATE TABLE IF NOT EXISTS proveedores (
id_proveedor INT NOT NULL AUTO_INCREMENT,
mail VARCHAR(45) NULL,
DNI VARCHAR(45) NULL,
nombre_contacto VARCHAR(45) NULL,
apellidos_contacto VARCHAR(45) NULL,
razon_social VARCHAR(45) NULL,
telefono_1 VARCHAR(45) NULL,
telefono_2 VARCHAR(45) NULL,
direccion VARCHAR(45) NULL,
PRIMARY KEY (id_proveedor)
);


CREATE TABLE IF NOT EXISTS pedidos (
COPIAS_PEGI VARCHAR(100) NOT NULL,
COPIAS_PELICULAS_id_pelicula INT NOT NULL,
PROVEEDORES_id_proveedor INT NOT NULL,
fecha_pedido VARCHAR(45) NULL,
PRIMARY KEY (COPIAS_PEGI, COPIAS_PELICULAS_id_pelicula, PROVEEDORES_id_proveedor),
INDEX fk_COPIAS_has_PROVEEDORES_PROVEEDORES1_idx (PROVEEDORES_id_proveedor ASC),
INDEX fk_COPIAS_has_PROVEEDORES_COPIAS1_idx (COPIAS_PEGI ASC, COPIAS_PELICULAS_id_pelicula ASC),
CONSTRAINT fk_COPIAS_has_PROVEEDORES_COPIAS1
FOREIGN KEY (COPIAS_PEGI , COPIAS_PELICULAS_id_pelicula)
REFERENCES copias (PEGI , PELICULAS_id_pelicula)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT fk_COPIAS_has_PROVEEDORES_PROVEEDORES1
FOREIGN KEY (PROVEEDORES_id_proveedor)
REFERENCES proveedores (id_proveedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
);