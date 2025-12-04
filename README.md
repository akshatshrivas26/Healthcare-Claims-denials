# Medical Claim Denial Analysis & Optimization — Power BI + SQL

## Project Summary
Healthcare providers experience major revenue loss due to preventable claim denials. This project analyzes denial drivers and provides data-backed recommendations to reduce rework and improve clean claim rates.

Role: Business Analyst  
Timeline: 2 weeks  
Primary Result: Insights targeting a 20–25% reduction in preventable denials

---

## Business Objectives
- Identify top denial contributors by payer, department, and reason category
- Separate preventable denials (Coding, Eligibility) from unavoidable causes
- Enable operational teams with drilldown visibility to act quickly
- Support continuous performance monitoring through trend analysis

---

## Tools and Skills Used
- SQL: Data modeling and KPI calculations
- Power BI: Analytics dashboard and drilldowns
- Draw.io: AS-IS and TO-BE workflows
- GitHub: Documentation and version control

---

## Dashboard Overview

**Page 1: Executive Summary**
- Key metrics (Denial Rate %, Preventable Denials %)
- Denied amounts by category and payer
- Trend analysis for performance monitoring  
Screenshot: `images/overview_dashboard.png`

**Page 2: Denial Deep Dive**
- Visual root-cause analysis by payer and reason
- Drilldown to claim-level for operational action  
Screenshot: `images/denial_deep_dive.png`

---

## Data Model Overview
A star schema structure supports efficient slicing of denial analytics:

- Fact: Claims, Denials  
- Dimensions: Payers, Denial Reasons  

SQL script used for model creation and measures:  
`sql/claim_denial_model.sql`

---

## Business Value Delivered
- Early eligibility validation prevents upfront denials
- Coding accuracy increases through specific insights
- Weekly feedback loop reduces recurring issues

Targeted improvement: 20–25% reduction in preventable denial amount

---

## Project Documentation

| Deliverable | File/Link |
|------------|-----------|
| Business Requirements Document (BRD) | documents/BRD_Medical_Claim_Denial.pdf |
| Functional Requirements Document (FRD) | documents/FRD_Medical_Claim_Denial.pdf |
| AS-IS Workflow | documents/AS-IS_Claim_Denial_Workflow.png |
| TO-BE Workflow | documents/TO-BE_Claim_Denial_Workflow.png |
| User Stories | documents/UserStories.md |
| Acceptance Criteria | documents/AcceptanceCriteria.md |
| Root Cause Analysis & Recommendations | documents/RCA_Recommendations.md |
| Prioritization Matrix | documents/PrioritizationMatrix.md |
| UAT Checklist | documents/UAT_Checklist.md |
| Implementation Roadmap | documents/ImplementationRoadmap.md |
| Power BI Dashboard (.pbix) | pbix/Medical_Claim_Denial_Analysis.pbix |

---

## Future Enhancements
- Automated payer feedback integration
- Automated alerts for denial spikes
- Scheduled data refresh and monitoring

---

## Author
Akshat Shrivas  
Business Analyst — Power BI | SQL | Process Improvement
