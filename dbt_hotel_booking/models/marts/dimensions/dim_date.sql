{{
    config(
        materialized='table'
    )
}}

with date_bounds as (
    select
        min(cast(reservation_status_date as date)) as start_date,
        max(cast(reservation_status_date as date)) as end_date
    from {{ ref('stg_hotel_bookings') }}
),

date_spine as (
    select
        explode(sequence(start_date, end_date, interval 1 day)) as date_day
    from date_bounds
)

select
    date_day,
    year(date_day) as year_number,
    quarter(date_day) as quarter_number,
    month(date_day) as month_number,
    date_format(date_day, 'MMMM') as month_name,
    dayofmonth(date_day) as day_of_month,
    dayofweek(date_day) as day_of_week,
    date_format(date_day, 'EEEE') as day_name,
    case
        when dayofweek(date_day) in (1, 7) then true
        else false
    end as is_weekend
from date_spine
order by date_day