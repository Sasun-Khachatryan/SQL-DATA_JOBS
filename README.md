# Introduction
Dive into the data job market! Focusion on data analyst roles, this project explores top paying jobs, in-demand skills, and where high demand meets high salary in data analytics. 
SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to tinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs. 
The data is packed with insights on job titles, salaries, locations and essential skills. 

### The questions I want to answer through my SQL queries were:
    1. What are the top-paying data analyst jobs?
    2. What skills are required for these top-paying jobs?
    3. What skills are most in demand for data analysts?
    4. Which skills are associated with higher salaries?
    5. What are the most optimal skills to learn?


# Tools I used

For my deep dive into the data analyst job market, I harnessed the power of several key tools: 
- **SQL**: The bankbone of analysis, allowing me to quert the database and unearth critical insights.
- **PostgreSQL**: The chose database management system, ideal for handling the job-posting data.
- **Visual Studio Code**: My go-to for database management and executing SQL  queries. 
- **Git & Github**: Essential for version control and sharing my SQL scrips and analysis, ensuring collaboration and project tracking. 

# The Analysis 
Each query for this project aimed at investigation the specifict aspect of the data analyst job market. Here is how I approached each question:

### 1. Top paying data analyst jobs.
To identify the highest paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high-paying opportunities in the field. 

``` sql
SELECT
    job_id,
    name AS company_name,
    job_title,
    job_location, 
    job_schedule_type,
    salary_year_avg,
    job_posted_date
        
FROM
    job_postings_fact
LEFT JOIN company_dim ON 
    job_postings_fact.company_id=company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
--AND job_work_from_home = TRUE
AND job_location = 'Anywhere'
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
```

### 2. Top paying job skills.
``` sql
WITH top_paying_jobs AS (

    SELECT
        job_id,
        name AS company_name,
        job_title,  
        salary_year_avg       
        
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON 
        job_postings_fact.company_id=company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
    --AND job_work_from_home = TRUE
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
    )
SELECT 
    top_paying_jobs.*,
    skills
    FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC
```
### 3. Top demanded skills in data analyst joba market. 

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
AND job_work_from_home = TRUE
GROUP BY skills           
ORDER BY demand_count DESC
LIMIT 5
```
### 4. Top paying skills in the date job market. 

```sql
SELECT 
    skills,
ROUND( AVG(salary_year_avg),0) AS average_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
AND job_work_from_home = TRUE
AND salary_year_avg is NOT NULL
GROUP BY skills           
ORDER BY average_salary DESC
LIMIT 25
```
Here is the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.

- **Divers Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries. 

- **Job Title Variety:** There is a high diversity in job titles from Data Abalyst to Director of Analytics, reflecting varied roles ans specializations within data analytics. 


### 5. Optimal skills. 

```sql
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id,
        skills_dim.skills
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
    GROUP BY    
        skills_job_dim.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count >10
ORDER by 
    avg_salary DESC,
    demand_count DESC
   
    LIMIT 25
```    
# What I learned
- **Complex query crafting** 
- **Data Aggregation**
- **Analytical Wizardry**


# Conclusions 
### Insights
1. **Top-Paying Jobs** for Data Analysts: The highest-paying data analyst jobs that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs:** High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills:** SQL is also the most demanded skill in the data analyst job market, making it essential for job seekers.
4. **Skills with Higher Salaries:** Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn and maximize their market value.
### Closing thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide for those aspiring data analysts to better search efforts. Aspiring analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.

