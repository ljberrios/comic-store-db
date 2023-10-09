REM ***************************************************************
REM *   Author     : Luis J. Berrios Negron                       *
REM *   Num.Est    : 802-18-1607                                  *
REM *   Curso      : SICI-4030                                    *
REM *   Seccion    : KH1                                          *
REM *   Source     : Script.sql							          *
REM *   Comentario : Este script es para la base de datos		  *
REM	*				 de una tienda de comics.					  *
REM ***************************************************************
REM ***************************************************************
REM *  EL SET ECHO ON permite ver la corrida en pantalla.         *
REM ***************************************************************
SET ECHO ON
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM
REM ***************************************************************
REM *   Aquo se borran las tablas en caso de tener que volver a   *
REM *  crearlas, esta sub dividio por niveles.                    *
REM ***************************************************************
DROP TABLE BKISSUE_STOCK;
DROP TABLE CURISSUE_STOCK;
DROP TABLE RESERVATION;
DROP TABLE ORDER_ITEMS;
DROP TABLE ORDERS;
DROP TABLE MEMBER;
DROP TABLE EMPLOYEE;
DROP TABLE STORE;
DROP TABLE CURRENT_ISSUE;
DROP TABLE BACK_ISSUE;
DROP TABLE COMPANY;
DROP TABLE OFFICE;
DROP TABLE ADDRESS;
DROP TABLE CITY;
DROP TABLE STATE;
DROP SEQUENCE member_seq;
DROP SEQUENCE order_seq;
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla STATE nivel-1       		                  *
REM ***************************************************************
CREATE TABLE STATE (
	id_pk						NUMBER(6)		NOT NULL,
	state						VARCHAR2(20)	NOT NULL,
CONSTRAINT pk_state				PRIMARY KEY (id_pk));
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla CITY nivel-2         	                  *
REM ***************************************************************
CREATE TABLE CITY (
	id_pk						NUMBER(6)	    NOT NULL,
	city						VARCHAR2(20)	NOT NULL,
	state_id_fk					NUMBER(6)		NOT NULL,
CONSTRAINT pk_city				PRIMARY KEY (id_pk),
CONSTRAINT fk_city_state		FOREIGN KEY (state_id_fk) REFERENCES STATE(id_pk));
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla ADDRESS nivel-2         	                  *
REM ***************************************************************
CREATE TABLE ADDRESS (
	id_pk						NUMBER(6)		NOT NULL,
	line_1						VARCHAR2(200)	NOT NULL,
	line_2						VARCHAR2(200),
	zip_code					NUMBER(5)		NOT NULL,
	city_id_fk1					NUMBER(6)		NOT NULL,
CONSTRAINT pk_address			PRIMARY KEY (id_pk),
CONSTRAINT fk_address_city		FOREIGN KEY (city_id_fk1) REFERENCES CITY(id_pk));
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla OFFICE nivel-2         	                  *
REM ***************************************************************
CREATE TABLE OFFICE (
	id_pk						NUMBER(6)		NOT NULL,
	phone_number				NUMBER(10)		NOT NULL,
	email						VARCHAR2(50)	NOT NULL,
	address_id_fk				NUMBER(6)		NOT NULL,
CONSTRAINT pk_office			PRIMARY KEY (id_pk),
CONSTRAINT fk_office_address	FOREIGN KEY (address_id_fk) REFERENCES ADDRESS(id_pk));	
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla COMPANY nivel-2         	                  *
REM ***************************************************************
CREATE TABLE COMPANY (
	id_pk						NUMBER(6)		NOT NULL,
	name						VARCHAR2(50)	NOT NULL,
	phone_number				NUMBER(10)		NOT NULL,
	email						VARCHAR(50)		NOT NULL,
	address_id_fk				NUMBER(6)		NOT NULL,
CONSTRAINT pk_company			PRIMARY KEY (id_pk),
CONSTRAINT fk_company_address	FOREIGN KEY (address_id_fk) REFERENCES ADDRESS(id_pk));
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla BACK_ISSUE nivel-2         	              *
REM ***************************************************************
CREATE TABLE BACK_ISSUE (
	id_pk						NUMBER(10)		NOT NULL,
	title						VARCHAR2(100)	NOT NULL,
	initial_price				NUMBER(5,2)		NOT NULL,
	current_price				NUMBER(5,2)		NOT NULL,
	synopsis					VARCHAR2(300)	NOT NULL,
	note						VARCHAR2(300),
	company_id_fk				NUMBER(6)		NOT NULL,
CONSTRAINT pk_bkissue			PRIMARY KEY (id_pk),
CONSTRAINT fk_bkissue_company	FOREIGN KEY (company_id_fk) REFERENCES COMPANY(id_pk));
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla CURRENT_ISSUE nivel-2         	          *
REM ***************************************************************
CREATE TABLE CURRENT_ISSUE (
	id_pk						NUMBER(10)		NOT NULL,
	title						VARCHAR2(100)	NOT NULL,
	tagged_price				NUMBER(5,2)		NOT NULL,
	company_id_fk				NUMBER(6)		NOT NULL,
CONSTRAINT pk_curissue			PRIMARY KEY (id_pk),
CONSTRAINT fk_curissue_company	FOREIGN KEY (company_id_fk) REFERENCES COMPANY(id_pk));
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla STORE nivel-2 		        	          *
REM ***************************************************************
CREATE TABLE STORE (
	id_pk						NUMBER(6)		NOT NULL,
	name						VARCHAR2(50)	NOT NULL,
	phone_number				NUMBER(10)		NOT NULL,
	email						VARCHAR2(50)	NOT NULL,
	latitude					NUMBER(8,4)		NOT NULL,
	longitude					NUMBER(8,4)		NOT NULL,
	address_id_fk				NUMBER(6)		NOT NULL,
CONSTRAINT pk_store				PRIMARY KEY (id_pk),
CONSTRAINT fk_store_address		FOREIGN KEY (address_id_fk) REFERENCES ADDRESS(id_pk));
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla EMPLOYEE nivel-3 		        	      *
REM ***************************************************************
CREATE TABLE EMPLOYEE (
	id_pk						NUMBER(6)		NOT NULL,
	first_name					VARCHAR2(30)	NOT NULL,
	last_name					VARCHAR2(30)	NOT NULL,
	phone_number				NUMBER(10)		NOT NULL,
	email						VARCHAR2(50)	NOT NULL,
	birth_date					DATE			NOT NULL,
	position					VARCHAR2(30)	NOT NULL,
	monthly_wage				NUMBER(8,2),
	hourly_pay					NUMBER(5,2),
	weekly_hours				NUMBER(3),
	contract_number				NUMBER(4),
	contract_pay				NUMBER(6),
	address_id_fk1				NUMBER(6)		NOT NULL,
	store_id_fk2				NUMBER(6),
	office_id_fk3				NUMBER(6),
	manager_id_fk4				NUMBER(6),
CONSTRAINT pk_employee			PRIMARY KEY (id_pk),
CONSTRAINT fk_employee_address	FOREIGN KEY (address_id_fk1) REFERENCES ADDRESS(id_pk),
CONSTRAINT fk_employee_store	FOREIGN KEY (store_id_fk2)   REFERENCES STORE(id_pk),
CONSTRAINT fk_employee_office	FOREIGN KEY (office_id_fk3)	 REFERENCES OFFICE(id_pk),
CONSTRAINT fk_employee_employee	FOREIGN KEY (manager_id_fk4) REFERENCES EMPLOYEE(id_pk));
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla MEMBER nivel-3 			        	      *
REM ***************************************************************
CREATE TABLE MEMBER (
	id_pk						NUMBER(6)		NOT NULL,
	first_name					VARCHAR2(30)	NOT NULL,
	last_name					VARCHAR2(30)	NOT NULL,
	phone_number				NUMBER(10)		NOT NULL,
	email						VARCHAR2(50)	NOT NULL,
	membership					CHAR(1)			NOT NULL,
	address_id_fk1				NUMBER(6)		NOT NULL,
	store_id_fk2				NUMBER(6)		NOT NULL,
CONSTRAINT pk_member			PRIMARY KEY (id_pk),
CONSTRAINT fk_member_address	FOREIGN KEY (address_id_fk1) REFERENCES ADDRESS(id_pk),
CONSTRAINT fk_member_store		FOREIGN KEY (store_id_fk2)	 REFERENCES STORE(id_pk));

CREATE SEQUENCE member_seq 
	START WITH 1
	INCREMENT BY 1
	NOCACHE;
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla ORDERS nivel-3 			        	      *
REM ***************************************************************
CREATE TABLE ORDERS (
	id_pk						NUMBER(6)		NOT NULL,
	date_time					TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	member_id_fk1				NUMBER(6)		NOT NULL,
	store_id_fk2				NUMBER(6)		NOT NULL,
	employee_id_fk3				NUMBER(6)		NOT NULL,
CONSTRAINT pk_orders			PRIMARY KEY (id_pk),
CONSTRAINT fk_orders_member		FOREIGN KEY (member_id_fk1)   REFERENCES MEMBER(id_pk),
CONSTRAINT fk_orders_store		FOREIGN KEY (store_id_fk2)    REFERENCES STORE(id_pk),
CONSTRAINT fk_orders_employee	FOREIGN KEY (employee_id_fk3) REFERENCES EMPLOYEE(id_pk));

CREATE SEQUENCE order_seq
	START WITH 1
	INCREMENT BY 1
	NOCACHE;
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla ORDER_ITEMS nivel-3 			        	  *
REM ***************************************************************
CREATE TABLE ORDER_ITEMS (
	order_id_pk_fk1				NUMBER(6)		NOT NULL,
	item_number_pk				NUMBER(2)		NOT NULL,
	quantity					NUMBER(2)		NOT NULL,
	sale_price					NUMBER(5,2)		NOT NULL,
	bkissue_id_fk2				NUMBER(10),
	curissue_id_fk3				NUMBER(10),
CONSTRAINT pk_oitems			PRIMARY KEY (order_id_pk_fk1, item_number_pk),
CONSTRAINT fk_oitems_bkissue 	FOREIGN KEY (bkissue_id_fk2)  REFERENCES BACK_ISSUE(id_pk),
CONSTRAINT fk_oitems_curissue	FOREIGN KEY (curissue_id_fk3) REFERENCES CURRENT_ISSUE(id_pk));
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla RESERVATION nivel-3 			        	  *
REM ***************************************************************
CREATE TABLE RESERVATION (
	member_id_pk_fk1			NUMBER(6)		NOT NULL,
	date_time_pk				TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	quantity					NUMBER(3)		NOT NULL,
	curissue_id_fk2				NUMBER(10)		NOT NULL,
CONSTRAINT pk_reserv			PRIMARY KEY (member_id_pk_fk1, date_time_pk),
CONSTRAINT fk_reserv_member		FOREIGN KEY (member_id_pk_fk1) REFERENCES MEMBER(id_pk),
CONSTRAINT fk_reserv_curissue	FOREIGN KEY (curissue_id_fk2)  REFERENCES CURRENT_ISSUE(id_pk));
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla BKISSUE_STOCK nivel-3 			       	  *
REM ***************************************************************
CREATE TABLE BKISSUE_STOCK (
	bkissue_id_pk_fk1			NUMBER(10)		NOT NULL,
	store_id_pk_fk2				NUMBER(6)		NOT NULL,
	copies_available			NUMBER(4)		NOT NULL,
CONSTRAINT pk_bkstock			PRIMARY KEY (bkissue_id_pk_fk1, store_id_pk_fk2),
CONSTRAINT fk_bkstock_bkissue	FOREIGN KEY (bkissue_id_pk_fk1) REFERENCES BACK_ISSUE(id_pk),
CONSTRAINT fk_bkstock_store		FOREIGN KEY (store_id_pk_fk2)	REFERENCES STORE(id_pk));
REM ***************************************************************
REM * Las proximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Creacion tabla CURISSUE_STOCK nivel-3 			       	  *
REM ***************************************************************
CREATE TABLE CURISSUE_STOCK (
	curissue_id_pk_fk1			NUMBER(10)		NOT NULL,
	store_id_pk_fk2				NUMBER(6)		NOT NULL,
	copies_acquired				NUMBER(4)		NOT NULL,
CONSTRAINT pk_curstock			PRIMARY KEY (curissue_id_pk_fk1, store_id_pk_fk2),
CONSTRAINT fk_curstock_curissue	FOREIGN KEY (curissue_id_pk_fk1) REFERENCES CURRENT_ISSUE(id_pk),
CONSTRAINT fk_curstock_store	FOREIGN KEY (store_id_pk_fk2)	 REFERENCES STORE(id_pk));
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: STATE	                              *
REM ***************************************************************
INSERT INTO STATE (id_pk, state) VALUES ('625310', 'Mississippi');
INSERT INTO STATE (id_pk, state) VALUES ('165119', 'Delaware');
INSERT INTO STATE (id_pk, state) VALUES ('151391', 'Connecticut');
INSERT INTO STATE (id_pk, state) VALUES ('648952', 'Pennsylvania');
INSERT INTO STATE (id_pk, state) VALUES ('999749', 'Oregon');
INSERT INTO STATE (id_pk, state) VALUES ('103732', 'Washington');
INSERT INTO STATE (id_pk, state) VALUES ('186428', 'Missouri');
INSERT INTO STATE (id_pk, state) VALUES ('929641', 'Illinois');
INSERT INTO STATE (id_pk, state) VALUES ('224123', 'Georgia');
INSERT INTO STATE (id_pk, state) VALUES ('839434', 'Arizona');
INSERT INTO STATE (id_pk, state) VALUES ('938466', 'Michigan');
INSERT INTO STATE (id_pk, state) VALUES ('127435', 'Florida');
INSERT INTO STATE (id_pk, state) VALUES ('917655', 'Wyoming');
INSERT INTO STATE (id_pk, state) VALUES ('990195', 'Utah');
INSERT INTO STATE (id_pk, state) VALUES ('265251', 'Texas');
INSERT INTO STATE (id_pk, state) VALUES ('264175', 'California');
INSERT INTO STATE (id_pk, state) VALUES ('712180', 'Virginia');
INSERT INTO STATE (id_pk, state) VALUES ('592572', 'New York');
INSERT INTO STATE (id_pk, state) VALUES ('719905', 'Nevada');
INSERT INTO STATE (id_pk, state) VALUES ('625314', 'Puerto Rico');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: CITY	                              *
REM ***************************************************************
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('417541', 'Bridgeport', '151391');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('934739', 'Portland', '999749');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('507844', 'San Juan', '625314');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('134032', 'Salt Lake City', '990195');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('926211', 'Provo', '990195');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('974278', 'Seattle', '103732');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('553121', 'San Francisco', '264175');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('549866', 'Guaynabo', '625314');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('907488', 'Orlando', '127435');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('319587', 'Las Vegas', '719905');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('555090', 'New York City', '592572');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('855214', 'Cheyenne', '917655');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('873447', 'Tacoma', '103732');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('334664', 'Chicago', '929641');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('441338', 'Atlanta', '224123');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('386012', 'Ponce', '625314');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('818303', 'Phoenix', '839434');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('477829', 'Austin', '265251');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('724058', 'Dallas', '265251');
INSERT INTO CITY (id_pk, city, state_id_fk) VALUES ('790962', 'Palo Alto', '264175');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: ADDRESS	                          *
REM ***************************************************************
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('626878', '#1 Apple St.', NULL, '00123', '417541');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('128998', '#2 Apple St', 'Kiwi Blvd.', '12300', '549866');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('227373', '#3 Apple St', 'Pineapple Av.', '00890', '441338');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('849611', '#4 Apple St', 'Pickle Blvd.', '99432', '818303');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('990166', '#5 Apple St', NULL, '00313', '818303');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('712539', '#6 Apple St', NULL, '00300', '818303');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('181557', '#7 Apple St', NULL, '12345', '507844');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('184226', '#8 Apple St', NULL, '12345', '507844');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('742874', '#9 Apple St', NULL, '12345', '507844');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('992019', '#10 Apple St', NULL, '12345', '507844');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('965677', '#11 Apple St', NULL, '12345', '507844');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('673521', '#12 Apple St', NULL, '12345', '549866');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('715455', '#13 Apple St', NULL, '54321', '549866');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('585186', '#14 Apple St', 'Donut Av.', '12345', '549866');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('656038', '#15 Apple St', NULL, '12345', '549866');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('902963', '#16 Apple St', NULL, '12345', '549866');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('776210', '#17 Apple St', NULL, '12345', '549866');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('604725', '#18 Apple St', NULL, '12345', '549866');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('929119', '#19 Apple St', NULL, '12345', '386012');
INSERT INTO ADDRESS (id_pk, line_1, line_2, zip_code, city_id_fk1) VALUES ('757225', '#20 Apple St', NULL, '12345', '386012');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: OFFICE	                          *
REM ***************************************************************
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('636610', '8364477191', 'djerg0@cargocollective.com', '626878');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('786250', '6322480110', 'wroblou1@mapy.cz', '849611');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('762970', '2476375173', 'egascoyne2@techcrunch.com', '128998');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('254504', '4417998047', 'fcantopher3@hao123.com', '227373');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('638570', '1447420235', 'clemonby4@comcast.net', '990166');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('606121', '7632661687', 'esore5@studiopress.com', '990166');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('768368', '5871530174', 'hhadaway6@marketwatch.com', '712539');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('110114', '3484540364', 'zisitt7@pen.io', '181557');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('732492', '1694128470', 'bsaladine8@craigslist.org', '184226');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('922600', '7631713666', 'ahayesman9@rakuten.co.jp', '742874');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('361845', '1901632409', 'flittlewooda@msn.com', '992019');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('557060', '5085630928', 'dbenediktssonb@merriam-webster.com', '992019');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('269837', '5179763028', 'jhardenc@cocolog-nifty.com', '965677');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('751356', '3788161635', 'mbuffeyd@telegraph.co.uk', '673521');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('295543', '6235187468', 'ttathacotte@gizmodo.com', '715455');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('885565', '6736103884', 'sbartzenf@amazon.co.jp', '585186');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('369980', '7331162187', 'rkocherg@youku.com', '585186');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('235084', '9119230836', 'jlidgertwoodh@bbc.co.uk', '604725');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('754791', '8408304707', 'dsmyleyi@webs.com', '929119');
INSERT INTO OFFICE (id_pk, phone_number, email, address_id_fk) VALUES ('248017', '1454049761', 'gchastneyj@weather.com', '757225');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: COMPANY	                          *
REM ***************************************************************
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('563603', 'Raynor-Howell', '8844189897', 'bandryunin0@com.com', '742874');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('488650', 'Stamm LLC', '9512206090', 'bcracker1@answers.com', '992019');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('227529', 'Mayert, McLaughlin and Hudson', '1441489524', 'ssimmins2@imgur.com', '965677');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('577493', 'Wisozk-Medhurst', '1363083816', 'vgroarty3@amazonaws.com', '673521');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('479031', 'Nienow and Sons', '2566496770', 'mpittway4@usgs.gov', '715455');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('234379', 'Jenkins LLC', '4447154114', 'lstudders5@skyrock.com', '585186');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('578290', 'Schowalter-Breitenberg', '3863103897', 'jcushelly6@usgs.gov', '656038');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('546948', 'Gottlieb and Sons', '6113246292', 'rcroan7@csmonitor.com', '902963');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('402103', 'Bergnaum Group', '1621201237', 'cineson8@a8.net', '776210');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('723245', 'Price LLC', '3288013442', 'rhart9@cnn.com', '604725 ');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('365269', 'Leffler-Johnson', '8434186445', 'aholcrofta@weebly.com', '626878');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('936758', 'Hamill and Sons', '4171805859', 'otreffreyb@1und1.de', '128998');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('481165', 'Gislason, Hegmann and Renner', '3567288544', 'wlubbockc@ox.ac.uk', '227373');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('850829', 'Murray, Tremblay and Smitham', '2173548186', 'twealdd@indiegogo.com', '849611');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('202600', 'Armstrong-Runolfsson', '4644664120', 'ptubritte@blogspot.com', '990166');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('899346', 'Hackett, Parisian and Hyatt', '5838614040', 'apaddemoref@cbc.ca', '712539');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('239048', 'Kulas LLC', '8945531316', 'rcrockg@miibeian.gov.cn', '181557');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('419157', 'Stokes-Hettinger', '6528281756', 'ostenetth@edublogs.org', '184226');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('378283', 'Emard Inc', '9354609104', 'ephalipi@newyorker.com', '742874');
INSERT INTO COMPANY (id_pk, name, phone_number, email, address_id_fk) VALUES ('569618', 'Cormier Group', '2883073760', 'cthrossellj@jalbum.net', '992019');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: BACK_ISSUE	                      *
REM ***************************************************************
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('8368528614', 'S.O.S. Eisberg', '18.31', '16.50', 'ut dolor morbi vel lectus in quam', NULL, '563603');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('6108773228', 'Days of Thunder', '9.74', '8.33', 'in purus eu magna vulputate luctus', NULL, '563603');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('2451685182', 'Lymelife', '8.71', '6.78', 'elementum in hac habitasse platea dictumst morbi vestibulum', NULL, '563603');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('1649637933', 'Gunless', '19.33', '15.62', 'sit amet nunc viverra dapibus', NULL, '577493');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('4963429414', 'Corpse Bride', '13.94', '15.30', 'sagittis sapien cum sociis natoque penatibus', NULL, '577493');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('5353222927', 'Albert Nobbs', '6.23', '16.25', 'nunc donec quis orci eget orci vehicula condimentum curabitur in', NULL, '577493');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('6041609524', 'Alexandra (Aleksandra)', '5.71', '13.06', 'non mi integer ac neque duis bibendum', 'donec dapibus duis at velit eu est congue elementum', '578290');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('9640674162', 'Wish I Was Here', '5.93', '7.65', 'bibendum felis sed interdum venenatis turpis', NULL, '578290');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('7160102043', 'Counter Investigation (Contre-enquete)', '7.86', '4.99', 'lorem integer tincidunt ante vel', 'luctus rutrum nulla tellus in sagittis dui', '578290');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('8284377148', 'Gospel, The', '15.68', '3.02', 'mi sit amet lobortis sapien', 'quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt', '723245');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('5064203334', 'We Stand Alone Together', '11.67', '6.09', 'turpis adipiscing lorem vitae mattis', NULL, '723245');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('1802247867', 'Let Sleeping Corpses Lie (Non si deve profanare il sonno dei morti)', '18.2', '13.88', 'sit amet erat nulla tempus vivamus in', NULL, '723245');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('4798546938', 'Inspector General, The', '11.05', '6.75', 'eros viverra eget congue eget semper', NULL, '481165');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('1072474161', 'No Man of Her Own', '8.74', '13.34', 'aliquam erat volutpat in congue', NULL, '850829');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('6704994052', 'Executioners from Shaolin', '18.13', '6.94', 'nunc rhoncus dui vel sem sed sagittis nam congue', 'lacinia sapien quis libero nullam', '239048');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('5613296366', 'Divided We Fall (Musime si pomahat)', '9.36', '9.14', 'adipiscing molestie hendrerit at vulputate vitae nisl', NULL, '239048');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('9125132136', 'Zelary', '19.25', '4.83', 'nullam molestie nibh in lectus pellentesque at', 'tellus in sagittis dui vel nisl duis ac nibh', '239048');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('3553707657', 'Hansel and Gretel: Witch Hunters', '9.03', '6.70', 'quisque porta volutpat erat quisque erat', NULL, '569618');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('7517889198', 'Lost Highway', '7.97', '4.33', 'morbi odio odio elementum eu interdum eu tincidunt', NULL, '569618');
INSERT INTO BACK_ISSUE (id_pk, title, initial_price, current_price, synopsis, note, company_id_fk) VALUES ('9914453933', 'X, Y and Zee (Zee and Co.)', '17.45', '18.25', 'dapibus dolor vel est donec', NULL, '569618');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: CURRENT_ISSUE	                      *
REM ***************************************************************
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('3650445042', 'Beyond (Svinalangorna)', '16.98', '488650');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('2541520487', 'Red State', '8.82', '488650');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('2739048523', 'Voodoo Dawn', '10.86', '488650');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('3567705886', 'True Lies', '5.59', '577493');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('8160475008', 'One, Two, Three', '6.52', '479031');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('2517677497', 'Long Dark Hall, The', '10.9', '234379');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('3772264731', 'Dilwale Dulhania Le Jayenge', '17.01', '578290');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('5949927912', 'Guter Junge', '12.13', '365269');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('6802085939', 'Jupiter Ascending', '12.4', '365269');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('9863938323', 'Dreams That Money Can Buy', '13.46', '365269');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('8694952116', 'Hedgehog in the Fog', '5.7', '365269');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('4664459904', 'Don''t Tell Mom the Babysitter''s Dead', '15.39', '936758');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('1583080720', 'Die Hard: With a Vengeance', '6.15', '481165');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('3008850975', 'Nebraska', '12.47', '850829');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('8898825506', 'Bounce', '13.95', '202600');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('9831893557', 'Stalin', '9.24', '899346');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('5111923965', 'Howling IV: The Original Nightmare', '10', '569618');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('1707757255', 'Hollywoodland', '16.38', '569618');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('9170185538', 'Night of the Running Man', '5.68', '569618');
INSERT INTO CURRENT_ISSUE (id_pk, title, tagged_price, company_id_fk) VALUES ('9583742152', 'Triangle (Tie saam gok)', '17.05', '569618');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: STORE			                      *
REM ***************************************************************
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('903392', 'sociis natoque penatibus', '7489370947', 'ngilchrest0@altervista.org', '37.2094', '68.7751', '626878');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('423397', 'lectus vestibulum quam', '8295989001', 'kcasterot1@hostgator.com', '-7.0312', '108.283', '128998');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('769563', 'penatibus et', '6271109391', 'ntunder2@mlb.com', '53.4291', '85.9006', '227373');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('976530', 'natoque penatibus', '2887964952', 'jbagenal3@zimbio.com', '-17.717', '-49.1221', '849611');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('862046', 'pede malesuada in', '6488648997', 'zpithcock4@europa.eu', '43.488', '-8.231', '990166');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('641935', 'praesent id massa id', '5812936113', 'yorrey5@tinyurl.com', '49.0301', '2.2509', '712539');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('637284', 'arcu sed', '8774434206', 'dkaminski6@globo.com', '14.644', '121.0286', '181557 ');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('455778', 'eu nibh quisque', '7746516331', 'zmatteris7@spiegel.de', '45.9505', '128.0434', '184226');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('602218', 'sapien sapien non', '3487079047', 'mkelshaw8@myspace.com', '47.3695', '40.0905', '742874');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('417890', 'augue vel accumsan tellus', '7081694250', 'htrahair9@oracle.com', '45.2497', '19.3967', '992019');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('125889', 'id turpis integer', '3329178413', 'kmitchesona@latimes.com', '41.1588', '-8.0638', '965677');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('199316', 'amet lobortis', '1731737598', 'ttremmilb@flickr.com', '-7.5629', '111.4559', '673521 ');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('354939', 'nec euismod scelerisque', '5234689348', 'cgriswaitec@hibu.com', '44.0287', '43.1146', '715455');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('817322', 'dapibus augue vel accumsan', '6133492350', 'rlathburyd@goo.gl', '31.293', '111.207', '585186');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('150078', 'purus phasellus in felis', '3198372105', 'czarbe@forbes.com', '23.9132', '116.4649', '656038');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('777334', 'sed lacus', '6783866329', 'caleksichf@nytimes.com', '33.8092', '-84.2805', '902963');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('583351', 'congue etiam', '3276335077', 'tkristofferssong@mozilla.org', '24.467', '118.0855', '776210');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('657692', 'vel lectus in quam', '1723944210', 'ospiresh@simplemachines.org', '-20.874', '-48.299', '604725');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('139045', 'ut erat', '6448945436', 'ehuishi@edublogs.org', '-7.2475', '108.1563', '929119');
INSERT INTO STORE (id_pk, name, phone_number, email, latitude, longitude, address_id_fk) VALUES ('260038', 'porttitor pede justo eu', '2974781191', 'wfennej@yelp.com', '18.8104', '-71.2236', '757225');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: EMPLOYEE			                  *
REM ***************************************************************
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('392276', 'Ruby', 'Wintour', '1406178379', 'rwintour0@1und1.de', '4-Jan-87', 'president', '6000', NULL, NULL, NULL, NULL, '626878', NULL, '636610', NULL);
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('314977', 'Johannes', 'Felgat', '3986714889', 'jfelgat1@utexas.edu', '5-Apr-90', 'manager', '3000', NULL, NULL, NULL, NULL, '626878', '423397', NULL, '392276');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('540235', 'Charyl', 'Isoldi', '6314604242', 'cisoldi2@issuu.com', '6-Apr-83', 'manager', '3000', NULL, NULL, NULL, NULL, '227373', NULL, '762970', '392276');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('966988', 'Sibilla', 'Northin', '5342470152', 'snorthin3@google.co.uk', '7-Apr-85', 'sales rep.', NULL, '12', '40', NULL, NULL, '849611', '976530', NULL, '314977');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('650419', 'Ashleigh', 'Jovanovic', '6899840304', 'ajovanovic4@thetimes.co.uk', '8-Feb-91', 'janitor', NULL, '10', '35', NULL, NULL, '849611', NULL, '606121', '314977');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('664246', 'Elfrida', 'Hightown', '6709977717', 'ehightown5@gov.uk', '9-Apr-92', 'sales rep.', '2300', NULL, NULL, NULL, NULL, '712539', '976530', NULL, '314977');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('269044', 'Con', 'Giorgietto', '1681816052', 'cgiorgietto6@tumblr.com', '10-Apr-92', 'sales rep.', '2300', NULL, NULL, NULL, NULL, '181557', NULL, '922600', '314977');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('949007', 'Lucian', 'Moralas', '9293075938', 'lmoralas7@mapy.cz', '11-Mar-91', 'accountant', '2600', NULL, NULL, NULL, NULL, '181557', '199316', NULL, '314977');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('177307', 'Claus', 'Barbosa', '7053425741', 'cbarbosa8@google.ru', '12-Apr-90', 'janitor', '1900', NULL, NULL, NULL, NULL, '742874', NULL, '751356', '540235');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('274769', 'Donnell', 'Claybourn', '8198266452', 'dclaybourn9@npr.org', '13-Apr-79', 'sales rep.', NULL, NULL, NULL, '4528', '13800', '992019', '199316', NULL, '540235');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('154371', 'Erina', 'Ducroe', '7555617695', 'educroea@washingtonpost.com', '14-Aug-88', 'janitor', '1900', NULL, NULL, NULL, NULL, '965677', NULL, '751356', '540235');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('216102', 'Skye', 'Lawerence', '2499024718', 'slawerenceb@godaddy.com', '15-Apr-85', 'sales rep.', NULL, NULL, NULL, '4331', '13200', '673521', '777334', NULL, '540235');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('574673', 'Chrissy', 'Bolver', '7592777065', 'cbolverc@myspace.com', '16-Apr-84', 'accountant', NULL, NULL, NULL, '5329', '15600', '715455', NULL, '751356', '540235');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('760880', 'Gertrudis', 'Durrett', '7323042799', 'gdurrettd@aboutads.info', '17-Apr-82', 'sales rep.', NULL, '12', '30', NULL, NULL, '585186', '777334', NULL, '540235');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('359531', 'Tami', 'Smorthit', '8134582843', 'tsmorthite@comcast.net', '18-Apr-89', 'janitor', '1900', NULL, NULL, NULL, NULL, '656038', NULL, '295543', '540235');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('755930', 'Pattin', 'Feldmus', '8904106793', 'pfeldmusf@tumblr.com', '19-Apr-89', 'sales rep.', '2300', NULL, NULL, NULL, NULL, '902963', '583351', NULL, '540235');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('497515', 'Max', 'MacKimmie', '6077627088', 'mmackimmieg@tamu.edu', '20-Apr-89', 'sales rep.', '2300', NULL, NULL, NULL, NULL, '776210', NULL, '295543', '540235');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('647201', 'Joyann', 'Goatcher', '2381433455', 'jgoatcherh@state.tx.us', '21-Apr-89', 'sales rep.', NULL, NULL, NULL, '1223', '13000', '604725', '583351', NULL, '540235');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('505858', 'Manolo', 'Sabin', '9224626294', 'msabini@furl.net', '22-Apr-89', 'sales rep.', '2300', NULL, NULL, NULL, NULL, '929119', NULL, '295543', '540235');
INSERT INTO EMPLOYEE (id_pk, first_name, last_name, phone_number, email, birth_date, position, monthly_wage, hourly_pay, weekly_hours, contract_number, contract_pay, address_id_fk1, store_id_fk2, office_id_fk3, manager_id_fk4) VALUES ('389605', 'Arda', 'Venmore', '3677086838', 'avenmorej@de.vu', '23-Apr-89', 'sales rep.', '2300', NULL, NULL, NULL, NULL, '757225', '583351', NULL, '540235');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: MEMBER			                  *
REM ***************************************************************
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('1', 'Margaretta', 'O''Heffernan', '5589350096', 'moheffernan0@wisc.edu', 'N', '626878', '976530');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('2', 'Cariotta', 'Kemmett', '9311301011', 'ckemmett1@abc.net.au', 'N', '626878', '976530');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('3', 'Friederike', 'McConnachie', '8676225472', 'fmcconnachie2@europa.eu', 'N', '227373', '976530');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('4', 'Dolly', 'Stapleford', '4957103349', 'dstapleford3@dagondesign.com', 'N', '849611', '976530');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('5', 'Nyssa', 'Zamboniari', '5802342750', 'nzamboniari4@si.edu', 'P', '849611', '976530');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('6', 'Caryl', 'Dradey', '1951154408', 'cdradey5@craigslist.org', 'D', '712539', '976530');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('7', 'Rahel', 'Faiers', '7088620791', 'rfaiers6@google.pl', 'N', '181557', '976530');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('8', 'Ailene', 'Flisher', '6453564726', 'aflisher7@usa.gov', 'N', '181557', '199316');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('9', 'Jen', 'Asbery', '4796769175', 'jasbery8@cpanel.net', 'N', '742874', '199316');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('10', 'Jessie', 'Phelips', '2487009405', 'jphelips9@drupal.org', 'N', '992019', '777334');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('11', 'Arthur', 'Crouse', '5851509298', 'acrousea@flavors.me', 'P', '965677', '777334');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('12', 'Marcia', 'Dainton', '4675496778', 'mdaintonb@state.tx.us', 'N', '673521', '199316');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('13', 'Ronald', 'Skin', '4307525537', 'rskinc@cornell.edu', 'N', '715455', '199316');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('14', 'Mariele', 'Draisey', '2634557002', 'mdraiseyd@cmu.edu', 'P', '585186', '817322');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('15', 'Langston', 'Jiggle', '1347633888', 'ljigglee@imdb.com', 'N', '656038', '817322');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('16', 'Gilberte', 'Behne', '8685662769', 'gbehnef@ucoz.ru', 'N', '902963', '817322');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('17', 'Raphael', 'Samwell', '2779806462', 'rsamwellg@msu.edu', 'D', '776210', '817322');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('18', 'Kris', 'Gothrup', '2226572484', 'kgothruph@netscape.com', 'N', '604725', '817322');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('19', 'Liana', 'Hexum', '5949838492', 'lhexumi@flickr.com', 'D', '929119', '817322');
INSERT INTO MEMBER (id_pk, first_name, last_name, phone_number, email, membership, address_id_fk1, store_id_fk2) VALUES ('20', 'Wylie', 'Winterflood', '2923923638', 'wwinterfloodj@nydailynews.com', 'N', '757225', '260038');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: ORDERS			                  *
REM ***************************************************************
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('1', '04-Oct-2022 1:00:00 PM', '1', '976530', '966988');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('2', '16-Jan-2022 1:00:00 PM', '1', '976530', '966988');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('3', '16-Jul-2022 1:00:00 PM', '1', '976530', '966988');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('4', '27-Oct-2022 1:00:00 PM', '1', '976530', '966988');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('5', '18-Mar-2022 1:00:00 PM', '1', '976530', '966988');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('6', '12-Aug-2022 1:00:00 PM', '2', '976530', '664246');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('7', '09-Feb-2022 1:00:00 PM', '2', '976530', '664246');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('8', '20-Sep-2022 1:00:00 PM', '8', '199316', '949007');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('9', '28-Sep-2022 1:00:00 PM', '8', '199316', '949007');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('10', '12-Aug-2022 1:00:00 PM', '8', '199316', '949007');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('11', '05-Mar-2022 1:00:00 PM', '9', '199316', '274769');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('12', '10-May-2022 1:00:00 PM', '9', '199316', '274769');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('13', '19-Feb-2022 1:00:00 PM', '9', '199316', '274769');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('14', '05-Jun-2022 1:00:00 PM', '10', '777334', '216102');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('15', '30-Dec-2021 1:00:00 PM', '10', '777334', '216102');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('16', '13-Jul-2022 1:00:00 PM', '10', '777334', '216102');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('17', '23-May-2022 1:00:00 PM', '11', '777334', '216102');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('18', '04-Sep-2022 1:00:00 PM', '11', '777334', '760880');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('19', '01-Oct-2022 1:00:00 PM', '11', '777334', '760880');
INSERT INTO ORDERS (id_pk, date_time, member_id_fk1, store_id_fk2, employee_id_fk3) VALUES ('20', '16-Mar-2022 1:00:00 PM', '11', '777334', '760880');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: ORDER_ITEMS			              *
REM ***************************************************************
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('1', '1', '1', '12.51', NULL, '3650445042');
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('1', '2', '3', '8.98', '8368528614', NULL);
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('1', '3', '1', '11.92', NULL, '2541520487');
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('1', '4', '1', '6.49', '2451685182', NULL);
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('1', '5', '1', '11.85', NULL, '2739048523');
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('1', '6', '2', '13.54', '1649637933', NULL);
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('2', '1', '2', '9.77', NULL, '3567705886');
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('2', '2', '1', '15.48', '4963429414', NULL);
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('2', '3', '3', '11.1', NULL, '8160475008');
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('2', '4', '1', '6.54', '5353222927', NULL);
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('2', '5', '1', '8.43', NULL, '2517677497');
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('2', '6', '1', '9.88', '6041609524', NULL);
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('3', '1', '2', '9.47', NULL, '3772264731');
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('3', '2', '1', '15.86', '9640674162', NULL);
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('3', '3', '3', '8.41', NULL, '5949927912');
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('3', '4', '1', '8.94', '7160102043', NULL);
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('3', '5', '2', '14.06', NULL, '6802085939');
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('3', '6', '1', '19.56', '8284377148', NULL);
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('3', '7', '1', '10.79', NULL, '9863938323');
INSERT INTO ORDER_ITEMS (order_id_pk_fk1, item_number_pk, quantity, sale_price, bkissue_id_fk2, curissue_id_fk3) VALUES ('3', '8', '1', '6.98', '5064203334', NULL);
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: RESERVATION			              *
REM ***************************************************************
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('1', '11-May-2022 1:00:00 PM', '1', '3650445042');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('1', '25-Aug-2022 1:00:00 PM', '3', '2541520487');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('1', '17-Jun-2022 1:00:00 PM', '3', '2739048523');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('1', '09-Apr-2022 1:00:00 PM', '2', '3567705886');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('2', '02-Jun-2022 1:00:00 PM', '1', '3650445042');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('2', '13-Sep-2022 1:00:00 PM', '1', '2541520487');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('2', '15-Nov-2022 1:00:00 PM', '1', '2739048523');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('3', '01-Apr-2022 1:00:00 PM', '1', '6802085939');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('3', '14-Apr-2022 1:00:00 PM', '1', '9863938323');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('3', '08-Jun-2022 1:00:00 PM', '4', '8694952116');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('4', '20-Jan-2022 1:00:00 PM', '1', '3650445042');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('4', '13-May-2022 1:00:00 PM', '1', '2541520487');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('4', '06-Mar-2022 1:00:00 PM', '1', '2739048523');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('4', '14-Jul-2022 1:00:00 PM', '2', '9863938323');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('6', '10-May-2022 1:00:00 PM', '2', '9831893557');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('6', '07-May-2022 1:00:00 PM', '2', '5111923965');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('6', '04-Aug-2022 1:00:00 PM', '3', '1707757255');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('6', '22-Oct-2022 1:00:00 PM', '1', '9170185538');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('7', '11-Jun-2022 1:00:00 PM', '1', '9170185538');
INSERT INTO RESERVATION (member_id_pk_fk1, date_time_pk, quantity, curissue_id_fk2) VALUES ('8', '02-Jul-2022 1:00:00 PM', '1', '9170185538');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: BKISSUE_STOCK			              *
REM ***************************************************************
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('8368528614', '903392', '25');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('6108773228', '903392', '30');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('8368528614', '423397', '34');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('6108773228', '423397', '10');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('2451685182', '423397', '5');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('8368528614', '769563', '10');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('6108773228', '769563', '40');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('2451685182', '769563', '5');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('8284377148', '862046', '1');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('5064203334', '862046', '20');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('1802247867', '862046', '25');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('6108773228', '862046', '15');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('9125132136', '417890', '9');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('3553707657', '417890', '30');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('7517889198', '417890', '23');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('9914453933', '417890', '8');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('9125132136', '583351', '2');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('3553707657', '583351', '10');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('7517889198', '583351', '11');
INSERT INTO BKISSUE_STOCK (bkissue_id_pk_fk1, store_id_pk_fk2, copies_available) VALUES ('9914453933', '583351', '12');
COMMIT;
REM ***************************************************************
REM * Las próximas dos instrucciones muestran el nombre del       *
REM * usuario de la cuenta y la fecha del sistema. Esto es        *
REM * requerido para crear o eliminar tablas y otros objetos.     *
REM ***************************************************************
REM
SHOW USER
SELECT systimestamp FROM dual;
REM ***************************************************************
REM *   Insertar datos tabla: CURISSUE_STOCK			          *
REM ***************************************************************
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('3650445042', '976530', '30');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('3650445042', '769563', '25');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('2739048523', '769563', '20');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('3567705886', '769563', '25');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('3650445042', '125889', '30');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('2739048523', '125889', '50');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('3567705886', '125889', '35');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('9170185538', '125889', '20');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('9583742152', '125889', '20');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('9170185538', '976530', '30');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('9583742152', '976530', '50');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('3650445042', '150078', '25');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('2739048523', '150078', '20');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('3567705886', '150078', '30');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('3008850975', '150078', '50');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('5949927912', '139045', '30');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('6802085939', '139045', '25');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('9863938323', '139045', '20');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('8694952116', '139045', '20');
INSERT INTO CURISSUE_STOCK (curissue_id_pk_fk1, store_id_pk_fk2, copies_acquired) VALUES ('3650445042', '260038', '50');
COMMIT;
REM ***************************************************************
REM *   Guarda los datos. De no ponerse, como quiera los guarda   *
REM * en una coorrida.  Se deja para explicar su uso.             *
REM ***************************************************************
COMMIT;