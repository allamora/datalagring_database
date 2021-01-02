
DROP DATABASE IF EXISTS soundgood_school;
CREATE DATABASE soundgood_school;
USE soundgood_school;

set  sql_mode='';



CREATE TABLE audition (
    instructor_id integer NOT NULL,
    approved bit(10),
   
    CONSTRAINT serial PRIMARY KEY (instructor_id)  
)  ;



CREATE TABLE email (
    email_id integer NOT NULL,
    CONSTRAINT serial PRIMARY KEY (email_id)
);


CREATE TABLE ensemble (
    skill_level integer,
    number_of_seats integer,
    genre character varying(100),
    price double precision,
    scheduled_date date,
    registred_student integer,
    instructor_id integer NOT NULL,
    weekday character varying(10),
	 id integer NOT NULL AUTO_INCREMENT,
	CONSTRAINT serial PRIMARY KEY (id, instructor_id)
) ;



CREATE TABLE extra_charge (
    id integer NOT NULL AUTO_INCREMENT,
    price double precision,
    scheduled_date date,
    student_id integer NOT NULL,
    CONSTRAINT serial PRIMARY KEY (id, student_id)
) ;


CREATE TABLE group_lesson (
    skill_level integer,
    id integer NOT NULL AUTO_INCREMENT,
    instrument_id integer NOT NULL,
    price double precision,
    scheduled_date date,
    instructor_id integer NOT NULL,
	weekday character varying(10),
    CONSTRAINT serial PRIMARY KEY (id, instrument_id, instructor_id)
) ;



CREATE TABLE individual_lesson (
    skill_level integer,
    id integer NOT NULL AUTO_INCREMENT,
    instrument_id integer NOT NULL,
    price double precision,
    scheduled_date date,
    instructor_id integer NOT NULL,
    weekday character varying(10),
   CONSTRAINT serial PRIMARY KEY (id, instrument_id, instructor_id)
) ;


CREATE TABLE instructor (
    id integer NOT NULL AUTO_INCREMENT,
    first_name character varying(50),
    last_name character varying(50),
    personal_number character varying(12),
    street character varying(50),
    zip character varying(50),
    city character varying(50),
     CONSTRAINT serial PRIMARY KEY (id)
);


INSERT INTO instructor ( first_name, last_name, personal_number, street, zip, city) VALUES
('eva',	'sjögren','848304-5643','jordgubbsvägen','177 83','stockholm'),
('michaela','kvist','906470-9999','myntgatan','124 99','stockholm'),
('lars','sjögren','794187-2222','servitutsvägen','133 81','stockholm'),
('amed','wifi','1990-01-20','osmogrind','198 76','stockholm');


CREATE TABLE instructor_email (
    email_id integer NOT NULL,
    instructor_id integer NOT NULL,
	 CONSTRAINT serial PRIMARY KEY (email_id, instructor_id)
) ;



CREATE TABLE instructor_phone (
    instructor_id integer NOT NULL,
    phone_id integer NOT NULL,
     CONSTRAINT serial PRIMARY KEY ( phone_id,instructor_id)
	
) ;


CREATE TABLE instrument (
    id integer NOT NULL AUTO_INCREMENT,
    price double precision,
    instrument_kind character varying(100),
    brand character varying(100),
    CONSTRAINT serial PRIMARY KEY (id)
) ;

INSERT INTO instrument ( price, instrument_kind,brand) VALUES
(	150.5,	'guitar','gibson'),
(	150.5,	'base','shure'),
(	300.05,	'piano','yamaha'),
(	420.05,	'contrabass','fender'),
(	100,	'flute', 'sennheiser'),
(	110.55,	'saxophone','roland'),
(	150.05,	'harp','gibson'),
(	250.5,	'trumpet','fender'),
(	450,	'cellon','sennheiser'),
(	155.5,	'guitar','shure'); 


CREATE TABLE lease (
    id integer NOT NULL AUTO_INCREMENT,
    student_id integer  ,
    instrument_id integer ,
    rented_date date,
    terminated_rental integer,
  
	CONSTRAINT serial PRIMARY KEY (id)
) ;




CREATE TABLE lessons_full (
    student_id integer NOT NULL,
    contact_student  bit(10),
     CONSTRAINT serial PRIMARY KEY (student_id)
) ;


CREATE TABLE parent (
    student_id integer NOT NULL,
    attending_children integer,
    first_name character varying(50),
    last_name character varying(50),
	 CONSTRAINT serial PRIMARY KEY (student_id)
); 


CREATE TABLE phone (
    phone_id integer NOT NULL,
    CONSTRAINT serial PRIMARY KEY (phone_id)
);


CREATE TABLE sibling_discount (
    id integer NOT NULL,
    student_id integer NOT NULL,
    discount double precision,
    attending_sibling integer,
    CONSTRAINT serial  PRIMARY KEY (id, student_id)
);


CREATE TABLE student (
    id integer NOT NULL AUTO_INCREMENT,
    first_name character varying(50),
    last_name character varying(50),
    personal_number character varying(12),
    street character varying(50),
    zip character varying(50),
    city character varying(50),
     CONSTRAINT serial PRIMARY KEY (id)
);

INSERT INTO student ( first_name, last_name, personal_number, street, zip, city) VALUES
(	'katarina',	'anvik',	'990915-2337',	'isafjordsgatan 12',	'136 22',	'stockholm'),
(	'daniel',	'mirgana',	'200813-7561',	'vallagränd 2',	'167 59',	'stockholm'),
(	'viktoria',	'sharifi',	'990612-4556',	'vallavägen 1',	'136 39',	'stockholm'),
(	'juan',	'carlos',	'200501-4737',	'kantarellvägen 34',	'145 78',	'stockholm'),
(	'amed',	'shar',	'991221-9999',	'kvarnhagsvägen 2',	'125 53',	'stockholm'),
(	'jorge',	'alamando',	'960328-6997',	'pepparvägen 14',	'145 99',	'stockholm'); 


CREATE TABLE student_application (
    student_id integer NOT NULL,
    student_skill integer,
    student_instrument character varying(50),
    application bit(10),
    
     CONSTRAINT serial PRIMARY KEY (student_id)
) ;


CREATE TABLE student_email (
    email_id integer NOT NULL,
    student_id integer NOT NULL,
    CONSTRAINT serial PRIMARY KEY (email_id, student_id)
) ;



CREATE TABLE student_phone (
    phone_id integer NOT NULL,
    student_id integer NOT NULL,
   CONSTRAINT serial  PRIMARY KEY (phone_id, student_id)
);


ALTER TABLE instructor_email  ADD FOREIGN KEY (email_id) REFERENCES email (email_id)ON DELETE CASCADE;
ALTER TABLE instructor_email  ADD FOREIGN KEY (instructor_id) REFERENCES instructor (id)ON DELETE CASCADE;


ALTER TABLE student_application ADD  FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE student_email ADD  FOREIGN KEY (email_id) REFERENCES email (email_id)ON DELETE CASCADE;
ALTER TABLE student_email ADD FOREIGN KEY (student_id) REFERENCES student (id)ON DELETE CASCADE;


ALTER TABLE student_phone ADD  FOREIGN KEY (phone_id) REFERENCES phone (phone_id)ON DELETE CASCADE;
ALTER TABLE student_phone ADD  FOREIGN KEY (student_id) REFERENCES student (id)ON DELETE CASCADE;


ALTER TABLE audition ADD  FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE ensemble ADD  FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE extra_charge ADD  FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE group_lesson ADD  FOREIGN KEY (instrument_id) REFERENCES instrument (id);
ALTER TABLE group_lesson ADD  FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE individual_lesson ADD  FOREIGN KEY (instrument_id) REFERENCES instrument (id);
ALTER TABLE individual_lesson ADD  FOREIGN KEY (instructor_id) REFERENCES instructor (id);

ALTER TABLE instructor_phone ADD  FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE;
ALTER TABLE instructor_phone ADD FOREIGN KEY (phone_id) REFERENCES phone (phone_id)ON DELETE CASCADE;

ALTER TABLE lease  ADD FOREIGN KEY (instrument_id) REFERENCES instrument (id);
ALTER TABLE lease ADD  FOREIGN KEY (student_id) REFERENCES student (id);



ALTER TABLE lessons_full ADD FOREIGN KEY (student_id) REFERENCES student_application (student_id);

ALTER TABLE parent ADD  FOREIGN KEY (student_id) REFERENCES student (id);

ALTER TABLE sibling_discount ADD FOREIGN KEY (student_id) REFERENCES student (id);






  







