-- Medical Claim Denial Analysis - SQL Script
-- Author: Akshat Shrivas
-- Purpose: Define tables, sample data, and analysis queries

-------------------------
-- 1. TABLE DEFINITIONS
-------------------------

-- Core claim table
CREATE TABLE Claims (
    Claim_ID VARCHAR(10) PRIMARY KEY,
    Patient_ID VARCHAR(10),
    Department VARCHAR(50),
    Payer_ID VARCHAR(10),
    Claim_Date DATE,
    Claim_Amount DECIMAL(10,2),
    Claim_Status VARCHAR(10)  -- Paid / Denied
);

-- Denial fact table
CREATE TABLE Denials (
    Denial_ID VARCHAR(10) PRIMARY KEY,
    Claim_ID VARCHAR(10),
    Denial_Date DATE,
    Denial_Code VARCHAR(10),
    Denial_Amount DECIMAL(10,2),
    FOREIGN KEY (Claim_ID) REFERENCES Claims(Claim_ID)
);

-- Denial reason dimension
CREATE TABLE DenialReasons (
    Denial_Code VARCHAR(10) PRIMARY KEY,
    Category VARCHAR(20),   -- Coding / Eligibility / Documentation / Other
    Reason_Description VARCHAR(200)
);

-- Payer dimension
CREATE TABLE Payers (
    Payer_ID VARCHAR(10) PRIMARY KEY,
    Payer_Name VARCHAR(50)
);

-------------------------
-- 2. SAMPLE DATA
-------------------------

INSERT INTO Payers (Payer_ID, Payer_Name) VALUES
('P01', 'Aetna'),
('P02', 'Cigna'),
('P03', 'United Healthcare'),
('P04', 'Blue Cross');

INSERT INTO DenialReasons (Denial_Code, Category, Reason_Description) VALUES
('CO16', 'Coding', 'Diagnosis code missing'),
('CO97', 'Eligibility', 'Invalid insurance coverage'),
('CO50', 'Documentation', 'Missing clinical documentation'),
('CO45', 'Other', 'Charge exceeds allowed amount'),
('CO29', 'Other', 'Past timely filing limit');

INSERT INTO Claims (Claim_ID, Patient_ID, Department, Payer_ID, Claim_Date, Claim_Amount, Claim_Status) VALUES
('C001', 'P001', 'Radiology',   'P01', '2025-01-01', 1200, 'Denied'),
('C002', 'P002', 'Surgery',     'P02', '2025-01-01', 3500, 'Paid'),
('C003', 'P003', 'Orthopedics', 'P03', '2025-01-02', 2400, 'Denied'),
('C004', 'P004', 'Emergency',   'P02', '2025-01-02', 1800, 'Denied'),
('C005', 'P005', 'Surgery',     'P04', '2025-01-03', 4200, 'Paid'),
('C006', 'P006', 'Cardiology',  'P01', '2025-01-03', 5000, 'Paid'),
('C007', 'P007', 'Radiology',   'P03', '2025-01-03', 900,  'Denied'),
('C008', 'P008', 'Surgery',     'P04', '2025-01-04', 4400, 'Paid'),
('C009', 'P009', 'Emergency',   'P04', '2025-01-04', 1500, 'Denied'),
('C010','P010', 'Orthopedics',  'P02', '2025-01-04', 2700, 'Paid');

INSERT INTO Denials (Denial_ID, Claim_ID, Denial_Date, Denial_Code, Denial_Amount) VALUES
('D001', 'C001', '2025-01-03', 'CO16', 1200),
('D002', 'C003', '2025-01-05', 'CO97', 2400),
('D003', 'C004', '2025-01-04', 'CO50', 1800),
('D004', 'C007', '2025-01-05', 'CO16', 900),
('D005', 'C009', '2025-01-06', 'CO97', 1500);

-------------------------
-- 3. ANALYSIS QUERIES
-------------------------

-- 3.1 Overall denial rate
SELECT
    COUNT(*) AS Total_Claims,
    SUM(CASE WHEN Claim_Status = 'Denied' THEN 1 ELSE 0 END) AS Denied_Claims,
    1.0 * SUM(CASE WHEN Claim_Status = 'Denied' THEN 1 ELSE 0 END) / COUNT(*) AS Denial_Rate
FROM Claims;

-- 3.2 Denied amount by category
SELECT
    dr.Category,
    SUM(d.Denial_Amount) AS Total_Denied_Amount,
    COUNT(*) AS Total_Denials
FROM Denials d
JOIN DenialReasons dr ON d.Denial_Code = dr.Denial_Code
GROUP BY dr.Category
ORDER BY Total_Denied_Amount DESC;

-- 3.3 Preventable (Coding + Eligibility) vs total denied amount
WITH Total AS (
    SELECT SUM(Denial_Amount) AS Total_Denied
    FROM Denials
),
Preventable AS (
    SELECT SUM(d.Denial_Amount) AS Preventable_Denied
    FROM Denials d
    JOIN DenialReasons dr ON d.Denial_Code = dr.Denial_Code
    WHERE dr.Category IN ('Coding', 'Eligibility')
)
SELECT
    p.Preventable_Denied,
    t.Total_Denied,
    1.0 * p.Preventable_Denied / t.Total_Denied AS Preventable_Denied_Percent
FROM Preventable p
CROSS JOIN Total t;

-- 3.4 Denied amount by payer and category
SELECT
    p.Payer_Name,
    dr.Category,
    SUM(d.Denial_Amount) AS Total_Denied_Amount
FROM Denials d
JOIN Claims c ON d.Claim_ID = c.Claim_ID
JOIN Payers p ON c.Payer_ID = p.Payer_ID
JOIN DenialReasons dr ON d.Denial_Code = dr.Denial_Code
GROUP BY p.Payer_Name, dr.Category
ORDER BY p.Payer_Name, Total_Denied_Amount DESC;

-- 3.5 Flattened view for BI tools
SELECT
    c.Claim_ID,
    c.Claim_Date,
    c.Department,
    p.Payer_Name,
    c.Claim_Amount,
    c.Claim_Status,
    dr.Category AS Denial_Category,
    d.Denial_Amount
FROM Claims c
LEFT JOIN Denials d ON c.Claim_ID = d.Claim_ID
LEFT JOIN DenialReasons dr ON d.Denial_Code = dr.Denial_Code
LEFT JOIN Payers p ON c.Payer_ID = p.Payer_ID;
