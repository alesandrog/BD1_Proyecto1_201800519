TRUNCATE TABLE producto;
drop table pedido;
TRUNCATE TABLE producto;
drop table producto;
TRUNCATE TABLE categoriaProd;
drop table categoriaProd;

TRUNCATE TABLE persona;
drop table persona;
TRUNCATE TABLE codigoPostal;
drop table codigoPostal;
TRUNCATE TABLE ciudad;
drop table ciudad;
TRUNCATE TABLE region;
drop table region;


TRUNCATE TABLE tipoPersona;
drop table tipoPersona;
TRUNCATE TABLE compania;
drop table compania;

CREATE TABLE temporal(
    nombre_compania VARCHAR2(100),
    contacto_compania VARCHAR2(100),
    correo_compania VARCHAR2(100),
    telefono_compania VARCHAR2(20),
    tipo VARCHAR2(2),
    nombre VARCHAR2(100),
    correo VARCHAR2(100),
    telefono VARCHAR2(20),
    fecha_registro DATE,
    direccion VARCHAR2(75),
    ciudad VARCHAR2(50),
    codigo_postal INT,
    region VARCHAR2(50),
    producto VARCHAR2(100),
    categoria_producto VARCHAR2(50),
    cantidad INT,
    precio_unitario NUMBER(8,2)
);


CREATE TABLE compania(
    id_compania INT GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    nombre VARCHAR2(100),
    contacto VARCHAR2(100),
    correo VARCHAR2(100),
    telefono VARCHAR2(20)
);

CREATE TABLE tipoPersona(
    id_tipo INT GENERATED BY DEFAULT AS IDENTITY NOT  NULL PRIMARY KEY,
    tipo VARCHAR2(2)
);

CREATE TABLE region(
    id_region INT GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    nombre VARCHAR2(50)
);

CREATE TABLE ciudad(
    id_ciudad INT GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    nombre VARCHAR2(50),
    fk_id_region INT,
    FOREIGN KEY (fk_id_region) REFERENCES region(id_region)    
);


CREATE TABLE codigoPostal(
    id_codpostal  INT GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    numero_codigo INT,  
    fk_id_ciudad INT,
    FOREIGN KEY(fk_id_ciudad) REFERENCES ciudad(id_ciudad)
);


CREATE TABLE persona(
    id_persona INT  GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    nombre VARCHAR2(100),
    correo VARCHAR2(100),
    telefono VARCHAR2(20),
    direccion VARCHAR2(75),
    fecha_registro DATE,
    fk_id_tipo INT,
    fk_cod_postal INT,
    FOREIGN KEY (fk_id_tipo) REFERENCES tipoPersona(id_tipo), 
    FOREIGN KEY (fk_cod_postal) REFERENCES codigoPostal(id_codpostal)
);


CREATE TABLE categoriaProd(
    id_cat INT GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    descripcion VARCHAR2(50)
);

CREATE TABLE producto(
    id_producto INT GENERATED BY DEFAULT AS IDENTITY NOT NULL PRIMARY KEY,
    precio NUMBER(8,2),
    nombre VARCHAR2(100),
    fk_categoria INT,
    FOREIGN KEY (fk_categoria) REFERENCES categoriaProd(id_cat)
);

CREATE TABLE pedido (
    id_pedido INT GENERATED BY DEFAULT AS IDENTITY NOT NULL ,
    fk_id_persona INT,
    fk_id_compania INT,
    total NUMBER(8,2),
    fk_id_producto INT,    
    PRIMARY KEY(id_pedido, fk_id_persona, fk_id_compania, fk_id_producto),
    FOREIGN KEY(fk_id_persona) REFERENCES persona(id_persona),
    FOREIGN KEY(fk_id_compania) REFERENCES compania(id_compania),    
    FOREIGN KEY(fk_id_producto) REFERENCES producto(id_producto)
);