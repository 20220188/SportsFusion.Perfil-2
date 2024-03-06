DROP database if EXISTS sportfusionDB;
CREATE DATABASE sportfusionDB;

USE sportfusionDB;

CREATE TABLE tb_deportes (
id_deporte INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_deporte VARCHAR(25)
);


CREATE TABLE tb_clientes (
id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_ciente VARCHAR(50),
dui_cliente VARCHAR(10) unique,
telefono_cliente VARCHAR(9),
correo_cliente VARCHAR(100),
dirección_cliente VARCHAR(250),
alias_cliente VARCHAR(50),
clave_cliente VARCHAR(64)
);

CREATE TABLE tb_administradores(
id_admin INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_admin VARCHAR(50),
dui_admin VARCHAR(10) UNIQUE,
telefono_admin VARCHAR(9),
correo_admin VARCHAR(100),
alias_admin VARCHAR(50),
clave_admin  VARCHAR(64)
);


CREATE TABLE tb_tipo_productos(
id_tipo_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
tipo_producto ENUM('Retro', 'Normal')
);

CREATE TABLE tb_categorias(
id_categoria INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_categoria ENUM('Zapatillas', 'Jerseys', 'shorts', 'Sneakers', 'implementes')
);

CREATE TABLE tb_opiniones(
id_opinion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
comentario VARCHAR(250),
opinion FLOAT
); 

CREATE TABLE tb_productos(
    id_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_producto VARCHAR(30),
    descripcion VARCHAR(250),
    precio DECIMAL(5,2),
    CONSTRAINT check_precio CHECK(precio > 0),
    cantidad_disponible INT,
    CONSTRAINT check_stock CHECK(cantidad_disponible >= 0),
    imagen VARCHAR(30),
    genero ENUM('Hombre', 'Mujer', 'Infantil'),
    id_tipo_producto INT,
    CONSTRAINT FK_tipoP_productos FOREIGN KEY(id_tipo_producto) REFERENCES tb_tipo_productos (id_tipo_producto)
);



CREATE TABLE tb_valoraciones_productos(
id_valoracion_producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_opinion INT,
CONSTRAINT FK_ipinion_valoracion_producto
FOREIGN KEY(id_opinion)
REFERENCES tb_opiniones (id_opinion),
id_producto INT,
CONSTRAINT FK_producto_valoracion_producto
FOREIGN KEY(id_producto)
REFERENCES tb_productos (id_producto),
id_cliente INT,
CONSTRAINT FK_cliente_valoracion_producto
FOREIGN KEY(id_cliente)
REFERENCES tb_clientes (id_cliente)
);

CREATE TABLE tb_productos_deportes(
id_proDep INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_producto INT, 
CONSTRAINT FK_producto_proDep
FOREIGN KEY(id_producto)
REFERENCES tb_productos (id_producto),
id_deporte INT,
CONSTRAINT FK_deportes_proDep
FOREIGN KEY(id_deporte)
REFERENCES tb_deportes (id_deporte)
);


CREATE TABLE tb_pedidos (
id_pedido INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
direccion_pedido VARCHAR(250),
estado_pedido ENUM('Pendiente', 'Finalizado', 'Entregado', 'Anulado'),
fecha_registro DATE,
id_cliente INT,
CONSTRAINT FK_pedido_cliente
FOREIGN KEY(id_cliente)
REFERENCES tb_clientes (id_cliente)
);

CREATE TABLE tb_detalle_pedidos (
id_detalle INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
cantidad_pedido SMALLINT(6),
precio_pedido NUMERIC(5,2),
id_pedido INT,
CONSTRAINT FK_detalle_pedido
FOREIGN KEY(id_pedido)
REFERENCES tb_pedidos (id_pedido),
id_producto INT, 
CONSTRAINT FK_detalle_producto
FOREIGN KEY(id_producto)
REFERENCES tb_productos (id_producto)
);



