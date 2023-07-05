-- USERS
-- Uso del esquema de mysql para hacer cambios en usuarios.
USE mysql;

-- 1) Usuario que posee permiso de sólo lectura sobre todas las tablas
-- Creación del usuario "casas"
CREATE USER casas@localhost;
-- Se otorgan permisos de realizar SELECT sobre todos los objetos del esquema "Universidad".
GRANT SELECT ON Universidad.* TO casas@localhost;
-- Se asegura de haber revocado los permisos de borrado para este usuario en el esquema "Universidad".
REVOKE DELETE ON Universidad.* FROM casas@localhost;
-- Se visualizan los permisos otorgados para el usuario, para verificar que se cumpla lo esperado.
SHOW GRANTS FOR casas@localhost;

-- 2) Usuario con permisos de lectura, inserción y modificación de datos.
-- Creación del usuario "rodri", seteando una contraseña
CREATE USER rodri@localhost IDENTIFIED BY 'ContrasenaSuperSecreta.2307';
-- Se otorgan permisos de realizar SELECT, INSERT y UPDATE sobre todos los objetos del esquema "Universidad".
GRANT SELECT, INSERT, UPDATE ON Universidad.* TO rodri@localhost;
-- Se asegura de haber revocado los permisos de borrado para este usuario en el esquema "Universidad".
REVOKE DELETE ON Universidad.* FROM rodri@localhost;
-- Se visualizan los permisos otorgados para el usuario, para verificar que se cumpla lo esperado.
SHOW GRANTS FOR rodri@localhost;

-- Se vuelve al esquema "Universidad"
USE Universidad;
