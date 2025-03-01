
with top_paying_jobs AS (
    SELECT 
        job_postings_fact.job_id,
        job_postings_fact.job_title,
        company_dim.name AS company_name,
        job_postings_fact.salary_year_avg
    FROM 
        job_postings_fact
    left join company_dim ON job_postings_fact.company_id = company_dim.company_id
    where 
        job_title_short = 'Data Analyst' AND
        salary_year_avg is not NULL AND
        job_location = 'Anywhere'
    order by 
        salary_year_avg DESC
    limit 10
)




select 
    top_paying_jobs.*,
    skills
from top_paying_jobs
left JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC



