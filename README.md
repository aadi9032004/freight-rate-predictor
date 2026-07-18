# Freight Rate Predictor

End-to-end freight cost prediction pipeline built on the Olist Brazilian e-commerce dataset using PostgreSQL, Python (scikit-learn), and Power BI.

## The Story

I knew Python and Power BI, but not SQL and most SCM/analytics job descriptions list it as a baseline requirement. Instead of doing another course, I learned SQL by building this project from scratch over a few days, applying it directly to real data rather than isolated exercises.

## Tech Stack

- **PostgreSQL** : data storage, relational schema design, SQL queries (joins, aggregates, CTEs)
- **Python (pandas, scikit-learn)** : data cleaning, feature engineering, model training
- **Power BI** : dashboard visualization, including a live connection to PostgreSQL

## Pipeline

1. Loaded ~110K order records from the Olist dataset into 4 normalized PostgreSQL tables (`customers`, `orders`, `order_items`, `products`)
2. Wrote SQL queries to explore and join the data — including multi-table joins, `GROUP BY` aggregates, and CTEs — to analyze freight cost patterns by state and product category
3. Exported a cleaned, joined dataset from SQL into Python for modeling
4. Trained a Random Forest Regressor to predict freight cost using product weight, dimensions, price, and customer location
5. Built a Power BI dashboard with predicted vs actual freight cost, feature importance, and freight cost by state — the last of which pulls live from PostgreSQL

## Key Findings

- Customers in São Paulo pay an average freight cost of R$15, while customers in remote states like Roraima pay nearly R$43 : almost triple, based on location alone
- The Random Forest model achieved an **R² of 0.71**, meaning it explains 71% of the variance in freight cost
- **Product weight** was the single strongest predictor, accounting for ~44% of the model's decision-making, followed by price (~15%) and customer state (~8%)

## Dashboard

![Freight Rate Predictor Dashboard](images/dashboard.png)

## Repository Structure

```
freight-rate-predictor/
├── sql/                      # Key SQL queries used for analysis
├── notebooks/                # Python notebook (data cleaning, modeling)
├── powerbi/                  # Power BI dashboard file
└── images/                   # Dashboard screenshots
```
