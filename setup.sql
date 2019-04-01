-- Vinicius Marcelino Rocha (016231876)
-- vini.rocha96@gmail.com
-- Dr. Sophie Lee
-- IS 480 - Fall 2018
-- Final Project
-- start c:\sql\setup.sql

----------------------------------------------- DATABASE CREATION -----------------------------------------------

set echo on

/* ---------------
   Create table structure for IS 480 class
   --------------- */


drop table enrollments;
drop table prereq;
drop table waitlist;
drop table schclasses;
drop table courses;
drop table students;
drop table majors;

-----
-----

create table MAJORS
	(major varchar2(3) Primary key,
	mdesc varchar2(30));
insert into majors values ('ACC','Accounting');
insert into majors values ('FIN','Finance');
insert into majors values ('IS','Information Systems');
insert into majors values ('MKT','Marketing');

create table STUDENTS
	(snum varchar2(3) primary key,
	sname varchar2(10),
	standing number(1),
	major varchar2(3) constraint fk_students_major references majors(major),
	gpa number(2,1),
	major_gpa number(2,1));

insert into students values ('101','Andy',3,'IS',2.8,3.2);
insert into students values ('102','Betty',2,null,3.2,null);
insert into students values ('103','Cindy',3,'IS',2.5,3.5);
insert into students values ('104','David',3,'FIN',3.3,3.0);
insert into students values ('105','Ellen',1,null,2.8,null);
insert into students values ('106','Frank',3,'MKT',3.1,2.9);
insert into students values ('107','Gala',1,null,3.1,null);
insert into students values ('108','Twanda',2,'IS',3.7,null);
insert into students values ('109','Shela',4,'FIN',1.8,null);
insert into students values ('110','Shad',1,null,3.7,null);
insert into students values ('111','Esperanza',2,'MKT',3.5,null);
insert into students values ('112','Valeria',3,'IS',3.3,null);
insert into students values ('113','Francesca',4,'IS',3,null);
insert into students values ('114','Lucretia',4,'IS',2.6,null);
insert into students values ('115','Terrilyn',3,'MKT',2.8,null);
insert into students values ('116','Shala',2,'MKT',2.9,null);
insert into students values ('117','Coral',1,null,3.1,null);
insert into students values ('118','Annabelle',1,null,3.7,null);
insert into students values ('119','Francie',2,'FIN',1.8,null);
insert into students values ('120','Inocencia',3,'MKT',2.4,null);
insert into students values ('121','Artie',4,'FIN',3.8,null);
insert into students values ('122','Siobhan',4,'MKT',3,null);
insert into students values ('123','Bradley',3,'IS',2.6,null);
insert into students values ('124','Marie',4,'MKT',2.4,null);
insert into students values ('125','Merlin',1,null,2.6,null);
insert into students values ('126','Roy',1,null,2.8,null);
insert into students values ('127','Hong',2,'FIN',2.9,null);
insert into students values ('128','Lan',3,'FIN',3.7,null);
insert into students values ('129','Jermaine',4,'MKT',1.8,null);

create table COURSES
	(dept varchar2(3) constraint fk_courses_dept references majors(major),
	cnum varchar2(3),
	ctitle varchar2(30),
	crhr number(3),
	standing number(1),
	primary key (dept,cnum));

insert into courses values ('IS','300','Intro to MIS',3,2);
insert into courses values ('IS','301','Business Communicatons',3,2);
insert into courses values ('IS','310','Statistics',3,2);
insert into courses values ('IS','340','Programming',3,3);
insert into courses values ('IS','380','Database',3,3);
insert into courses values ('IS','385','Systems',3,3);
insert into courses values ('IS','480','Adv Database',3,4);

create table SCHCLASSES (
	callnum number(5) primary key,
	year number(4),
	semester varchar2(3),
	dept varchar2(3),
	cnum varchar2(3),
	section number(2),
	capacity number(3));

alter table schclasses 
	add constraint fk_schclasses_dept_cnum foreign key 
	(dept, cnum) references courses (dept,cnum);

insert into schclasses values (10110,2014,'Fa','IS','300',1,2);
insert into schclasses values (10115,2014,'Fa','IS','300',2,4);
insert into schclasses values (10120,2014,'Fa','IS','300',3,6);
insert into schclasses values (10125,2014,'Fa','IS','301',1,2);
insert into schclasses values (10130,2014,'Fa','IS','301',2,4);
insert into schclasses values (10135,2014,'Fa','IS','310',1,2);
insert into schclasses values (10140,2014,'Fa','IS','310',2,4);
insert into schclasses values (10145,2014,'Fa','IS','340',1,2);
insert into schclasses values (10150,2014,'Fa','IS','380',1,2);
insert into schclasses values (10155,2014,'Fa','IS','385',1,4);
insert into schclasses values (10160,2014,'Fa','IS','480',1,2);

create table PREREQ
	(dept varchar2(3),
	cnum varchar2(3),
	pdept varchar2(3),
	pcnum varchar2(3),
	primary key (dept, cnum, pdept, pcnum));
alter table Prereq 
	add constraint fk_prereq_dept_cnum foreign key 
	(dept, cnum) references courses (dept,cnum);
alter table Prereq 
	add constraint fk_prereq_pdept_pcnum foreign key 
	(pdept, pcnum) references courses (dept,cnum);

insert into prereq values ('IS','380','IS','300');
insert into prereq values ('IS','380','IS','301');
insert into prereq values ('IS','380','IS','310');
insert into prereq values ('IS','385','IS','310');
insert into prereq values ('IS','340','IS','300');
insert into prereq values ('IS','480','IS','380');

create table ENROLLMENTS (
	snum varchar2(3) constraint fk_enrollments_snum references students(snum),
	callnum number(5) constraint fk_enrollments_callnum references schclasses(callnum),
	grade varchar2(2),
	primary key (snum, callnum));

Insert into enrollments values ('103','10160',null);
Insert into enrollments values ('101','10145',null);
Insert into enrollments values ('106','10160',null);
Insert into enrollments values ('106','10150',null);
Insert into enrollments values ('101','10155','W');
Insert into enrollments values ('101','10150',null);
Insert into enrollments values ('104','10145',null);
Insert into enrollments values ('104','10120',null);
Insert into enrollments values ('120','10155',null);
Insert into enrollments values ('124','10145',null);
Insert into enrollments values ('111','10120',null);
Insert into enrollments values ('127','10130',null);
Insert into enrollments values ('121','10155',null);
Insert into enrollments values ('101','10110','A');
Insert into enrollments values ('102','10110','B');
Insert into enrollments values ('103','10120','A');
Insert into enrollments values ('101','10125',null);
Insert into enrollments values ('102','10130',null);

create table waitlist(
	Snum varchar2(3) constraint fk_waitlist_snum references students(snum),
	Callnum number(5) constraint fk_waitlist_callnum references schclasses(callnum),
	RequestTime date
);

insert into waitlist values ('124','10145',Sysdate-3);
insert into waitlist values ('126','10110',Sysdate+1);
insert into waitlist values ('127','10110',Sysdate-1);
insert into waitlist values ('128','10110',Sysdate+2);
insert into waitlist values ('129','10110',Sysdate);
insert into waitlist values ('119','10115',Sysdate-2);
insert into waitlist values ('120','10115',Sysdate+1);
insert into waitlist values ('121','10115',Sysdate);
insert into waitlist values ('126','10130',Sysdate-1);
insert into waitlist values ('125','10130',Sysdate+2);

commit;

----------------------------------------------- PACKAGE CREATION -----------------------------------------------

-- start c:\sql\EnrollPackage.sql

set serveroutput on
set echo on
set linesize 2000

----------------------------Package Header ----------------------------

create or replace Package Enroll is 

------------ AddMe procedures

/*
|| Program checks for student and the class existence
*/

procedure Validation
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2)
	;
		
/*
|| Program checks for repeted Enrollment
|| Student cannot enroll in the same class again
*/

procedure RepeatEnrollment
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2)
	;
	
/*
|| Program checks for double enrollment
*/

procedure DoubleEnrollment
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2)
	;
	
/*
|| Check for over 15 units enrollment attempts
*/

procedure CreditLimit
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2)
	;
	
/*
|| Check standing requirements
*/

procedure StandingRequirements
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2)
	;

/*
|| Disqualifed Student
|| Rember that this program only runs when student is a non-freshman (standing higher then 1)
*/

procedure DisqualifedStudent
	(p_snum students.snum%type,
	p_result out varchar2)
	;
	
/*
|| Check class capacity
*/

procedure Capacity
	(p_callnum enrollments.callnum%type,
	p_result out varchar2)
	;
	
/*
|| Enroll the student in the waitlist
*/

procedure WaitingList
	(p_snum students.snum%type,
	 p_callnum enrollments.callnum%type)
	 ;
	
/*
|| Check to see if the student is already on waitlist
*/

procedure RepeatWaitingList
	(p_snum students.snum%type,
	 p_callnum enrollments.callnum%type,
	 p_result out varchar2)
	 ;
	 
/*
|| Add me
*/

procedure AddMe
	(p_snum students.snum%type,
	 p_callnum schclasses.callnum%type,
	 p_ErrorMsg out varchar2)
	 ;
	 
------------ DropMe procedures

/*
|| Check if student is actually enrolled on the class
*/

procedure NotEnrolled
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2)
	;
	
/*
|| Already Graded
*/

procedure AlreadyGraded
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2)
	;

/*
|| Dropped The Student
*/

procedure DropMe
	(p_snum students.snum%type,
	p_callnum enrollments.callnum%type)
	;

END Enroll;
/

show err
	
----------------------------Package Body ----------------------------

create or replace Package Body Enroll is

/*
|| Program checks for student and the class existence
*/

procedure Validation
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2) as
	v_snum number;
	v_callnum number;
	
Begin
	select count(snum) into v_snum
	from students
	where snum = p_snum
	;

	select count(callnum) into v_callnum
	from schclasses
	where callnum = p_callnum
	;

	if v_snum = 1 and v_callnum = 1 then
		p_result := null;
	elsif v_snum != 1 and v_callnum != 1 then
		p_result := 'Student and class do not exist';
	elsif v_snum != 1 then
		p_result := 'Student do not exist';
	elsif v_callnum != 1 then
		p_result := 'Class do not exist';
	end if;
End;

/*
|| Program checks for repeted Enrollment
|| Student cannot enroll in the same class again
|| Given that the student have taken the class before
*/

procedure RepeatEnrollment
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2) as
	v_check number;

Begin
	select count(snum) into v_check
	from enrollments
	where snum = p_snum
	and callnum = p_callnum
	;
	
	if v_check >= 1 then
		p_result := 'Student already enrolled in this class | ';
	else
		p_result := null;
	end if;
End;

/*
|| Program checks for double enrollment
*/
	
procedure DoubleEnrollment
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2) as
	v_dept_enrolled 		schclasses.dept%type;
	v_cnum_enrolled 	schclasses.cnum%type;
	v_section_enrolled 	schclasses.section%type;
	v_dept_check 			schclasses.dept%type;
	v_cnum_check 			schclasses.cnum%type;
	v_section_check  		schclasses.section%type;
	
Begin
	-- given the callnum, get the class dept and snum
	select dept,cnum,section into v_dept_enrolled, v_cnum_enrolled,v_section_enrolled
	from schclasses sc
	where callnum = p_callnum
	;
	
	-- check if the student wants to entroll on the same class and different section
	select count(dept), count(cnum), count(section) into v_dept_check, v_cnum_check,v_section_check
	from schclasses sc, enrollments e
	where snum = p_snum
	and sc.callnum = e.callnum
	and dept = v_dept_enrolled
	and cnum = v_cnum_enrolled
	and section != v_section_enrolled
	;
	
	if 	v_dept_check = 1 and v_cnum_check = 1 and v_section_check = 1 then
		p_result := 'Student already enrolled in this class on a diferent section | ';
	else
		p_result := null;
	end if;
End;

/*
|| Check for over 15 units enrollment attempts
*/

procedure CreditLimit
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2) as
	v_snum_crhr courses.crhr%type;
	v_callnum_crhr courses.crhr%type;
	v_crhr number;

Begin
	select nvl(sum(crhr),0) into v_snum_crhr
	from courses c, enrollments e, schclasses s
	where snum = p_snum
	and e.callnum=s.callnum
	and s.dept=c.dept
	and s.cnum=c.cnum;
	
	select nvl(sum(crhr),0) into v_callnum_crhr
	from courses c, schclasses s
	where callnum = p_callnum
	and s.dept=c.dept
	and s.cnum=c.cnum;
			
	v_crhr := v_snum_crhr + v_callnum_crhr;

	if v_crhr <= 15 then
		p_result := null;
	else
		p_result := 'Student wants to enroll in more then 15 units | ';
	end if;
End;

/*
|| Check standing requirements
*/

procedure StandingRequirements
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2) as
	v_student_standing  number;
	v_class_standing number;

Begin
		
	select standing into v_student_standing
	from students
	where snum = p_snum
	;
	
	select standing into v_class_standing
	from courses c, schclasses sc
	where callnum = p_callnum
	and c.dept = sc.dept
	and c.cnum = sc.cnum
	;

	if v_student_standing >=  v_class_standing then
		p_result := null;
	else
		p_result := 'Your standing does not match the class standing requierment | ';
	end if;
End;

/*
|| Disqualifed Student
|| Rember that this program only runs when student is a non-freshman (standing higher then 1)
*/

procedure DisqualifedStudent
	(p_snum students.snum%type,
	p_result out varchar2) as
	v_gpa students.gpa%type;
	
Begin

	select gpa into v_gpa
	from students
	where snum = p_snum
	;
	
	if v_gpa >= 2 then
		p_result := null;
	else
		p_result := 'GPA lower then 2.0 | ';
	end if;
End;

/*
|| Check class capacity
*/

procedure Capacity
	(p_callnum enrollments.callnum%type,
	p_result out varchar2) as
	v_capacity number;
	v_callnum_not_W number;
	v_callnum_null number;
	v_callnum_total number;

Begin
	select capacity into v_capacity
	from schclasses
	where callnum = p_callnum
	;

	select nvl(count(snum),0) into v_callnum_not_W
	from enrollments
	where callnum = p_callnum
	and grade != 'W'
	;
	
	select nvl(count(snum),0) into v_callnum_null
	from enrollments
	where callnum = p_callnum
	and grade is null
	;
	
	v_callnum_total := v_callnum_not_W + v_callnum_null;

	if v_callnum_total < v_capacity then
		p_result := null;
	else
		p_result := 'Sorry, the class is full | ';
	end if;
End;

/*
|| Enroll the student in the waitlist
*/

procedure WaitingList
	(p_snum students.snum%type,
	 p_callnum enrollments.callnum%type) as
	 
Begin
	insert into waitlist values (p_snum,p_callnum,sysdate);
	commit;
	dbms_output.put_line ('Student number '||p_snum||' is now on the waiting list for class number '||p_callnum||'.');
End;

/*
|| Check to see if the student is already on waitlist
*/

procedure RepeatWaitingList
	(p_snum students.snum%type,
	 p_callnum enrollments.callnum%type,
	 p_result out varchar2) as
	 v_checkSnum number;
	 
Begin
	select count(snum) into v_checkSnum
	from waitlist
	where snum = p_snum
	and callnum = p_callnum
	;

	if v_checkSnum = 0 then
		p_result := null;
	else
		p_result := 'Sudent is already waitlisted on the course | ';
	end if;
End;

/*
|| Add me
*/

procedure AddMe
	(p_snum students.snum%type,
	 p_callnum schclasses.callnum%type,
	 p_ErrorMsg out varchar2) as
	 v_errorText varchar(300);
	
Begin
	p_ErrorMsg := null;

	Validation (p_snum, p_callnum, v_errorText);
	p_ErrorMsg := v_errorText;
	
	if p_ErrorMsg is null then
		RepeatEnrollment (p_snum, p_callnum, v_errorText);
		p_ErrorMsg := p_ErrorMsg||v_errorText;
		
		DoubleEnrollment (p_snum, p_callnum, v_errorText);
		p_ErrorMsg := p_ErrorMsg||v_errorText;
		
		CreditLimit (p_snum, p_callnum, v_errorText);
		p_ErrorMsg := p_ErrorMsg||v_errorText;
		
		StandingRequirements (p_snum, p_callnum, v_errorText);
		p_ErrorMsg := p_ErrorMsg||v_errorText;
		
		DisqualifedStudent (p_snum, v_errorText);
		p_ErrorMsg := p_ErrorMsg||v_errorText;
	
		if p_ErrorMsg is null then
			Capacity (p_callnum, v_errorText);
			p_ErrorMsg := p_ErrorMsg||v_errorText;
				-- If Capacity not full
				if p_ErrorMsg is null then
					insert into enrollments values (p_snum, p_callnum,null);
					commit;
					dbms_output.put_line('Congratulations student number '||p_snum||' is now enrolled on class number '||p_callnum);
				-- If capacity full
				else
					RepeatWaitingList (p_snum, p_callnum, v_errorText);
					p_ErrorMsg := p_ErrorMsg||v_errorText;
						-- If the student is not on the waitlist
						if p_ErrorMsg is null then
							WaitingList (p_snum, p_callnum);
						-- If the student is on the waitlist already
						else
							dbms_output.put_line('You were not able to enroll because of the following reason(s): '||p_ErrorMsg);
						end if;
				end if;
				
		-- Capacity Full
		else
			Capacity (p_callnum, v_errorText);
			p_ErrorMsg := p_ErrorMsg||v_errorText;
		
			RepeatWaitingList (p_snum, p_callnum, v_errorText);
			p_ErrorMsg := p_ErrorMsg||v_errorText;
			
			dbms_output.put_line('You were not able to enroll because of the following reason(s): '||p_ErrorMsg);
		end if;
		
	else
		dbms_output.put_line('You were not able to enroll because of the following reasons: '||p_ErrorMsg);
	end if;
End;

------------ DropMe procedures

/*
|| Check if student is actually enrolled on the class
*/

procedure NotEnrolled
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2) as
	v_check integer;

Begin
	select count(snum) into v_check
	from enrollments
	where snum = p_snum
	and callnum = p_callnum
	;

	if v_check = 1 then
		p_result := null;
	else
		p_result := 'Student is not enrolled | '; 
	end if;
End;

/*
|| Already Graded
*/

procedure AlreadyGraded
	(p_snum students.snum%type,
	p_callnum schclasses.callnum%type,
	p_result out varchar2) as
	v_gradeCheck integer;
	
Begin
	select count(grade) into v_gradeCheck
	from enrollments
	where snum = p_snum
	and callnum = p_callnum
	;

	If v_gradeCheck = 0 then
		p_result := null;
	else
		p_result := 'Student already have a grade | ';
	end if;
End;
	
/*
|| Dropped The Student
*/

procedure DropMe
	(p_snum students.snum%type,
	p_callnum enrollments.callnum%type) as
	v_ErrorMsg varchar2 (2000);
	v_errorText varchar2 (200);
	v_CheckWaiting integer;
	
	cursor cur_Waiting is
		select snum, callnum, RequestTime
		from waitlist
		where callnum = p_CallNum
		order by RequestTime
		;

Begin	
		-- Check is there are students on the waitlist
		select count(snum) into v_CheckWaiting
		from waitlist
		where callnum = p_callnum
		;
		
		v_ErrorMsg := null;

		Validation (p_snum, p_callnum, v_errorText);
		v_ErrorMsg := v_errorText;
		
		if v_ErrorMsg is null then
			NotEnrolled (p_snum, p_callnum, v_errorText);
			v_ErrorMsg := v_ErrorMsg||v_errorText;
			
			AlreadyGraded (p_snum, p_callnum, v_errorText);
			v_ErrorMsg := v_ErrorMsg||v_errorText;
			
			if v_ErrorMsg is null then
					update enrollments set grade = 'W' 	where snum = p_snum and callnum = p_callnum;
					commit;
					dbms_output.put_line ('Congratulations student number '||p_snum||' have sucessfuly dropped from class number '||p_callnum);
				if v_CheckWaiting >= 1 then -- There are students on the waitlist	
						for EachRecord in cur_Waiting loop -- for every student on the waitlist run AddMe		
							AddMe(EachRecord.snum, EachRecord.callnum, v_ErrorMsg);
								if v_ErrorMsg is null then
									delete from waitlist where snum = EachRecord.snum and callnum = EachRecord.callnum; -- remove student from the waitlist
									commit;
								end if;
						end loop;
				end if;
			else
				dbms_output.put_line('You could not drop the class because of the following reason(s): '||v_ErrorMsg);
			end if;
		else
			dbms_output.put_line('You could not drop the class because of the following reason(s): '||v_ErrorMsg);
		end if;
End;

END Enroll;
/

/*  <== Remove this for testing 

--------------------------------- TESTING ---------------------------------

select * from enrollments order by callnum;
select * from waitlist order by requesttime;

declare
	v_whatever varchar2(2000);
begin

	-- AddMe Tests ------

	-- test existence
		Enroll.AddMe ('999','99999',v_whatever);
		
	-- test class existence
		Enroll.AddMe ('101','99999',v_whatever);
		
	-- test course existence
		Enroll.AddMe ('999','10110',v_whatever);
		
	-- test repeted enrollment
		Enroll.AddMe ('101','10110',v_whatever);
		
	-- test double enrollment
		Enroll.AddMe ('101','10115',v_whatever);
		
	-- test credit limit
		Enroll.AddMe ('109','10115',v_whatever); -- pass
		enroll.AddMe ('101','10110',v_whatever); -- fail
		
	-- test GPA
		Enroll.AddMe ('109','10115',v_whatever); -- fail
		Enroll.AddMe ('101','10110',v_whatever); -- pass
		
	-- test Capacity
		Enroll.AddMe ('110','10120',v_whatever); -- pass
		Enroll.AddMe ('101','10150',v_whatever); -- fail
		
	-- 	Standing requirement
		Enroll.AddMe ('125','10160',v_whatever); -- fail
		Enroll.AddMe ('104','10145',v_whatever); -- pass
		
	-- 	Disqualified student
		Enroll.AddMe ('129','10110',v_whatever); -- fail
		
	-- Repeted waitlist
		Enroll.AddMe ('125','10130',v_whatever); -- fail
		
	-- Successful AddMe
		Enroll.AddMe('111','10120',v_whatever);
		-- rollback 111 enrollment for testing

	-- Waitlist test
		Enroll.AddMe('111','10110',v_whatever);

	-- DropMe Tests ------

	--Not enrolled test
	Enroll.DropMe ('127','10110'); -- fail
	Enroll.DropMe ('101','10125'); -- pass
	-- rollback for testing

	-- Already graded test
	Enroll.DropMe ('102','10110'); -- fail
	Enroll.DropMe ('102','10130'); -- pass
	-- rollback for testing

	-- Successful drop
	Enroll.DropMe ('104','10145'); -- pass
	--rollback for testing
	
end;
/

Remove this for testing ==> */