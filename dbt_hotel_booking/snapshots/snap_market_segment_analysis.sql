
{% snapshot snap_market_segment_analysis %}

{{
    config(
        target_schema='gold',
        unique_key="concat(market_segment, '|', deposit_type)",
        strategy='check',
        check_cols=[
            'total_bookings',
            'avg_lead_time',
            'min_lead_time',
            'max_lead_time',
            'avg_adr'
        ],
        hard_deletes='ignore'
    )
}}

select
    market_segment,
    deposit_type,
    total_bookings,
    avg_lead_time,
    min_lead_time,
    max_lead_time,
    avg_adr
from {{ ref('int_market_segment_analysis') }}

{% endsnapshot %}
