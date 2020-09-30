OPTIONS (SKIP=1)
LOAD DATA 
INFILE 'DataCenterData.csv'
INTO TABLE temporal
FIELDS TERMINATED BY ";"
(
    nombre_compania         ,
    contacto_compania       ,
    correo_compania         ,
    telefono_compania     "substr(:telefono_compania, 1, 3) || substr(:telefono_compania, 5,7)|| substr(:telefono_compania, 9,12)"  ,
    tipo                    ,   
    nombre                  ,
    correo                  ,
    telefono              "substr(:telefono, 1, 3) || substr(:telefono, 5,7)|| substr(:telefono, 9,12)"  ,
    fecha_registro        "TO_DATE(:fecha_registro, 'DD/MM/YYYY', 'NLS_DATE_LANGUAGE=ENGLISH')" ,
    direccion               ,
    ciudad                  ,
    codigo_postal           ,
    region                  ,
    producto                ,
    categoria_producto      ,
    cantidad                ,
    precio_unitario         
)

