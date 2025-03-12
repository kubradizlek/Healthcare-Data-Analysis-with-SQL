## SQL Queries

### **Goal 1:**
```sql
SELECT hospital, SUM(billing_amount) AS total_billing
FROM healthcare_dataset
WHERE admission_type = 'Emergency'
GROUP BY hospital
ORDER BY total_billing DESC
LIMIT 5;
 
```



### **Goal 2:**
```sql
SELECT 
    CASE 
        WHEN age BETWEEN 0 AND 9 THEN '0-9'
        WHEN age BETWEEN 10 AND 19 THEN '10-19'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        WHEN age BETWEEN 70 AND 79 THEN '70-79'
        ELSE '80+'
    END AS age_group,
    ROUND(AVG(billing_amount), 2) AS avg_billing,
    (SELECT medical_condition 
     FROM healthcare_dataset h2 
     WHERE h2.age = h1.age
     GROUP BY medical_condition
     ORDER BY COUNT(*) DESC 
     LIMIT 1) AS most_common_condition
FROM healthcare_dataset h1
GROUP BY age_group;


```



### **Goal 3:**
```sql
SELECT first_name, last_name, COUNT(*) AS admission_count, SUM(billing_amount) AS total_billing
FROM healthcare_dataset
WHERE dateofadmission >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
GROUP BY first_name, last_name
HAVING admission_count > 1
ORDER BY admission_count DESC;


```




### **Goal 4:**
```sql

SELECT insurance_provider, ROUND(AVG(billing_amount), 2) AS avg_billing
FROM healthcare_dataset
GROUP BY insurance_provider
ORDER BY avg_billing DESC
LIMIT 1;

```




### **Goal 5:**
```sql
SELECT doctor, COUNT(*) AS patient_count, ROUND(AVG(billing_amount), 2) AS avg_billing
FROM healthcare_dataset
GROUP BY doctor
ORDER BY patient_count DESC;


```






