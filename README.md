# Medical Claim Denial Analysis – Business & Analytics Case Study

End-to-end Business Analysis + Power BI project to reduce medical claim denials and revenue leakage. Includes BRD, FRD, process workflows, and an interactive denial analysis dashboard.

## Business Goal

Reduce preventable claim denials (especially Coding & Eligibility) to:
- Recover lost revenue
- Cut rework and operational effort
- Improve payer relationships and cashflow predictability

## Deliverables

- **BRD** – Business problem, scope, stakeholders, KPIs
- **FRD** – Data model, business rules, dashboard requirements
- **AS-IS & TO-BE workflows** – Current vs improved claim submission & denial handling
- **Power BI Dashboard** – Denial trends by payer, department, and reason

## Data Model (Star Schema)

- `Claims` – Claim-level facts (amount, status, department, payer, date)
- `Denials` – Denial records linked to claims
- `DenialReasons` – Category of each denial (Coding, Eligibility, Documentation, Other)
- `Payers` – Payer dimension

## Key Metrics

- Denial Rate %
- Denied Amount %
- Preventable Denied Amount (Coding + Eligibility)
- Preventable Denied %

## Sample Insights

- High overall denial rate in sample data
- ~75–80% of denied amount is from **Coding + Eligibility** (preventable)
- Specific payers & departments concentrate most preventable denials

## Business Impact (Targeted)

- 20–25% reduction in preventable denials via:
  - Coding audit & training
  - Better pre-submission eligibility checks
  - Payer-rule alignment
 
## SQL Work

SQL scripts used for:
- Creating star-schema base tables
- Loading sample data
- Joining Claims, Denials, Payers & Categories
- Generating insights for dashboard

→ See: `/sql/claim_denial_model.sql`

## Project Documentation

- [BRD – Business Requirements Document](documents/BRD_Medical_Claim_Denial.pdf)
- [FRD – Functional Requirements Document](documents/FRD_Medical_Claim_Denial.pdf)
- [Executive Overview Dashboard](images/overview_dashboard.png)
- [Denial Deep Dive Dashboard](images/denial_deep_dive.png)


---
Project by **Akshat Shrivas** – Business Analyst / RCM / Ops.
