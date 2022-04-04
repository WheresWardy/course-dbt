{% set event_types_sql_statement %}
    SELECT
        DISTINCT quote_literal(event_type) AS event_type,
        event_type AS column_name
    FROM {{ ref('stg_events') }}
{% endset %}

{%- set event_types = dbt_utils.get_query_results_as_dict(event_types_sql_statement) -%}

SELECT
    product_id
    {% for event_type in event_types['event_type'] %}
        , COUNT(DISTINCT CASE WHEN event_type = {{ event_type }} THEN session_id END) AS {{ event_types['column_name'][loop.index0] }}
    {% endfor %}
FROM {{ ref('stg_events') }}
GROUP BY product_id
