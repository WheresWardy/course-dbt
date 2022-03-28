# Short answers for week 3

## PART 1

### 1. What is our overall conversion rate?

_(Conversion rate is defined as the # of unique sessions with a purchase event / total number of unique sessions)_

62.46%

Query:
```sql
WITH purchase_sessions AS (
    SELECT COUNT(DISTINCT session_id)
    AS sessions
    FROM dbt_matt_w.stg_events
    WHERE event_type = 'checkout'
),

total_sessions AS (
    SELECT COUNT(DISTINCT session_id)
    AS sessions
    FROM dbt_matt_w.stg_events
)

SELECT
    ROUND(((purchase_sessions.sessions::numeric / total_sessions.sessions::numeric) * 100), 2) AS conversion_rate
    FROM purchase_sessions, total_sessions;
```

### 2. What is our conversion rate by product?

_(Conversion rate by product is defined as the # of unique sessions with a purchase event of that product / total number of unique sessions that viewed that product)_

|    product_name     | order_sessions | product_sessions | conversion_rate |
| ------------------- | -------------- | ---------------- | --------------- |
| Alocasia Polly      |             21 |               51 |           41.18 |
| Aloe Vera           |             32 |               65 |           49.23 |
| Angel Wings Begonia |             24 |               61 |           39.34 |
| Arrow Head          |             35 |               63 |           55.56 |
| Bamboo              |             36 |               67 |           53.73 |
| Bird of Paradise    |             27 |               60 |           45.00 |
| Birds Nest Fern     |             33 |               78 |           42.31 |
| Boston Fern         |             26 |               63 |           41.27 |
| Cactus              |             30 |               55 |           54.55 |
| Calathea Makoyana   |             27 |               53 |           50.94 |
| Devil's Ivy         |             22 |               45 |           48.89 |
| Dragon Tree         |             29 |               62 |           46.77 |
| Ficus               |             29 |               68 |           42.65 |
| Fiddle Leaf Fig     |             28 |               56 |           50.00 |
| Jade Plant          |             22 |               46 |           47.83 |
| Majesty Palm        |             33 |               67 |           49.25 |
| Money Tree          |             26 |               56 |           46.43 |
| Monstera            |             25 |               49 |           51.02 |
| Orchid              |             34 |               75 |           45.33 |
| Peace Lily          |             27 |               66 |           40.91 |
| Philodendron        |             30 |               62 |           48.39 |
| Pilea Peperomioides |             28 |               59 |           47.46 |
| Pink Anthurium      |             31 |               74 |           41.89 |
| Ponytail Palm       |             28 |               70 |           40.00 |
| Pothos              |             21 |               61 |           34.43 |
| Rubber Plant        |             28 |               54 |           51.85 |
| Snake Plant         |             29 |               73 |           39.73 |
| Spider Plant        |             28 |               59 |           47.46 |
| String of pearls    |             39 |               64 |           60.94 |
| ZZ Plant            |             34 |               63 |           53.97 |

Query:
```sql
WITH order_sessions AS (
    SELECT COUNT(DISTINCT session_id) AS sessions,
    fact_orders.product_id AS product_id
    FROM dbt_matt_w.fact_orders
    INNER JOIN dbt_matt_w.stg_events ON stg_events.order_id = fact_orders.order_id
    GROUP BY fact_orders.product_id
),

product_sessions AS (
    SELECT COUNT(DISTINCT session_id) AS sessions,
    product_id AS product_id
    FROM dbt_matt_w.stg_events
    GROUP BY product_id
)

SELECT
    stg_products.name AS product_name,
    order_sessions.sessions AS order_sessions,
    product_sessions.sessions AS product_sessions,
    ROUND(((order_sessions.sessions::numeric / product_sessions.sessions::numeric) * 100), 2) AS conversion_rate
FROM order_sessions
INNER JOIN product_sessions ON product_sessions.product_id = order_sessions.product_id
INNER JOIN dbt_matt_w.stg_products ON stg_products.product_id = order_sessions.product_id
ORDER BY product_name;
```

## PART 2

### Create a macro to simplify part of a model(s)

I created two macros in the `macros` directory called `grant_select.sql` and `grant_usage.sql` that I could use to simplify adding the necessary grants in part 3.

## PART 3

### Add a post hook to your project

I've added a post-hook to my `dbt_project.yml` file that uses the `grant_select` macro from above to grant SELECT to the "reporting" role to the models that are enumerated by the hook

### Add an on-run-end hook to your project

I've also added an on-run-end hook to the same file that uses the `grant_usage` macro from above to grant USAGE to the "reporting" role to my dbt schema

## PART 4

I installed the `dbt_utils` package to my project to use the `unique_combination_of_columns` test in my staging schema configuration to test uniqueness across multiple column values.
