SELECT 
    skills_dim.skills, 
    round(AVG(salary_year_avg), 0) AS Average_salary
FROM job_postings_fact
left JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst' AND salary_year_avg is not NULL
GROUP BY 
    skills_dim.skills
order BY
    Average_salary DESC
LIMIT 20; 