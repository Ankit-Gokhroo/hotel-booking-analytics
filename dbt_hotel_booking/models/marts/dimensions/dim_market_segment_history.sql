{{ config(
    materialized='table',
    schema='gold'
) }}

select
    market_segment,
    deposit_type,
    total_bookings,
    avg_lead_time,
    min_lead_time,
    max_lead_time,
    avg_adr,

    dbt_valid_from as start_date,
    dbt_valid_to as end_date,

    case
        when dbt_valid_to is null then true
        else false
    end as is_current

from {{ ref('snap_market_segment_analysis') }}