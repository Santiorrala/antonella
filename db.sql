-- drop database estetica;
DROP DATABASE IF EXISTS `estetica`;
create database estetica;
use estetica;

DROP TABLE IF EXISTS `est_s_roles`;
create table est_s_roles(
	ro_codigo int not null primary key,
    ro_nombre varchar(100) not null,
    ro_descripcion varchar(100) null,
    ro_estado int not null
);

DROP TABLE IF EXISTS `est_s_funcion`;
create table est_s_funcion(
	fu_codigo int not null primary key,
    ro_codigo int not null,
    fu_descripcion varchar(100) not null,
    fu_estado bool not null
);

DROP TABLE IF EXISTS `est_m_usuario`;
create table est_m_usuario(
	us_codigo int not null primary key,
    us_cedula varchar(10) not null unique,
    us_nombre varchar(100) not null,
    us_apellido varchar(100) not null,
    us_correo varchar(100) not null,
    us_telefono varchar(10) not null,
    us_clave varchar(100) not null,
    ro_codigo int not null,
    us_estado bool not null,
    us_comentarios varchar(100) null
);

DROP TABLE IF EXISTS `est_m_emplado`;
create table est_m_empleado(
	em_codigo int not null primary key,
    us_codigo int not null,
    em_especialidad varchar(100) null,
    em_fecha_contrato date null,
    em_hora_entrada varchar(5) not null,
    em_hora_salida varchar(5) not null
);

DROP TABLE IF EXISTS `est_m_cliente`;
create table est_m_cliente(
	cl_codigo int not null primary key,
    us_codigo int not null,
    cl_forma_pago varchar(100) null,
    cl_calificacion int null
);

DROP TABLE IF EXISTS `est_m_servicio`;
create table est_m_servicio(
	se_codigo int not null primary key,
    se_nombre varchar(100) not null,
    se_descripcion varchar(100) null,
    se_duracion int not null,
    se_precio varchar(100) not null,
    se_estado bool null
);

DROP TABLE IF EXISTS `est_m_cita`;
create table est_m_cita(
	ci_codigo int not null primary key,
    em_codigo int not null,
    cl_codigo int not null,
    ci_fecha date not null,
    ci_hora varchar(5) null,
    ci_estado bool not null,
    ci_nota varchar(100) null
);

DROP TABLE IF EXISTS `est_m_cita_servicio`;
create table est_m_cita_servicio(
	cs_codigo int not null primary key,
    ci_codigo int not null,
    se_codigo int not null
);

alter table est_s_funcion add constraint fk_funcion_rol foreign key (ro_codigo) references est_s_roles(ro_codigo);
alter table est_m_usuario add constraint fk_usuario_rol foreign key (ro_codigo) references est_s_roles(ro_codigo);
alter table est_m_empleado add constraint fk_empleado_usuario foreign key (us_codigo) references est_m_usuario(us_codigo);
alter table est_m_cliente add constraint fk_cliente_usuario foreign key (us_codigo) references est_m_usuario(us_codigo);
alter table est_m_cita add constraint fk_citas_empleado foreign key (em_codigo) references est_m_empleado(em_codigo);
alter table est_m_cita add constraint fk_citas_cliente foreign key (cl_codigo) references est_m_cliente(cl_codigo);
alter table est_m_cita_servicio add constraint fk_cita_cita foreign key (ci_codigo) references est_m_cita(ci_codigo);
alter table est_m_cita_servicio add constraint fk_cita_servicio foreign key (se_codigo) references est_m_servicio(se_codigo);





SELECT * FROM django_estetica.api_est_m_categoria;
use django_estetica;

DROP PROCEDURE IF EXISTS `pa_cCategorias` ;
DELIMITER ;;
CREATE PROCEDURE `pa_cCategorias`(e_id int, e_nombre varchar(100))
BEGIN
	if e_id = -1 then
		select ca_codigo, upper(ca_nombre),es_codigo_id es_codigo, ifnull(ca_imagen,'') ca_imagen from api_est_m_categoria where ca_nombre = e_nombre;
    else 
		select ca_codigo, upper(ca_nombre),es_codigo_id es_codigo, ifnull(ca_imagen,'') ca_imagen from api_est_m_categoria where ca_codigo = e_id;
	end if;
end;

DROP PROCEDURE IF EXISTS `pa_gCategorias` ;
DELIMITER ;;
CREATE PROCEDURE `pa_gCategorias`()
BEGIN
	select ca_codigo, upper(ca_nombre),es_codigo_id es_codigo, ifnull(ca_imagen,'') ca_imagen from api_est_m_categoria order by ca_codigo;
end;

DROP PROCEDURE IF EXISTS `pa_login` ;
DELIMITER ;;
CREATE PROCEDURE `pa_login`(e_cedula varchar(10), e_clave varchar(100))
BEGIN
	DECLARE v_claveEncrypt varchar(255);
    if exists (select 1 from api_est_m_usuario where us_estado=1 and us_cedula = e_cedula) then
		set v_claveEncrypt = TO_BASE64(AES_ENCRYPT(e_clave, 'esteticaAntonela'));
		select us_codigo, us_cedula, upper(us_nombre), upper(us_apellido), us_correo, us_telefono, ro_codigo_id from api_est_m_usuario where us_estado=1 and us_cedula = e_cedula and TO_BASE64(AES_ENCRYPT(us_clave, 'esteticaAntonela')) = v_claveEncrypt;
	else
		select -1 us_codigo, 'Usuario no existe' mensaje;
	end if;
end;

DROP PROCEDURE IF EXISTS `pa_cServicios` ;
DELIMITER ;;
CREATE PROCEDURE `pa_cServicios`(e_id int ,e_categoria int)
BEGIN
	if e_id <> -1 then
		select se_codigo, se_nombre, se_descripcion, se_duracion, se_precio, ca_codigo_id from api_est_m_servicio WHERE se_estado=1 and se_codigo = e_id;
	else
		select se_codigo, se_nombre, se_descripcion, se_duracion, se_precio, ca_codigo_id from api_est_m_servicio WHERE se_estado=1 and ca_codigo_id = e_categoria;
	end if;
end;

DROP PROCEDURE IF EXISTS `pa_cEmpleadoxServicio` ;
DELIMITER ;;
CREATE PROCEDURE `pa_cEmpleadoxServicio`(e_id int)
BEGIN
	select concat(upper(us.us_nombre), ' ', upper(us.us_apellido)) em_nombre, em.em_codigo, us_codigo, em_especialidad, em.em_hora_entrada, em.em_hora_salida, em_imagen from api_est_m_emplado em
	inner join api_est_m_usuario us on em.us_codigo_id = us_codigo
	inner join api_est_m_empleado_especialidad ee on em.em_codigo = ee.em_codigo_id
	inner join api_est_m_especialidad es on ee.es_codigo_id = es.es_codigo
	inner join api_est_m_categoria ca on ca.es_codigo_id = es.es_codigo 
	inner join api_est_m_servicio se on se.ca_codigo_id = ca.ca_codigo
	where se.se_codigo=e_id
	order by em.em_codigo;
end;

-- call IterarProductos
DROP PROCEDURE IF EXISTS `IterarProductos` ;
DELIMITER ;;
CREATE PROCEDURE IterarProductos()
BEGIN
    -- Declarar un cursor
    DECLARE done INT DEFAULT FALSE;
	DECLARE ide INT;
    DECLARE id INT;
    DECLARE hora VARCHAR(255);
    DECLARE cantidad INT;
    DECLARE entendido INT;
    DECLARE horaFlag VARCHAR(5);
    DECLARE horaNueva VARCHAR(5);
    
    -- Declarar un cursor para la tabla productos
    DECLARE cur CURSOR FOR 
        SELECT * 
        FROM lista1;
    
    -- Declarar un manejador para el fin del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    set horaFlag = '';
    SET SQL_SAFE_UPDATES = 0;
    
    -- Abrir el cursor
    OPEN cur;
    
    -- Leer cada fila del cursor
    read_loop: LOOP
        FETCH cur INTO ide, id, hora, cantidad, entendido;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        if(horaFlag = hora)
        then
            set horaNueva = LPAD(SUBSTRING(convert(substring(hora,1,2), UNSIGNED) + 1, 1, 2), 2, '0');
            update lista1 set hora = concat(horaNueva,':00') where iden=ide;
        end if;
        set horaFlag = hora;
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE cur;
    SET SQL_SAFE_UPDATES = 1;
END;

DROP PROCEDURE IF EXISTS `pa_horariosXFecha` ;
DELIMITER ;;
CREATE PROCEDURE `pa_horariosXFecha`(e_fecha varchar(10), e_empleado int)
BEGIN

	SET SQL_SAFE_UPDATES = 0;

	DROP TABLE IF EXISTS `lista`;
	CREATE TABLE lista (
		id INT,
		cantidad INT,
		nombre VARCHAR(255)
	);

	DROP TABLE IF EXISTS `lista1`;
	CREATE TABLE lista1 (
		iden int,
		id INT,
		hora VARCHAR(255),
		cantidad INT,
		entendido int
	);
	
    insert into lista
	select cs.cs_codigo, se.se_duracion, ci.ci_hora
	from api_est_m_cita ci
	inner join api_est_m_cita_servicio cs on cs.ci_codigo_id = ci.ci_codigo
	inner join api_est_m_emplado em on cs.em_codigo_id = em.em_codigo
    inner join api_est_m_servicio se on cs.se_codigo_id = se.se_codigo
	where ci_estado = 1 and ci_fecha = e_fecha and em.em_codigo=e_empleado;
    
    -- lista 1
    insert into lista1 
	-- Consulta para expandir las filas según la cantidad
	SELECT 
		ROW_NUMBER() OVER (ORDER BY sub.id, sub.row_num) AS identificador,
		sub.id,
		sub.nombre,
		sub.cantidad,
		sub.row_num AS nombre_extendido
	FROM (
		SELECT 
			l.id,
			l.nombre,
			l.cantidad,
			n.n AS row_num
		FROM 
			lista l
		JOIN 
			(SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) n 
		ON n.n <= l.cantidad
	) sub
	ORDER BY sub.id, sub.row_num;
    
    call IterarProductos;
    
    select * from (
		select 
				case 
				when hora = '08:00' then 8
				when hora = '09:00' then 9 
				when hora = '10:00' then 10 
				when hora = '11:00' then 11 
				when hora = '12:00' then 12 
				when hora = '13:00' then 13 
				when hora = '14:00' then 14 
				when hora = '15:00' then 15 
				when hora = '16:00' then 16 
				when hora = '17:00' then 17 
				when hora = '18:00' then 18 
				end as hora, hora ci_hora, e_empleado em_codigo
			from lista1
		)X order by X.hora;
end;

DROP PROCEDURE IF EXISTS `agendarCita` ;
DELIMITER ;;
CREATE PROCEDURE agendarCita(e_fecha varchar(10), e_hora int, e_empleado int, e_cliente int, e_servicio int)
BEGIN

	DECLARE v_ci_codigo int;
    DECLARE v_cs_codigo int;
    DECLARE v_cl_codigo int;
    DECLARE v_ci_hora varchar(100);
    DECLARE v_codigo int;
    DECLARE v_mensaje varchar(255);
	DECLARE exit handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT -1 AS codigo, MESSAGE_TEXT as mensaje;
	END;

    set v_ci_hora = (select concat(LPAD(concat('',e_hora,''), 2, '0'),':00'));
    
    START TRANSACTION;
    
		set v_ci_codigo = (select ifnull(max(ci_codigo),0)+1 from api_est_m_cita);
		insert into api_est_m_cita(ci_codigo,ci_fecha,ci_hora,ci_estado,ci_nota) values
		(v_ci_codigo, e_fecha, v_ci_hora, 1, 'Pendiente');
        
        set v_cs_codigo = (select ifnull(max(cs_codigo),0)+1 from api_est_m_cita_servicio);
        set v_cl_codigo = (select cl_codigo from api_est_m_cliente c inner join api_est_m_usuario u on c.us_codigo_id = u.us_codigo where u.us_codigo = e_cliente);
		insert into api_est_m_cita_servicio(cs_codigo, em_codigo_id, cl_codigo_id, ci_codigo_id, se_codigo_id) values
        (v_cs_codigo, e_empleado,  v_cl_codigo, v_ci_codigo, e_servicio);
		
	COMMIT;
    
		
        SELECT v_ci_codigo AS codigo, 'Cita agendada' as mensaje;
	
end;

DROP PROCEDURE IF EXISTS `pa_creaCorreo` ;
DELIMITER ;;
CREATE PROCEDURE pa_creaCorreo(e_cita int)
BEGIN

	select concat('Estimado ',upper(us.us_nombre),' ',upper(us.us_apellido),' le saluda la Estetica Antonella, se le informa que se ha realizado con exito su agenda con los siguientes datos. Fecha: ',ci_fecha,' - Hora: ',ci_hora)  mensaje, us_correo correo
    from api_est_m_cita ci
    inner join api_est_m_cita_servicio cs on cs.ci_codigo_id = ci.ci_codigo 
    inner join api_est_m_cliente cl on cs.cl_codigo_id = cl.cl_codigo
    inner join api_est_m_usuario us on cl.us_codigo_id = us.us_codigo
    where ci.ci_codigo = e_cita;
	
end;

DROP PROCEDURE IF EXISTS `pa_getHistorial` ;
DELIMITER ;;
CREATE PROCEDURE pa_getHistorial(e_usuario int, e_tipo int, e_cliemp int)
BEGIN
	-- 0 empleado
    -- 1 cliente
	if e_cliemp = 1 then 
		if e_tipo = 1 then
			SELECT 
				c.ci_codigo codigo_cita,
				c.ci_hora hora_cita,
				se.se_codigo codigo_servicio,
				se.se_nombre codigo_nombre,
				concat(se.se_duracion, case when se.se_duracion > 1 then ' horas' else ' hora' end) duracion,
				c.ci_estado codigo_estado,
				case when c.ci_estado = 1 then 'Pendiente' when c.ci_estado = 2 then 'Hecha' else 'Cancelada' end estado,
                concat(upper(u.us_nombre), ' ', upper(u.us_apellido)) cliente,
				concat(upper(uem.us_nombre), ' ', upper(uem.us_apellido)) empleado,
				c.ci_fecha as date,
				concat(DATE_FORMAT(ci_fecha, '%d-%m-%Y'),' ',c.ci_hora) fecha_hora
			FROM django_estetica.api_est_m_cita_servicio s
			inner join api_est_m_servicio se on se.se_codigo = s.se_codigo_id
			inner join api_est_m_cita c on c.ci_codigo = s.ci_codigo_id
			inner join api_est_m_emplado e on e.em_codigo = s.em_codigo_id
			inner join api_est_m_cliente cl on cl.cl_codigo = s.cl_codigo_id
			inner join api_est_m_usuario u on u.us_codigo = cl.us_codigo_id
			inner join api_est_m_usuario uem on uem.us_codigo = e.us_codigo_id
			where u.us_codigo = e_usuario
			order by c.ci_fecha, c.ci_codigo;
		else
			SELECT 
				c.ci_codigo codigo_cita,
				c.ci_hora hora_cita,
				se.se_codigo codigo_servicio,
				se.se_nombre codigo_nombre,
				concat(se.se_duracion, case when se.se_duracion > 1 then ' horas' else ' hora' end) duracion,
				c.ci_estado codigo_estado,
				case when c.ci_estado = 1 then 'Pendiente' when c.ci_estado = 2 then 'Hecha' else 'Cancelada' end estado,
                concat(upper(u.us_nombre), ' ', upper(u.us_apellido)) cliente,
				concat(upper(uem.us_nombre), ' ', upper(uem.us_apellido)) empleado,
				c.ci_fecha,
				concat(DATE_FORMAT(ci_fecha, '%d-%m-%Y'),' ',c.ci_hora) fecha_hora
			FROM django_estetica.api_est_m_cita_servicio s
			inner join api_est_m_servicio se on se.se_codigo = s.se_codigo_id
			inner join api_est_m_cita c on c.ci_codigo = s.ci_codigo_id
			inner join api_est_m_emplado e on e.em_codigo = s.em_codigo_id
			inner join api_est_m_cliente cl on cl.cl_codigo = s.cl_codigo_id
			inner join api_est_m_usuario u on u.us_codigo = cl.us_codigo_id
			inner join api_est_m_usuario uem on uem.us_codigo = e.us_codigo_id
			where u.us_codigo = e_usuario and c.ci_estado = 1
			order by c.ci_fecha, c.ci_codigo;
		end if;
	else
		select
			c.ci_codigo codigo_cita,
			c.ci_hora hora_cita,
			se.se_codigo codigo_servicio,
			se.se_nombre codigo_nombre,
			concat(se.se_duracion, case when se.se_duracion > 1 then ' horas' else ' hora' end) duracion,
			c.ci_estado codigo_estado,
			case when c.ci_estado = 1 then 'Pendiente' when c.ci_estado = 2 then 'Hecha' else 'Cancelada' end estado,
            concat(upper(u.us_nombre), ' ', upper(u.us_apellido)) cliente,
			concat(upper(uem.us_nombre), ' ', upper(uem.us_apellido)) empleado,
			c.ci_fecha,
			concat(DATE_FORMAT(ci_fecha, '%d-%m-%Y'),' ',c.ci_hora) fecha_hora
		FROM django_estetica.api_est_m_cita_servicio s
		inner join api_est_m_servicio se on se.se_codigo = s.se_codigo_id
		inner join api_est_m_cita c on c.ci_codigo = s.ci_codigo_id
		inner join api_est_m_emplado e on e.em_codigo = s.em_codigo_id
		inner join api_est_m_cliente cl on cl.cl_codigo = s.cl_codigo_id
		inner join api_est_m_usuario u on u.us_codigo = cl.us_codigo_id
		inner join api_est_m_usuario uem on uem.us_codigo = e.us_codigo_id
		where uem.us_codigo = e_usuario and c.ci_estado = 1
		order by c.ci_fecha, c.ci_codigo;
	end if;
    
end;

DROP PROCEDURE IF EXISTS `pa_cancelaCita` ;
DELIMITER ;;
CREATE PROCEDURE pa_cancelaCita(e_cita int)
BEGIN

	update api_est_m_cita set ci_estado = 3, ci_nota = 'Cancelada' where ci_codigo = e_cita;
	-- update api_est_m_cita set ci_estado = 1, ci_nota = 'Pendiente' where ci_codigo = 8;
end;

DROP PROCEDURE IF EXISTS `pa_generaPdfTodo` ;
DELIMITER ;;
CREATE PROCEDURE pa_generaPdfTodo(e_fecha_inicio varchar(10), e_fecha_fin varchar(10))
BEGIN

	select  
		ca.ca_codigo,
        ca.ca_nombre,
        se.se_codigo,
        se.se_nombre,
        ci.ci_fecha,
        ci.ci_hora,
        concat(upper(usc.us_nombre), ' ', upper(usc.us_apellido)) cliente,
        concat(upper(usem.us_nombre), ' ', upper(usem.us_apellido)) empleado,
        ci.ci_estado,
        case when ci.ci_estado = 1 then 'Pendiente' when ci.ci_estado = 2 then 'Hecho' else 'Cancelada' end estado_des
    from api_est_m_cita ci
    inner join api_est_m_cita_servicio cs on cs.ci_codigo_id = ci.ci_codigo
    inner join api_est_m_servicio se on se.se_codigo = cs.se_codigo_id
    inner join api_est_m_categoria ca on ca.ca_codigo = se.ca_codigo_id
    inner join api_est_m_cliente cl on cl.cl_codigo = cs.cl_codigo_id
    inner join api_est_m_usuario usc on usc.us_codigo = cl.us_codigo_id
    inner join api_est_m_emplado em on em.em_codigo = cs.cl_codigo_id
    inner join api_est_m_usuario usem on usem.us_codigo = em.us_codigo_id
	where ci.ci_fecha between e_fecha_inicio and e_fecha_fin
    order by ci.ci_codigo;
	
end;

DROP PROCEDURE IF EXISTS `pa_generaPdfEsp` ;
DELIMITER ;;
CREATE PROCEDURE pa_generaPdfEsp(e_categoria int, e_servicio int, e_fecha_inicio varchar(10), e_fecha_fin varchar(10))
BEGIN

	select  
		ca.ca_codigo,
        ca.ca_nombre,
        se.se_codigo,
        se.se_nombre,
        ci.ci_fecha,
        ci.ci_hora,
        concat(upper(usc.us_nombre), ' ', upper(usc.us_apellido)) cliente,
        concat(upper(usem.us_nombre), ' ', upper(usem.us_apellido)) empleado,
        ci.ci_estado,
        case when ci.ci_estado = 1 then 'Pendiente' when ci.ci_estado = 2 then 'Hecho' else 'Cancelada' end estado_des
    from api_est_m_cita ci
    inner join api_est_m_cita_servicio cs on cs.ci_codigo_id = ci.ci_codigo
    inner join api_est_m_servicio se on se.se_codigo = cs.se_codigo_id
    inner join api_est_m_categoria ca on ca.ca_codigo = se.ca_codigo_id
    inner join api_est_m_cliente cl on cl.cl_codigo = cs.cl_codigo_id
    inner join api_est_m_usuario usc on usc.us_codigo = cl.us_codigo_id
    inner join api_est_m_emplado em on em.em_codigo = cs.cl_codigo_id
    inner join api_est_m_usuario usem on usem.us_codigo = em.us_codigo_id
	where ci.ci_fecha between e_fecha_inicio and e_fecha_fin and ca.ca_codigo = e_categoria and se.se_codigo = e_servicio
    order by ci.ci_codigo;
	
end;

DROP PROCEDURE IF EXISTS `pa_registrarCliente` ;
DELIMITER ;;
CREATE PROCEDURE pa_registrarCliente(e_cedula varchar(10), e_nombre varchar(100), e_apellido varchar(100), e_correo varchar(100), e_telefono varchar(10), e_clave varchar(100))
BEGIN
	DECLARE v_us_codigo int;
    set v_us_codigo = (select ifnull(max(us_codigo),0)+1 from api_est_m_usuario);
	insert into api_est_m_usuario values
	(v_us_codigo, e_cedula, e_nombre, e_apellido, e_correo, e_telefono, e_clave, 1, 1, '');
    select 0 codigo_error, 'Cliente Registrado' mensaje;
end;

select 
    *
from api_est_m_cita 

use django_estetica
call pa_gCategorias();
call pa_cCategorias(1,'');
call pa_login('2300238841','123456');
call pa_cServicios(-1,1);
call pa_cEmpleadoxServicio(1);
call pa_horariosXFecha('2024-08-13',2)
call pa_creaCorreo('7')
call pa_getHistorial(1,1,2)
-- call agendarCita('2024-08-13',12,2,1,3) 

delete from api_est_m_cita_servicio where cs_codigo>=6;
delete from api_est_m_cita where ci_codigo > 6;
