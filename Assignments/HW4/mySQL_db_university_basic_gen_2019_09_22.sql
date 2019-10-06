-- Preliminaries
DROP   DATABASE IF EXISTS db_University_basic;
CREATE DATABASE           db_University_basic;
USE                       db_University_basic;

CREATE TABLE classroom(
    building           VARCHAR(15),
    room_number        VARCHAR(7),  
    capacity            FIXED(4,0), 
	PRIMARY KEY(building,room_number)   
);
INSERT   INTO classroom(building, room_number        , capacity            )  
VALUES 
		('Packard'   , 101 ,      500),
		('Painter'   , 514 ,      10),
		('Taylor'    , 3128,      70),
		('Watson'    , 100,       30),
		('Watson'    , 120,       50);


CREATE TABLE department(
	dept_name          VARCHAR(20),
    building           VARCHAR(15),
    budget             FIXED(12,2) CHECK (budget>0),
	PRIMARY KEY(dept_name)   
);
INSERT   INTO department(dept_name, building  , budget)  
VALUES 
		('Comp. Sci.'   , 'Taylor',       100e3),
		('Biology'      , 'Watson',        90e3),
		('Elec. Eng.'   , 'Taylor',        85e3),
		('Music'        , 'Packard',       40e3),
		('Finance'      , 'Painter',       40e3),
		('History'      , 'Painter',       20e3),
		('Physics'      , 'Watson' ,       70e3);

CREATE TABLE course(
	course_id          VARCHAR(8),
    title              VARCHAR(70),
    dept_name          VARCHAR(20),
    credits            NUMERIC(2,0),
	PRIMARY KEY(course_id)  ,
    FOREIGN KEY(dept_name) REFERENCES department(dept_name) ON delete set NULL
);
INSERT INTO course(course_id, title, dept_name , credits )  
VALUES 
		('BIO-101' ,   'Intro. to Bio'                     ,'Biology'     , 4),
		('BIO-301' ,   'Genetics'                          ,'Biology'     , 2),
		('BIO-399' ,   'Computational Biology'             ,'Biology'     , 4),
		('CS-101'  ,   'Intro to computer Sci.'            ,'Comp. Sci.'  , 3),
		('CS-190'  ,   'Game Design'                       ,'Comp. Sci.'  , 3),
		('CS-315'  ,   'Robotics'                          ,'Comp. Sci.'  , 3),
		('CS-319'  ,   'Image Processing'                  ,'Comp. Sci.'  , 4),
		('CS-347'  ,   'Data Base System Concepts'         ,'Comp. Sci.'  , 4),
		('EE-181'  ,   'Intr. to Digital Systems'          ,'Elec. Eng.'  , 4),
		('FIN-201' ,   'Investment Banking'                ,'Finance'     , 4),
		('HIS-351' ,   'World History'                     ,'History'     , 1),
		('MUS-201' ,   'Music Video Production'            ,'Music'       , 4),
		('PHY-101' ,   'Physical Contact'                  ,'Physics'     , 4);


CREATE TABLE instructor(
	ID                 VARCHAR(8)          ,
    name               VARCHAR(50) not null,
    dept_name          VARCHAR(20)         ,
    salary             FIXED(8,2)          ,
	PRIMARY KEY(ID)                        ,
    FOREIGN KEY(dept_name) REFERENCES department(dept_name) ON DELETE SET NULL
);
INSERT   INTO instructor(ID, name,dept_name, salary)
VALUES 
    ('22222', 'Einstein'     , 'Physics'         , 95e3),
    ('12121', 'Wu'           , 'Finance'         , 90e3),
	('32343', 'El Said'      , 'History'         , 60e3),
	('45565', 'Katz'         , 'Comp. Sci.'      , 75e3),
	('98345', 'Kim'          , 'Elec. Eng.'      , 80e3),
	('76766', 'Crick'        , 'Biology'         , 72e3),
	('10101', 'Srinivasan'   , 'Comp. Sci.'      , 65e3),
	('58583', 'Califeri'     , 'History'         , 62e3),
	('83821', 'Brandt'       , 'Comp. Sci.'      , 92e3),
	('15151', 'Mozart'       , 'Music'           , 40e3),
	('33456', 'Gold'         , 'Physics'         , 87e3),
	('76543', 'Singh'        , 'Finance'         , 80e3);


CREATE TABLE section(
	course_id          VARCHAR(8)  ,
    sec_id             VARCHAR(8)  ,
    semester           VARCHAR(8)  ,
    year               FIXED(4)    ,
    building           VARCHAR(15) ,
    room_number        VARCHAR(7)  ,
    time_slot_id       VARCHAR(4)  ,
	PRIMARY KEY(course_id,sec_id, semester,year),
    FOREIGN KEY(course_id) REFERENCES course(course_id),
    FOREIGN KEY(building, room_number) REFERENCES classroom(building, room_number) on delete set null
);
INSERT   INTO section(course_id, sec_id ,semester , year, building,room_number, time_slot_id) 
VALUES 
		('BIO-101', '1', 'Summer',2009, 'Painter' ,514  ,'B'),
		('BIO-301', '1', 'Summer',2010, 'Painter' ,514  ,'A'),
        ('CS-101' , '1', 'Fall'  ,2009, 'Packard' ,101  ,'H'),
        ('CS-101' , '1', 'Spring',2010, 'Packard' ,101  ,'F'),
        ('CS-190' , '1', 'Spring',2009, 'Taylor'  ,3128 ,'E'),
        ('CS-190' , '2', 'Spring',2009, 'Taylor'  ,3128 ,'A'),
        ('CS-315' , '1', 'Spring',2010, 'Watson'  ,120  ,'D'),
        ('CS-319' , '1', 'Spring',2010, 'Watson'  ,100  ,'B'),
		('CS-319' , '2', 'Spring',2010, 'Taylor'  ,3128 ,'C'),
        ('CS-347' , '1', 'Fall'  ,2009, 'Taylor'  ,3128 ,'A'),
        ('EE-181' , '1', 'Spring',2009, 'Taylor'  ,3128 ,'C'),
		('FIN-201', '1', 'Spring',2010, 'Packard' ,101  ,'B'),
		('HIS-351', '1', 'Spring',2010, 'Painter' ,514  ,'C'),
		('MUS-201', '1', 'Spring',2010, 'Packard' ,101  ,'D'),
		('PHY-101', '1', 'Fall'  ,2009, 'Watson'  ,100  ,'A');

CREATE TABLE teaches(
	ID                 VARCHAR(5),
    course_id          VARCHAR(8),
    sec_id             VARCHAR(8),
    semester           VARCHAR(8),
    year               FIXED(4)  ,
	PRIMARY KEY(ID,course_id,sec_id,semester,year),
    FOREIGN KEY(course_id) REFERENCES course(course_id),
    FOREIGN KEY(ID)        REFERENCES instructor(ID)
);
INSERT   INTO teaches(ID,course_id, sec_id ,semester , year) 
VALUES 
		('10101','CS-101'   ,'1'  ,'Fall'  ,'2009'),
		('10101','CS-315'   ,'1'  ,'Spring','2010'),
		('10101','CS-347'   ,'1'  ,'Fall'  ,'2009'),
		('12121','FIN-201'  ,'1'  ,'Spring','2010'),
        ('15151','MUS-201'  ,'1'  ,'Spring','2010'),
		('22222','PHY-101'  ,'1'  ,'Fall'  ,'2009'),
		('32343','HIS-351'  ,'1'  ,'Spring','2010'),
		('45565','CS-101'   ,'1'  ,'Spring','2010'),
		('45565','CS-319'   ,'1'  ,'Spring','2010'),
		('76766','BIO-101'  ,'1'  ,'Summer','2009'),
		('76766','BIO-101'  ,'1'  ,'Summer','2010'),
		('83821','CS-190'   ,'1'  ,'Spring','2009'),
		('83821','CS-190'   ,'2'  ,'Spring','2009'),
		('83821','CS-319'   ,'2'  ,'Spring','2010'),
		('98345','EE-181'   ,'1'  ,'Spring','2009');



CREATE TABLE student(
	ID                 VARCHAR(5),
    name               VARCHAR(20),
    dept_name          VARCHAR(20),
    tot_cred           INT,
    PRIMARY KEY(ID) ,
    FOREIGN KEY(dept_name) references department(dept_name) on delete cascade
);
INSERT   INTO student(ID,name, dept_name,tot_cred) 
VALUES 
		('00128','Zhang'    ,'Comp. Sci.'  , 102),
		('12345','Shankar'  ,'Comp. Sci.'  , 32 ),
		('19991','Brandt'   ,'History'     , 80 ),
		('23121','Chavez'   ,'Finance'     , 110),
        ('44553','Peltier'  ,'Physics'     , 56 ),
        ('45678','Levy'     ,'Physics'     , 46 ),
        ('54321','William'  ,'Comp. Sci.'  , 54 ),
        ('55739','Sanchez'  ,'Music'       , 38),
        ('70557','Snow'     ,'Physics'     , 0 ),
        ('76543','Brown'    ,'Comp. Sci.'  , 58 ),
        ('76653','Aoi'      ,'Elec. Eng.'  , 60 ),
        ('98765','Bourikas' ,'Elec. Eng.'  , 98),
        ('98988','Tanaka'   ,'Biology'     , 120);


CREATE TABLE takes(
	ID                 VARCHAR(5),
    course_id          VARCHAR(8),
    sec_id             VARCHAR(8),
    semester_id        VARCHAR(8)  ,
    year               FIXED(4)    ,
	grade              VARCHAR(2)  ,
    PRIMARY KEY(ID,course_id,sec_id,semester_id,year),
    FOREIGN KEY(course_id,sec_id,semester_id,year) references section(course_id,sec_id,semester,year) on delete cascade,
    FOREIGN KEY(ID)        references student(ID) on delete cascade
);



INSERT   INTO takes(ID,course_id, sec_id ,semester_id        , year,grade) 
VALUES 
		('00128','CS-101'   ,1  ,'Fall'   , 2009,'A' ),
        ('00128','CS-347'   ,1  ,'Fall'   , 2009,'A-'),
        ('12345','CS-101'   ,1  ,'Fall'   , 2009,'C' ),
        ('12345','CS-190'   ,2  ,'Spring' , 2009,'A' ),
        ('12345','CS-315'   ,1  ,'Spring' , 2010,'A' ),
        ('12345','CS-347'   ,1  ,'Fall'   , 2009,'A' ),
        ('19991','HIS-351'  ,1  ,'Spring' , 2010,'B' ),
        ('23121','FIN-201'  ,1  ,'Spring' , 2010,'C+'),
        ('44553','PHY-101'  ,1  ,'Fall'   , 2009,'B-'),
		('45678','CS-101'   ,1  ,'Fall'   , 2009,'F' ),
		('45678','CS-101'   ,1  ,'Spring' , 2010,'B+'),
		('45678','CS-319'   ,1  ,'Spring' , 2010,'B' ),
        ('54321','CS-101'   ,1  ,'Fall'   , 2009,'A-'),
        ('54321','CS-319'   ,2  ,'Spring' , 2010,'B+'),
        ('55739','MUS-201'  ,1  ,'Spring' , 2010,'A-'),
        ('76543','CS-101'   ,1  ,'Fall'   , 2009,'A' ),
        ('76543','CS-319'   ,2  ,'Spring' , 2010,'A' ),
        ('76653','EE-181'   ,1  ,'Spring' , 2009,'C' ),
        ('98765','CS-101'   ,1  ,'Fall'   , 2009,'C-'),
        ('98765','CS-315'   ,1  ,'Spring' , 2010,'B-'),
        ('98988','BIO-101'  ,1  ,'Summer' , 2009,'A' ),
        ('98988','BIO-301'  ,1  ,'Summer' , 2010,NULL)
        ;
     
       