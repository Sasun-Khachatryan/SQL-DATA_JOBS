SELECT
    job_title_short AS Title,
    job_location AS Location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
    Limit 50;
