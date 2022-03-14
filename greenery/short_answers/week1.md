# Short answers for week 1

### 1. How many users do we have?

130

Query:
```sql
SELECT COUNT(*)
FROM dbt_matt_w.stg_users;
```

### 2. On average, how many orders do we receive per hour?

7.52

Query:
```sql
WITH orders_per_hour AS (
    SELECT
        COUNT(DISTINCT order_id) AS order_count,
        DATE_TRUNC('hour', created_at) AS order_hour
    FROM dbt_matt_w.stg_orders
    GROUP BY order_hour
)

SELECT AVG(order_count)
FROM orders_per_hour;
```

### 3. On average, how long does an order take from being placed to being delivered?

3 days, 21 hours and 24 minutes

Query:
```sql
SELECT AVG(delivered_at - created_at) AS avg_order_delivery
FROM dbt_matt_w.stg_orders
WHERE status = 'delivered'
    AND delivered_at IS NOT NULL;
```

### 4. How many users have only made one purchase? Two purchases? Three+ purchases?

| order_group | count |
| ----------- | ----- |
| 1           | 25    |
| 2           | 28    |
| 3+          | 71    |

Query:
```sql
WITH user_orders AS (
    SELECT
        user_id,
        COUNT(order_id) AS orders
    FROM dbt_matt_w.stg_orders
    GROUP BY user_id
)

SELECT
    CASE
        WHEN orders >= 3 THEN '3+'
        ELSE orders::varchar END
    AS order_group,
    COUNT(user_id)
FROM user_orders
GROUP BY order_group
ORDER BY order_group;
```

### 5. On average, how many unique sessions do we have per hour?

16.33

Query:
```sql
WITH sessions_per_hour AS (
    SELECT
        COUNT(DISTINCT session_id) AS session_count,
        DATE_TRUNC('hour', created_at) AS session_hour
    FROM dbt_matt_w.stg_events
    GROUP BY session_hour
)

SELECT AVG(session_count)
FROM sessions_per_hour;
```
