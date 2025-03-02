

WITH top_paying_skill AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills, 
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    inner JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id, skills_dim.skills
), 
Average_salary AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills, 
        ROUND(AVG(salary_year_avg), 0) AS high_average_salary
    FROM job_postings_fact
    inner JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id, skills_dim.skills
), 
Ranked_skills AS (
    SELECT 
        top_paying_skill.skill_id,
        top_paying_skill.skills,
        demand_count,
        high_average_salary,
        RANK() OVER (ORDER BY high_average_salary DESC) AS salary_rank,
        RANK() OVER (ORDER BY demand_count DESC) AS demand_rank
    FROM top_paying_skill
    INNER JOIN Average_salary ON top_paying_skill.skill_id = Average_salary.skill_id
)

SELECT 
    skill_id,
    skills,
    demand_count,
    high_average_salary,
    (salary_rank + demand_rank) AS optimal_score
FROM Ranked_skills
ORDER BY demand_count DESC;







