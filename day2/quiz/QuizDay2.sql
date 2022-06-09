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

SELECT employees.employee_id,employees.first_name,employees.last_name,employees.salary, 
extract(year from age(now(),hire_date)) masa_kerja, 
CASE WHEN extract(year from age(now(),hire_date)) >= 25 THEN salary*5 ELSE salary*3 END AS bonus 
FROM employees 

/*
11.Tampilkan bonus tiap masa kerja 
*/

SELECT masa_kerja , 
SUM(COALESCE(bonus))"bonus"
FROM (
SELECT 
extract(year from age(now(),hire_date)) masa_kerja, 
CASE WHEN extract(year from age(now(),hire_date)) >= 25 THEN salary*5 ELSE salary*3 END AS bonus 
FROM employees 
) as foo 
GROUP BY masa_kerja 
ORDER BY masa_kerja ASC 

/*
12. Tampilkan jumlah pegawai berdasarkan masa kerja nya.
*/

SELECT 
SUM(COALESCE(masa_kerja1525))"15>=masakerja<=25" ,
SUM(COALESCE(masa_kerja2530))"25>=masakerja<=30" ,
SUM(COALESCE(masa_kerja3035))"30>=masakerja<=35" 
FROM (
SELECT 
CASE WHEN extract(year from age(now(),hire_date)) <= 25 THEN COUNT(employee_id) END AS masa_kerja1525 ,
CASE WHEN extract(year from age(now(),hire_date)) > 25 AND extract(year from age(now(),hire_date)) < 30 THEN COUNT(employee_id) END AS masa_kerja2530 ,
CASE WHEN extract(year from age(now(),hire_date)) >= 30 AND extract(year from age(now(),hire_date)) <= 35  THEN COUNT(employee_id) END AS masa_kerja3035 
FROM employees AS foo GROUP BY hire_date,employee_id 
) AS foo 


/*
13.Buat tampilan matrix jumlah pegawai berdasarkan masa kerja di tiap department
*/

SELECT department_id , department_name,
SUM(COALESCE(masa_kerja1525,0))"15>=masakerja<=25" ,
SUM(COALESCE(masa_kerja2530,0))"25>=masakerja<=30" ,
SUM(COALESCE(masa_kerja3035,0))"30>=masakerja<=35" 
FROM (
SELECT departments.department_id , departments.department_name,
CASE WHEN extract(year from age(now(),hire_date)) <= 25 THEN COUNT(employee_id) END AS masa_kerja1525 ,
CASE WHEN extract(year from age(now(),hire_date)) > 25 AND extract(year from age(now(),hire_date)) < 30 THEN COUNT(employee_id) END AS masa_kerja2530 ,
CASE WHEN extract(year from age(now(),hire_date)) >= 30 AND extract(year from age(now(),hire_date)) <= 35  THEN COUNT(employee_id) END AS masa_kerja3035 
FROM employees JOIN departments ON employees.department_id = departments.department_id
GROUP BY departments.department_id , departments.department_name,employees.hire_date,employees.employee_id 
) AS fooo GROUP BY department_id , department_name 
ORDER BY department_name ASC









-- Barkah Ade Kurnia , Code Academy