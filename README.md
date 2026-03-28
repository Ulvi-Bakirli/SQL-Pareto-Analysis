AZE:
🏛️ Strategic Data Architecture: Comparative SQL Solutions (BigQuery)
🎯 Layihənin Missiyası
Bu layihə, irihəcmli data (Big Data) mühitində biznes problemlərini həll etmək üçün Google BigQuery üzərində qurulmuş strateji SQL arxitekturasını nümayiş etdirir. Əsas hədəf eyni analitik problemi 3 fərqli metodla həll edərək, Query Optimization və Readability (Oxunaqlıq) arasındakı balansı tapmaqdır.

🏗️ Sistem Arxitekturası (Repository Structure)
Layihə modulyar şəkildə 4 əsas fayla bölünüb:

01_database_setup_and_views.sql: Məlumat modelinin "skeleti". Təkrar istifadə oluna bilən (reusable) 4 əsas View-un yaradılması. Bu, sistemin stabilliyini təmin edən təməl qatıdır.

02_solution_cte.sql: Müasir SQL standartı. Common Table Expressions (CTE) vasitəsilə mürəkkəb məntiqin addım-addım, oxunaqlı şəkildə qurulması.

03_solution_subquery.sql: Klassik yanaşma. Performans müqayisəsi və "Legacy" sistemlərlə uyğunluq (compatibility) üçün hazırlanıb.

dataset.csv: Analiz üçün istifadə olunan, şirkət sirri daşımayan "dummy data" nümunəsi.

🛠️ Technical Features
Stability-First: Bütün sorğular məlumatın bütövlüyünü (Data Integrity) qorumaq üçün validasiya ssenariləri ilə təchiz olunub.

Modular Logic: View-lar vasitəsilə mürəkkəb "Joined" datalar kiçik, idarəolunan vahidlərə bölünüb.

Cloud-Native Optimization: BigQuery-nin "Columnar Storage" üstünlüklərindən istifadə edən Window Functions (RANK, SUM OVER) tətbiqi.

🔍 Analitik Fokus Nöqtələri
Pareto (80/20) Analizi: Biznesin ən effektiv 20%-lik seqmentinin SQL vasitəsilə avtomatik təyini.

🦾 Texnoloji Stek
Platform: Google Cloud Platform (GCP)

Engine: BigQuery Standard SQL

Concepts: CTEs, Window Functions, View Orchestration, DDL/DML.





ENG:
🏛️ Strategic Data Architecture: Comparative SQL Solutions (BigQuery)
🎯 Project Mission
This repository demonstrates a strategic SQL architecture developed on Google BigQuery to solve complex business analytical problems within a Big Data environment. The primary objective is to showcase three distinct architectural approaches (Views, CTEs, and Subqueries) to achieve the optimal balance between Query Optimization and Readability.

🏗️ System Architecture (Repository Structure)
The project is modularly organized into 4 core files to demonstrate professional data handling:

01_database_setup_and_views.sql: The "Skeleton" of the data model. Creation of 4 reusable core Views. This layer ensures system stability and serves as a modular foundation for reporting.

02_solution_cte.sql: The modern SQL standard. Utilizing Common Table Expressions (CTE) to build complex logic in a step-by-step, highly readable format.

03_solution_subquery.sql: The legacy approach. Provided for performance benchmarking and to ensure compatibility with older SQL engines.

dataset.csv: A sample "dummy dataset" used for the analysis, ensuring no sensitive corporate data is exposed while maintaining structural integrity.

🛠️ Technical Features
Stability-First: All queries include validation scenarios to ensure Data Integrity across all joins and aggregations.

Modular Logic: Complex joined datasets are broken down into small, manageable units via Views to prevent "Spaghetti Code."

Cloud-Native Optimization: Implementation of Window Functions (RANK, SUM OVER) specifically optimized for BigQuery’s columnar storage architecture.

🔍 Analytical Focus Areas
Pareto (80/20) Analysis: Automated identification of the top 20% business drivers responsible for 80% of the results.

🦾 Technology Stack
Platform: Google Cloud Platform (GCP)

Engine: BigQuery Standard SQL

Concepts: CTEs, Window Functions, View Orchestration, DDL/DML Operations.
