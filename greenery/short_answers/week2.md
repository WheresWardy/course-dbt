# Short answers for week 2

### 1. What is our user repeat rate?

_(Repeat Rate = Users who purchased 2 or more times / users who purchased)_

79.84%

Query:
```sql
WITH user_orders AS (
    SELECT
        user_id,
        COUNT(order_id) AS orders
    FROM dbt_matt_w.stg_orders
    GROUP BY user_id
)

SELECT (
    COUNT(
        CASE
            WHEN orders > 1 THEN 1
            ELSE NULL END
    )::numeric / COUNT(user_id)) * 100
FROM user_orders;
```

### 2. What are good indicators of a user who will likely purchase again?

We could look at the other data we have, for example the events data, to gauge the behaviour of users who show repeat purchase metrics from the query above as to the kind of behaviour they exhibit in the events table, and possibly use this to drive product decisions to improve engagement. We could also look at the promos table to see if promotions drive certain purchase behaviour and again use this in either a product or marketing way to drive user engagement.

_What about indicators of users who are likely NOT to purchase again?_

We could use the same event sources as mentioned above in corroboration with the list of users who only show a single purchase to see where their behaviour differs from repeat purchase users, especially if their purchase was a significant amount of time in the past and they show site activity since then without having made a repeat purchase.

_If you had more data, what features would you want to look into to answer this question?_

It would be good to get data from outside the key metrics from the organisation, like conversion and marketing data that may help to determine why users ended up on the site or particular products in the first place.

### 3. Explain the marts models you added. Why did you organize the models in the way you did?

I added the following marts models:

**core:**
* dim_users.sql: To show a combined view of user address information
* fact_orders.sql: To show a combined view of orders and the line items attached to them

**marketing:**
* fact_user_orders.sql: To show users and any orders they may have made

**product:**
* fact_order_promos.sql: To show any orders that might have used promotions
* fact_page_views.sql: To show site event-level data and the related users, orders and products to those events
