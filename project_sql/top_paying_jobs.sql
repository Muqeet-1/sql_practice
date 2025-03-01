SELECT * from job_postings_fact
limit 10;


SELECT 
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    company_dim.name AS company_name,
    job_postings_fact.job_location,
    job_postings_fact.job_schedule_type,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_posted_date
FROM 
    job_postings_fact
left join company_dim ON job_postings_fact.company_id = company_dim.company_id
where 
    job_title_short = 'Data Analyst' AND
    salary_year_avg is not NULL AND
    job_location = 'Anywhere'
order by 
    salary_year_avg DESC
limit 10;





