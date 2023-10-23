--QUEST1)

create table code_employees(
empno int primary key,
empname varchar(30) not null,
emptype char(1) check (emptype in ('f','p')),
empsal numeric(10,2) check(empsal>=25000))

create procedure addemployees
@empname varchar(30),@empsal numeric(10,2),@emptype char(1)
as 
begin
declare @empno int
select @empno= isnull(max(empno),0)+1 from code_employees
insert into code_employees(empno,empname,empsal,emptype)
values(@empno,@empname,@empsal,@emptype);
end

--test 
exec addemployees 'varsha',30000,'f'

exec addemployees 'kee',25000,'p'



/*II. Write a Cursor program, that retrieves all the employees and updates salary for all employees 
of Department 10(Accounting) by 15%*/
------
---- Declare the variables for the cursor
DECLARE @empno NUMERIC(4);
DECLARE @salary INT;

-- Declare the cursor
DECLARE employee_cursor CURSOR FOR
SELECT empno, salary
FROM EMPY
WHERE deptno = 10;

-- Open the cursor
OPEN employee_cursor;

-- Fetch the first row
FETCH NEXT FROM employee_cursor INTO @empno, @sal;

-- Loop through the cursor
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Update the salary with a 15% increase
    UPDATE EMPY
    SET salary = salary * 1.15
    WHERE empno = @empno;

    -- Fetch the next row
    FETCH NEXT FROM employee_cursor INTO @empno, @sal;
END

-- Close and deallocate the cursor
CLOSE employee_cursor;
DEALLOCATE employee_cursor;

-- Select the updated records to verify
SELECT * FROM EMPY WHERE deptno = 10;