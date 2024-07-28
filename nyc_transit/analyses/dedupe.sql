-- insert_timestamp columns used to sort events
select *
from {{ ref('events') }}
qualify row_number()
        over (partition by event_id, event_type, user_id
              order by insert_timestamp desc)
=1;