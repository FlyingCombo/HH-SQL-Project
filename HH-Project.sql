/* 1.	Посчитать общее кол-во вакансий */
select count(id) as vacancies_amount 
from vacancies_data_for_analysis vdfa;

/* 2.	Найти дату последней опубликованной вакансии  */
select created_at 
from vacancies_data_for_analysis vdfa 
order by created_at  DESC  limit 1;

/* 3.	Найти вакансию с максимально предлагаемой зарплатой по вилке */
select name, "salary.from", "salary.to" 
from vacancies_data_for_analysis vdfa 
where vdfa."salary.from" is NOT NULL and vdfa."salary.to" is NOT NULL 
order by "salary.to"  DESC LIMIT 1;

/* 4.	Посчитать среднюю вилку зарплат. Нижнюю границу зарплаты  посчитать как среднее по всем указанным в вакансиях salary.from. 
Верхнюю границу вилки посчитать аналогично, только п полю salary.to */
select  
    round(avg("salary.from")) as avg_salary_from, 
    round(avg("salary.to")) as avg_salary_to 
from vacancies_data_for_analysis vdfa;


/* 5.	Посчитать, сколько вакансий предлагают работу без опыта  */
select count(*) as no_exp_vacancies
from vacancies_data_for_analysis vdfa 
WHERE "experience.name"="Нет опыта";

/* 6. Посчитать, сколько вакансий относятся к разным значениям  */
schedule.name
select count(id) as vac_amount,"schedule.name" 
from vacancies_data_for_analysis vdfa 
group by "schedule.name" 
order by vac_amount DESC 

/* 7. Посчитать средние вилки зарплат в разрезе опыта работы */
(experience.name)
select  
    "experience.name", 
    round(avg("salary.from")) as avg_salary_from, 
    round(avg("salary.to")) as avg_salary_to 
from vacancies_data_for_analysis vdfa 
group by "experience.name"
order by avg_salary_to DESC ;


/* 8. Посчитать кол-во вакансий по городам, вывести название города из 
справочника и кол-во вакансий в этом городе  */
select 
a.area_name,
count(vdfa.name) as vacancies_amount
from vacancies_data_for_analysis vdfa
left join area a
on vdfa."area.id" = a.area_id 
group by a.area_name 
order by vacancies_amount desc;


/* 9. Сделать топ 10 рейтинг работодателей с их названиями по числу 
опубликованных вакансий */
select 
e.employer_name,
count(vdfa.name) as vacancies_amount
from vacancies_data_for_analysis vdfa
left join employer e 
on vdfa."employer.id" = e.employer_id
group by e.employer_name
order by vacancies_amount desc
limit 10;




