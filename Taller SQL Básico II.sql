/* a) Proyecte los nombres y apellidos de los empleados que han tenido al menos un cambio de trabajo (JOB) */
SELECT distinct e.first_name,e.last_name 
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id;

/* b) Averig�e y proyecte cuales son los empleados que solo hayan tenido un cargo o trabajo (JOB). */
SELECT employeed_id FROM employees
MINUS
SELECT distinct employee_id
FROM job_history j;

SELECT distinct job_history.employee_id FROM job_history;

/* c) Averig�e y proyecte cu�l es la cantidad de trabajos que ha tenido cada uno de los empleados. */
Select job_history.employee_id, COUNT(job_id) as jobs  
FROM job_history group by job_history.employee_id;

/* d) Proyecta los departamentos con la lista de los meses en que los empleados cumplen aniversario de contrataci�n. 
      La lista va al frente del c�digo del departamento y est� separada por comas. */
SELECT department_id || ',' ||  
EXTRACT(MONTH FROM hire_date)
FROM employees;
 
/* e) Seleccione los empleados que cumplen aniversario de trabajo en el mes de mayo y proyecte su email, nombre, d�a y mes de ingreso a trabajar. */
SELECT email, first_name, 
EXTRACT(DAY FROM hire_date) dia , 
EXTRACT(MONTH FROM hire_date) 
FROM employees
WHERE EXTRACT(MONTH FROM hire_date) = 5;

/* f) Seleccione los empleados cuyo nombre y apellido inicien por la misma letra y proyecte el ID, nombre y apellido todo en may�sculas. */
SELECT employee_id, 
UPPER(first_name), 
UPPER(last_name)
FROM employees
WHERE SUBSTR(first_name,1,1) = SUBSTR(last_name,1,1);

/* g) Seleccione los empleados que ingresaron a trabajar en el mismo mes del mes actual y proyectar un saludo que diga: �Estimado NOMBRE, es para nosotros 
      un gusto que hayas compartido con nosotros durante los �ltimos X d�as. Queremos expresarte que puedes contar con nosotros y que contamos contigo. 
      Por favor pasa el ULTIMO_DIA_DEL MES por el sal�n principal para la reuni�n de celebraci�n�. */
SELECT 
'Estimado ' || first_name || ', es para nosotros un gusto que hayas compartido con nosotros durante los �ltimos ' || ROUND( (SYSDATE - hire_date),0 ) || ' d�as.
Queremos expresarte que puedes contar con nosotros y que contamos contigo.
Por favor pasa el ' || SUBSTR(LAST_DAY(SYSDATE),1,2) || ' por el sal�n principal para la
reuni�n de celebraci�n�.'
FROM employees
WHERE EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM hire_date);
      
/* h) Proyecta el ID, nombre, apellido, salario y experiencia. La experiencia se determina en 1, 2, 3 o 4 as�:
      Antig�edad Rango
      [0, 5) a�os 1
      [5, 10) a�os 2
      [10,15) a�os 3
      [15, ?) a�os 4 */
      

/* k) Determine como y que hace el siguiente �Query�. Tambi�n identifique opci�n de mejora, si la hay: */
select Exp(Sum(LN(level))) factorial
from dual
connect by level <= :n;         
/* R// El Query se encarga de sacar el factorial de un numero que es digitado por el usuario */

/* l) Determine como y que hace el siguiente �Query�: */
SELECT * FROM (SELECT
COALESCE(To_Char(dep), 'Total') dep,
COALESCE(mes, 'Total') mes, sal
FROM (SELECT
Nvl(department_id,0) dep,
to_char(hire_date, 'mm') mes,
Sum(salary) sal
FROM employees
GROUP BY CUBE (Nvl(department_id,0), to_char(hire_date, 'mm')))) t
PIVOT (Sum(sal)
FOR mes In ('01' as "01",'02' as "02",'03' as "03",'04' as "04",
'05' as "05",'06' as "06",'07' as "07",'08' as "08",
'09' as "09",'10' as "10",'11' as "11",'12' as "12",
'Total' as Total))
ORDER BY CASE dep WHEN 'Total' THEN 1 ELSE 0 END,
CASE dep WHEN 'Total' THEN 0 ELSE To_Number(dep) END;
/* R// selecciona el id del departamento en relacion a 12 columnas que representan los meses desde enero a diciembre (1-12) y el total de esos meses segun el 
       id del departamento. Segun el id del departamento se suma el salario dependiendo del mes y luego se muestra el total de los salarios en los 12 meses segun el id
       del departamento, los campos nulos hace referencia a que no hay empleados que tengan fecha de inicio en ese mes. */     
       
/* m) Determine como y que hace el siguiente �Query�: */
SELECT department_id "Dept.",
LISTAGG(last_name, '; ')
WITHIN GROUP (ORDER BY hire_date) "Employees"
FROM employees
GROUP BY department_id
ORDER BY department_id; 
/* R// selecciona el id del departamento y en la siguiente columna inclute el apellido concatenado con un ; y incluye en el grupo el resto de apellidos 
    que corresponden a un mismo id de departamento y luego los agrupa y los ordena por el id del departamento */
    
/* n) Determine como y que hace el siguiente �Query� en t�rminos que qu� selecciona y qu� proyecta: */
SELECT first_name||' '||last_name "Employee", 
LEVEL, SYS_CONNECT_BY_PATH(last_name, '/') "Path"
FROM employees
WHERE level <= 3 AND department_id = 80
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id AND LEVEL <= 4;
/* R// primero selecciona el nombre y apellido en una sola columna que determinamos Employee luego se define el nivel segun el tama�o del path y el path lo que hace es 
       ir union los apellidos, el path esta definido por niveles y cada nivel representa el rango de empleados, todo esto en representacion de grafo de tipo arbol*/
       
/* �) Determine como y que hacen los siguientes �Querys� en t�rminos que qu� seleccionan y qu� proyectan: */
SELECT e.last_name, e.department_id, Count(department_id) 
FROM employees e
GROUP BY e.last_name, e.department_id;
/* R// selecciona el apellido, el id del departmento  y hace un conteo del id del departamento y los ordena por el apellido y el id del departamento */

SELECT e.last_name, e.department_id, Count(department_id) OVER (PARTITION BY 
e.department_id) Quantity 
FROM employees e
GROUP BY e.last_name, e.department_id;
/* R// selecciona el apellido, el id del departmento  y hace un conteo del id del departamento y los ordena por el apellido y el id del departamento, 
       ademas se cuenta cuantos empleados hay por departamento */

