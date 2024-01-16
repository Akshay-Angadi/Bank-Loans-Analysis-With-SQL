---> 1. BANK LOAN REPORT - SUMMARY

--> KPI’s:

/* 1. Bank Loan Applications */
SELECT COUNT(id) AS Total_Applications FROM Bank_Loan_Report_Database

/* MTD - Month-to-date */
SELECT COUNT(id) AS MTD_Applications FROM Bank_Loan_Report_Database WHERE MONTH(issue_date) = 12

/* PMTD - Previous month-to-date */
SELECT COUNT(id) AS PMTD_Applications FROM Bank_Loan_Report_Database WHERE MONTH(issue_date) = 11

/* 2. Loans Amount */
SELECT SUM(loan_amount) AS Total_Loan_Amount FROM Bank_Loan_Report_Database

MTD Total Loan Amount
SELECT SUM(loan_amount) AS Total_MTD_Loan_Amount FROM Bank_Loan_Report_Database WHERE MONTH(issue_date) = 12

PMTD Total Loan Amount
SELECT SUM(loan_amount) AS Total_PMTD_Loan_Amount FROM Bank_Loan_Report_Database WHERE MONTH(issue_date) = 11

/* 3. Loans Re-Payment */
SELECT SUM(total_payment) AS Total_Loan_Re_Payment FROM Bank_Loan_Report_Database

MTD Total Loan Re-Payment
SELECT SUM(total_payment) AS Total_MTD_Loan_Re_Payment FROM Bank_Loan_Report_Database WHERE MONTH(issue_date) = 12

PMTD Total Loan Re-Payment
SELECT SUM(total_payment) AS Total_PMTD_Loan_Re_Payment FROM Bank_Loan_Report_Database WHERE MONTH(issue_date) = 11

/* 4. Interest Rate */
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM Bank_Loan_Report_Database

MTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM Bank_Loan_Report_Database WHERE MONTH(issue_date) = 12

PMTD Average Interest
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM Bank_Loan_Report_Database WHERE MONTH(issue_date) = 11

/* 5. Debt to income(DTI) */
SELECT AVG(dti)*100 AS Avg_DTI FROM Bank_Loan_Report_Database

MTD Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM Bank_Loan_Report_Database WHERE MONTH(issue_date) = 12

PMTD Avg DTI
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM Bank_Loan_Report_Database WHERE MONTH(issue_date) = 11

---> GOOD LOAN ISSUED

/* 1.Good Loan Percentage */
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
    COUNT(id) AS Good_Loan_Percentage
FROM Bank_Loan_Report_Database

/* 2.Good Loan Applications */
SELECT COUNT(id) AS Good_Loan_Applications FROM Bank_Loan_Report_Database WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/* 3.Good Loan Amount */
SELECT SUM(loan_amount) AS Good_Loan_amount FROM Bank_Loan_Report_Database WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/* 4.Good Loan Re-Payment */
SELECT SUM(total_payment) AS Good_Loan_Re_Payment FROM Bank_Loan_Report_Database WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

---> BAD LOAN ISSUED

/* 1.Bad Loan Percentage */
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
    COUNT(id) AS Bad_Loan_Percentage
FROM Bank_Loan_Report_Database

/* 2.Bad Loan Applications */
SELECT COUNT(id) AS Bad_Loan_Applications FROM Bank_Loan_Report_Database WHERE loan_status = 'Charged Off'

/* 3.Bad Loan Amount */
SELECT SUM(loan_amount) AS Bad_Loan_amount FROM Bank_Loan_Report_Database WHERE loan_status = 'Charged Off'

/* 4.Bad Loan Re-Payment */
SELECT SUM(total_payment) AS Bad_Loan_Re_Payment FROM Bank_Loan_Report_Database WHERE loan_status = 'Charged Off'

---> LOAN STATUS

/* 1 */
SELECT
    loan_status,
    COUNT(id) AS Total_Applications,
    SUM(total_payment) AS Total_Re_Payment,
    SUM(loan_amount) AS Total_Loan_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti * 100) AS DTI
FROM
    Bank_Loan_Report_Database
GROUP BY
    loan_status

/* 2 */
SELECT 
    loan_status, 
    SUM(total_payment) AS MTD_Total_Re_Payment, 
    SUM(loan_amount) AS MTD_Total_Loan_Amount 
FROM Bank_Loan_Report_Database
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

---> 2.BANK LOAN REPORT - OVERVIEW

/* 1.MONTH */
SELECT 
    MONTH(issue_date) AS Month_Number, 
    DATENAME(MONTH, issue_date) AS Month_name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Loan_Amount,
    SUM(total_payment) AS Total_Re_Payment
FROM Bank_Loan_Report_Database
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

/* STATE */
SELECT 
    address_state AS State, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Loan_Amount,
    SUM(total_payment) AS Total_Re_Payment
FROM Bank_Loan_Report_Database
GROUP BY address_state
ORDER BY address_state

/* TERM */
SELECT 
    term AS Term, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Loan_Amount,
    SUM(total_payment) AS Total_Re_Payment
FROM Bank_Loan_Report_Database
GROUP BY term
ORDER BY term

/* EMPLOYEE LENGTH */
SELECT 
    emp_length AS Employee_Length, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Loan_Amount,
    SUM(total_payment) AS Total_Re_Payment
FROM Bank_Loan_Report_Database
GROUP BY emp_length
ORDER BY emp_length

/* PURPOSE */
SELECT 
    purpose AS PURPOSE, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Loan_Amount,
    SUM(total_payment) AS Total_Re_Payment
FROM Bank_Loan_Report_Database
GROUP BY purpose
ORDER BY purpose

/* HOME OWNERSHIP */
SELECT 
    home_ownership AS Home_Ownership, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Loan_Amount,
    SUM(total_payment) AS Total_Re_Payment
FROM Bank_Loan_Report_Database
GROUP BY home_ownership
ORDER BY home_ownership

/* GRADE */
SELECT 
    grade AS Gradee, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Loan_Amount,
    SUM(total_payment) AS Total_Re_Payment
FROM Bank_Loan_Report_Database
GROUP BY grade
ORDER BY grade
