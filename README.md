# 📊 Superstore Sales & Profitability Analysis

An end-to-end data analysis project on the Superstore retail dataset — covering SQL exploration, Python (Pandas) EDA, a formula-driven Excel analysis workbook, and an interactive 4-page Power BI dashboard — built to uncover where the business is making money, where it's losing money, and what to do about it.

![Dashboard Preview](assets/dashboard_preview.gif)

[![Watch the full demo on YouTube](assets/executive_overview.png)](https://youtu.be/XjK6l6563ls)
▶️ **[Watch the full walkthrough on YouTube](https://youtu.be/XjK6l6563ls)**

---

## 🧰 Tech Stack

| Layer | Tool |
|---|---|
| Data storage & querying | MySQL |
| Data cleaning & EDA | Python (Pandas, Matplotlib) — Jupyter Notebook |
| Formula-driven analysis & KPI summary | Excel (SUMIF/SUMIFS/COUNTIF/SUMPRODUCT pivot-style tables) |
| Data source | Excel (raw Superstore Orders, People, Returns) |
| Visualization / Reporting | Power BI (4-page interactive dashboard) |

**Project files:**
- `Order2.sql` — SQL exploration & business queries (KPIs, YoY growth, RFM-style customer analysis, window functions)
- `order.ipynb` — Python cleaning + EDA notebook (10,194 raw orders → cleaned dataset)
- `Superstore_Sales_Analysis_Project.xlsx` — Raw source data (Orders, People, Returns) **plus a fully formula-driven Analysis sheet** (Category/Region/Ship Mode/Segment performance, Top & Bottom 10 products, a Returns Overview built with `SUMIF`, `SUMPRODUCT`, and `COUNTA`) and an Executive Dashboard sheet (live KPI cards for Total Sales, Profit, Margin, Orders, Return Rate, and Average Order Value, all formula-linked back to the raw data)
- `Superstore_Analysis.pbix` — Final 4-page Power BI dashboard
- `Superstore_Cleaned.csv` — Cleaned, analysis-ready dataset (notebook output)

---

## 1. Why I built it

I wanted a project that went through a **real analytics workflow end-to-end** — not just opening a clean CSV and making charts, but starting from a messy raw export, cleaning it with SQL and Python, running actual exploratory analysis to find patterns, and then packaging the findings into a decision-ready BI dashboard. This project let me practice all three layers a data analyst actually uses on the job: **SQL for querying, Python for EDA/cleaning, and Power BI for stakeholder-facing reporting.**

## 2. What was the business problem?

The Superstore is a retail business selling Technology, Furniture, and Office Supplies across four US regions. On the surface, the business looks healthy — **$2.33M in total sales**. But sales volume alone doesn't tell you whether the business is actually *profitable*, or which parts of it are quietly bleeding money. The core problem this project investigates:

> **"We're generating millions in sales — but where is our profit actually coming from, and where is it being destroyed?"**

Specifically: which categories/regions/products are profit drivers vs. dead weight, whether discounting is helping or hurting margins, and which customers/products matter most.

## 3. Who it's for

- **Sales & Regional Managers** — to see which regions and reps are under/over-performing.
- **Category/Product Managers** — to identify which products to promote, discontinue, or re-price.
- **Finance/Pricing teams** — to understand the real cost of discounting on profit margin.
- **Executives** — for a single-glance health check (Executive Overview page) without digging into raw data.

## 4. What I analyzed

Using SQL (MySQL) and Python (Pandas), I cleaned **10,194 raw order line items** (removing currency symbols, fixing data types, standardizing column names) down to a validated analysis-ready dataset, then examined:

- **Overall KPIs**: total sales, profit, quantity, orders, customers, profit margin
- **Category & Sub-Category performance**: sales, profit, and margin by product hierarchy
- **Regional performance**: sales/profit by Region, State, and City
- **Customer behavior**: top customers by sales vs. profit, repeat vs. one-time buyers, customer contribution %
- **Product performance**: best-sellers, most profitable, and loss-making products
- **Discount impact**: profit and margin bucketed by discount band (0%, 1–20%, 21–40%, 40%+), and the discount-vs-profit correlation
- **Time trends**: monthly/yearly sales & profit trends, year-over-year growth, seasonality
- **Shipping**: delivery time by ship mode and its relationship to sales
- **Returns impact**: order-level and line-level return rates, and how much sales/profit value was lost to returns — built entirely with Excel formulas (`SUMIF`, `SUMPRODUCT`, `COUNTA`) referencing the raw Orders and Returns sheets, with zero manual/hardcoded numbers

### Excel deliverable
Beyond using Excel as a raw data source, I built a **formula-driven Analysis workbook** as a standalone deliverable, including:
- Pivot-style summary tables (Category, Region, Ship Mode, Segment performance) computed live with `SUMIF`/`SUMIFS` against the 10,194-row Orders sheet
- Top 10 and Bottom 10 product tables by Sales and Profit
- A full **Returns Overview** (total vs. returned orders, order-level and line-level return rate, returned sales/profit value, and % of total sales returned) using `SUMPRODUCT` to cross-reference the Orders and Returns sheets
- An **Executive Dashboard sheet** with live KPI cards (Total Sales, Profit, Margin, Orders, Return Rate, Avg Order Value) that update automatically if the underlying Orders data changes — no copy-pasted values anywhere

## 5. What insights I found

**Overall business health**
- Total Sales: **$2,326,534** | Total Profit: **$292,297** | Overall Profit Margin: **12.56%**
- 5,111 orders across 804 customers, moving 38,654 units.

**Category performance**
- **Technology** is the strongest category — $839.9K sales at a **17.4% margin**.
- **Office Supplies** is close behind on margin (17.2%) despite lower per-unit sales, driven by high order volume.
- **Furniture** is the weak link — $754.7K in sales but only a **2.6% margin**, dragged down heavily by Tables and Bookcases.

**Regional performance**
- **West** leads on both sales ($739.8K) and profit ($110.8K, 15.0% margin).
- **Central** region is the weakest — $503.2K in sales but only **7.9% margin**, the lowest of all four regions.

**Product-level**
- The **Canon imageCLASS 2200 Advanced Copier** is the single best product — $61.6K in sales and **$25.2K profit**, the top performer on both metrics.
- The **Cubify CubeX 3D Printer (Double Head)** is the single worst product, losing **-$8,880**, followed closely by a second Cubify CubeX model (-$3,840) — 3D printers are a systemic loss-maker, not a one-off.

**Customers**
- **Sean Miller** generates the most raw sales ($25K) but is actually **unprofitable overall (-$1,981)** — a high-revenue, negative-margin customer.
- **Tamara Chand** is the most valuable customer by profit ($8,981) — sales leaders and profit leaders are not the same people.

**Discounting — the biggest red flag**
- **0% discount**: $1.105M in sales at a healthy **29.56% margin**.
- **1–20% discount**: $856K in sales, margin thins to **11.86%** but stays solidly profitable — moderate discounting is safe.
- **21–40% discount**: $235K in sales, margin **flips negative (-15.29%)** — this is the tipping point.
- **>40% discount**: $129K in sales, margin collapses to **-77.37%** — severely value-destroying.
- Sub-categories most damaged by discounting past this tipping point: **Binders (-106.5% margin)**, **Machines (-38.5%)**, **Tables (-34.0%)**, **Appliances (-255% margin)**.
- The takeaway: **discounting up to ~20% is fine, but anything beyond 20% reliably destroys profit** and should require managerial approval.

**Loss-making sub-categories overall**
- **Tables** (-$17.8K), **Bookcases** (-$3.6K), and **Supplies** (-$1.2K) are net-negative even before isolating discount effects.

**Returns**
- **5.79%** of all orders (296 of 5,111) had at least one item returned, and **7.85%** of individual order lines (800 of 10,194) were returned.
- Returns account for **$180,504 in sales** and **$23,232 in profit** — that's **7.76% of total sales value** effectively reversed after the fact, a meaningful drag on the top-line numbers that isn't visible in the headline $2.33M sales figure.

## 6. Business recommendations

1. **Cap discretionary discounts at 20%.** Profit margin holds up fine through the 1–20% band (11.86% margin) but flips negative beyond that (-15.29% at 21–40%, -77.37% above 40%). Require manager approval for any discount over 20%, especially on Binders, Machines, Tables, and Appliances — the sub-categories hit hardest by heavy discounting.
2. **Re-evaluate the Furniture category**, especially Tables and Bookcases — either renegotiate supplier costs, raise prices, or discontinue the worst SKUs (e.g., the two Cubify CubeX 3D printers).
3. **Investigate Central region's margin gap.** It sells nearly as much as South but converts far less of it to profit — audit shipping costs, discount practices, or product mix specific to Central.
4. **Don't equate "top customer by sales" with "best customer."** Build a profit-based (not just revenue-based) view into account management — Sean Miller-type accounts need pricing renegotiation, not more volume.
5. **Double down on Technology and Office Supplies**, and specifically promote proven winners like the Canon imageCLASS 2200 copier line, which has the best sales-to-profit ratio in the catalog.
6. **Investigate the return rate.** Nearly 8% of order lines are returned, reversing over $180K in sales and $23K in profit — worth breaking out by category/product to see if returns concentrate in specific SKUs (e.g., the same loss-making Furniture and 3D-printer products already flagged above) versus being evenly spread.

## 7. What decision it helps someone make

This dashboard directly supports decisions like:
- *"Should we approve a 30% discount on this Binders order?"* → No — 30% falls in the 21–40% band, where overall margin is already negative (-15.29%), and Binders specifically loses over 100% margin at that level.
- *"Which region should get more marketing budget next quarter?"* → West, based on proven profit efficiency; Central needs investigation before investment.
- *"Should we keep selling the Cubify CubeX 3D printers?"* → Data says no — both models are consistently loss-making.
- *"Which customers deserve loyalty/retention perks?"* → Profit-ranked customers like Tamara Chand and Raymond Buch, not necessarily the highest-revenue names.
- *"Is our discounting strategy working?"* → No — discounting past 0% turns aggregate margin negative; policy needs revisiting.

---

## 📁 Dashboard Pages

1. **Executive Overview** — KPIs, monthly sales trend, category/region/sub-category snapshot
2. **Sales & Profit Analysis** — Time trends, category/region profit share, sub-category performance table
3. **Discount Analysis** — Discount band impact on sales, profit, margin, and a discount-vs-profit scatter/trendline
4. **Customer & Product Analysis** — Top/bottom customers and products by sales and profit, repeat customer rate

All 4 pages share synced slicers (Order Month, Region, Category, Segment, Discount Band) and use custom navigation buttons instead of default page tabs.

---

## 🚀 How to use

1. Open `Superstore_Analysis.pbix` in Power BI Desktop for the interactive dashboard.
2. Explore each page via the navigation bar in the header (Home / Sales & Profit / Discount / Customer & Product).
3. Use the slicers to filter by date, region, category, segment, or discount band — all visuals update interactively.
4. Open `Superstore_Sales_Analysis_Project.xlsx` and check the **Analysis** and **Dashboard** sheets to see the same KPIs and breakdowns computed live with Excel formulas (`SUMIF`, `SUMPRODUCT`, `COUNTA`) — a good side-by-side comparison of doing this analysis in Excel vs. Power BI.
5. For the underlying data pipeline, see `order.ipynb` (Python cleaning/EDA) and `Order2.sql` (SQL business queries).
