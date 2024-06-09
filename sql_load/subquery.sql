WITH january_jobs AS (
SELECT *
FROM
    job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT
    january_jobs