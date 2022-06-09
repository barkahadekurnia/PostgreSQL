/*
1. Buat query untuk menampilkan data berikut :
*/

SELECT regions.region_id , regions.region_name , countries.country_id , countries.country_name 
FROM regions JOIN countries ON regions.region_id = countries.region_id ;

/*
2. Tampilkan berapa countries yang dimiliki oleh tiap regions.
*/

SELECT regions.region_id , regions.region_name , count(regions.region_name) total_countries
FROM regions JOIN countries ON regions.region_id = countries.region_id 
GROUP BY regions.region_id , regions.region_name , regions.region_name 
ORDER BY regions.region_id ASC ;


/*
3. Tampilkan country dan locations di region Europe
*/

SELECT countries.country_id,countries.country_name,locations.location_id,locations.street_address,locations.postal_code,locations.city,locations.state_province
FROM regions 
JOIN countries ON regions.region_id = countries.region_id 
JOIN locations ON countries.country_id = locations.country_id
WHERE regions.region_name = 'Europe'
;

/*
4. Tampilkan department yang ada di region America
*/

SELECT departments.*
FROM regions 
JOIN countries ON regions.region_id = countries.region_id 
JOIN locations ON countries.country_id = locations.country_id
JOIN departments ON locations.location_id = departments.location_id
WHERE regions.region_name = 'Americas'
;

/*
5. Tampilkan jumlah departments tiap region
*/

SELECT  regions.region_name , count(regions.region_name) total_departments
FROM regions 
JOIN countries ON regions.region_id = countries.region_id 
JOIN locations ON countries.country_id = locations.country_id
JOIN departments ON locations.location_id = departments.location_id
GROUP BY regions.region_name ,regions.region_name
;

/*
6. Tampilkan jumlah department tiap country
*/

SELECT  countries.country_name , count(regions.region_name) total_departments
FROM regions 
JOIN countries ON regions.region_id = countries.region_id 
JOIN locations ON countries.country_id = locations.country_id
JOIN departments ON locations.location_id = departments.location_id
GROUP BY countries.country_name ,regions.region_name
ORDER BY countries.country_name ASC
;

/*
7. Tampilkan country yang memiliki total_department paling banyak.
*/

SELECT  MAX (total_departments) total_departments
FROM (
SELECT  countries.country_name , count(regions.region_name) total_departments
FROM regions 
JOIN countries ON regions.region_id = countries.region_id 
JOIN locations ON countries.country_id = locations.country_id
JOIN departments ON locations.location_id = departments.location_id
GROUP BY countries.country_name ,regions.region_name
) AS foo;

/*
8. Tampilkan jumlah employee tiap department terurut ascending
*/

SELECT  departments.department_id , departments.department_name , 
count(departments.department_name) total_emps
FROM departments
JOIN employees ON departments.department_id = employees.department_id
GROUP BY departments.department_id, departments.department_name 
ORDER BY total_emps  ASC
;

/*
9. Tampilkan jumlah employee tiap department yang ada di region America
*/

SELECT  departments.department_id , departments.department_name , 
count(departments.department_name) total_emps
FROM regions 
JOIN countries ON regions.region_id = countries.region_id 
JOIN locations ON countries.country_id = locations.country_id
JOIN departments ON locations.location_id = departments.location_id
JOIN employees ON departments.department_id = employees.department_id
WHERE regions.region_name = 'Americas'
GROUP BY departments.department_id, departments.department_name 
ORDER BY total_emps  ASC
;

/*
10.Tampilkan employees yang mendapatkan bonus akhir tahun, jika masa kerja employees >= 25 
tahun akan mendapatkan bonus 5x salary, jika kurang akan mendapatkan 3x salary. Hint : 
gunakan extract(year from age(now(),hire_date))
*/


select employees.employee_id,employees.first_name,employees.last_name,employees.salary, 
extract(year from age(now(),hire_date)) as masa_kerja, 
CASE WHEN extract(year from age(now(),hire_date)) >= 25 THEN salary*5 ELSE salary*3 END AS bonus 
from employees 


/*
11.Tampilkan bonus tiap masa kerja 
*/


SELECT masa_kerja, sum(salary*5) bonus FROM (
SELECT employee_id,first_name,last_name,salary, 
extract(year from age(now(),hire_date)) masa_kerja
FROM employees 
) as foo WHERE masa_kerja >= 25
GROUP BY employee_id,first_name,last_name,salary,foo.masa_kerja
ORDER BY masa_kerja  ASC 

/*
12. Tampilkan jumlah pegawai berdasarkan masa kerja nya.
*/


-- masa kerja 15 - 25
SELECT count(masa_kerja) masa_kerjakurangdari25
FROM  (
SELECT extract(year from age(now(),hire_date)) masa_kerja
FROM employees 
ORDER BY masa_kerja  ASC 
) as fo WHERE masa_kerja >= 15 AND masa_kerja <= 25 

-- masa kerja 25 - 30
SELECT count(masa_kerja) masa_kerjaantara25dan30
FROM  (
SELECT extract(year from age(now(),hire_date)) masa_kerja
FROM employees 
ORDER BY masa_kerja  ASC 
) as foo WHERE masa_kerja >= 25 AND masa_kerja <= 30

-- masa kerja 30 - 35
SELECT count(masa_kerja) masa_kerjaantara25dan30
FROM  (
SELECT extract(year from age(now(),hire_date)) masa_kerja
FROM employees 
ORDER BY masa_kerja  ASC 
) as foo WHERE masa_kerja >= 30 AND masa_kerja <= 35

/*
13.Buat tampilan matrix jumlah pegawai berdasarkan masa kerja di tiap department
*/






