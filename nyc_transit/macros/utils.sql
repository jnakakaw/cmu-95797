{% macro flag_to_bool(column_name, true_value="Y", false_value="N", null_value=" ") -%}
-- convert to BOOL using the specified values
-- for unknown values, raises an error
(case
    when {{column_name}} = '{{true_value}}' then true
    when {{column_name}} = '{{false_value}}' then false
    when {{column_name}} = '{{null_value}}' then null
    when {{column_name}} is null then null
    else null -- treat any other value as null
end)::bool
{%- endmacro %}

{% macro clean_base_ids(column_name) -%}
-- clean up the base ids to be properly linked as foreign keys
-- assuming all ids should start with capital letter B
-- id lenght should be 6 digits
-- capital o's are replced with zeros, assuming manual input errors 
case
    when len(left(trim(upper({{column_name}})), 6)) <> 6 then null
    when left(trim(upper({{column_name}})), 1) <> 'B' then null 
    else replace(left(trim(upper({{column_name}})), 6), 'O', '0')
end
{%- endmacro %}