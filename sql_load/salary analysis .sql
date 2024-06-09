SELECT 
    job_location,
    salary_year_avg,
CASE 
    WHEN salary_year_avg < 100000 THEN 'Low salary'
    WHEN salary_year_avg between 100000 and 200000 then 'Mid salary'
    when salary_year_avg between 200000 and 300000 then 'Above Mid salary'
    else 'High salary' 
    end AS salary_size
FROM 
    job_postings_fact
    WHERE salary_year_avg is not NULL
ORDER BY    
    salary_year_avg DESC;