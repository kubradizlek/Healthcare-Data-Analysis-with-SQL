
# Advanced SQL Analysis on Healthcare Dataset



### **Overview**
Healthcare data plays a crucial role in understanding patient demographics, medical conditions, hospital operations, and financial costs associated with treatment. This dataset includes patient records such as age, gender, medical conditions, admission details, hospital names, doctor assignments, insurance providers, billing amounts, and test results. 

By analyzing this dataset, we aim to uncover trends in patient admissions, hospital billing, medical conditions, and insurance provider expenses. The insights gained can help improve hospital resource management, financial planning, and patient care strategies.

### **Methodology**
To ensure a structured approach to analyzing the dataset, we followed these steps:

1. **Importing Data** – Loaded the dataset into SQL for analysis.
2. **Data Cleaning** – Checked for inconsistencies, missing values, and potential errors in hospital names, patient details, and billing amounts.
3. **Exploratory Data Analysis (EDA)** – Conducted an initial review of patient demographics, medical conditions, and billing distribution.
4. **Analysis** – Performed SQL queries to extract valuable insights from the dataset.

### **Key Questions to Answer**
The project focuses on answering the following key business questions:

- **Which hospitals generate the highest billing for emergency cases?**
- **What are the most common medical conditions per age group, and what is the average billing for each group?**
- **How frequently do patients get readmitted within three years, and how much do they cost?**
- **Which insurance provider covers the highest billing per patient?**
- **How many patients does each doctor handle, and what is their average billing amount?**

## Analyses and Insights

### **1. Goal:**  
**Identify the top 5 hospitals with the highest total billing amount for patients admitted due to emergency cases.**  
*(This helps analyze which hospitals handle the most costly emergency cases, crucial for financial planning.)*

```sql
SELECT hospital, SUM(billing_amount) AS total_billing
FROM healthcare_dataset
WHERE admission_type = 'Emergency'
GROUP BY hospital
ORDER BY total_billing DESC
LIMIT 5;

```

The results highlight hospitals that accumulate the highest billing for emergency patients. This can help healthcare administrators allocate resources effectively and identify trends in emergency admissions.



### 2. Goal:  
**Analyze the average billing amount and the most common medical condition per age group (grouped by decades).**  
*(This provides insights into which medical conditions are most prevalent in each age bracket and their financial impact.)*

#### **SQL Query:**
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

Different age groups exhibit distinct medical conditions, with some being more prevalent in certain age brackets. For example, younger age groups may have fewer chronic conditions, while older groups may show a higher incidence of diseases such as diabetes, hypertension, or obesity. Additionally, the average billing amount varies by age, reflecting differences in treatment complexity and hospitalization costs. These insights can help hospitals optimize resource allocation and tailor preventive care strategies.





### 3. Goal:  
**Evaluate the readmission rate by identifying patients who were admitted multiple times within the past 3 years and calculating their total billing amount.**  
*(This helps identify frequent patients and their financial burden on the healthcare system.)*

#### **SQL Query:**
```sql
SELECT first_name, last_name, COUNT(*) AS admission_count, SUM(billing_amount) AS total_billing
FROM healthcare_dataset
WHERE dateofadmission >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
GROUP BY first_name, last_name
HAVING admission_count > 1
ORDER BY admission_count DESC;


```




Frequent readmissions could indicate chronic illnesses or inadequate post-treatment care. A high number of repeat admissions may suggest that patients are not receiving effective long-term treatment, leading to a cycle of hospitalization. These insights allow healthcare providers to develop better follow-up programs, improve preventive care, and allocate resources to reduce unnecessary hospital stays. Additionally, understanding the financial impact of readmissions can help in cost optimization and policy-making.




### 4. Goal:  
**Determine the insurance provider with the highest average billing amount per patient.**  
*(This helps healthcare institutions understand which insurance companies cover the most expensive treatments, aiding in strategic financial planning.)*

#### **SQL Query:**
```sql
SELECT insurance_provider, ROUND(AVG(billing_amount), 2) AS avg_billing
FROM healthcare_dataset
GROUP BY insurance_provider
ORDER BY avg_billing DESC
LIMIT 1;


```


Insurance providers differ in the average cost of claims they process. Identifying the insurance company with the highest average billing amount can help hospitals evaluate financial risks and optimize contract negotiations. Additionally, this insight enables policymakers to assess which insurance plans contribute the most to healthcare costs, helping in decision-making for cost reduction strategies and premium adjustments.


### 5. Goal:  
**Analyze the number of patients each doctor has treated and their corresponding average billing amount.**  
*(This provides insights into patient distribution across doctors and helps evaluate workload balance and revenue generation.)*

#### **SQL Query:**
```sql
SELECT doctor, COUNT(*) AS patient_count, ROUND(AVG(billing_amount), 2) AS avg_billing
FROM healthcare_dataset
GROUP BY doctor
ORDER BY patient_count DESC;

```
Some doctors manage significantly more patients than others, which may indicate specialization in high-demand treatments or understaffing issues in certain departments. Understanding doctor-patient distribution helps in workload balancing, optimizing hospital operations, and ensuring patient care quality. Additionally, analyzing the average billing per doctor provides insights into revenue generation and potential disparities in treatment costs among practitioners.

