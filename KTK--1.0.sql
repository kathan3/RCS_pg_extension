CREATE OR REPLACE FUNCTION KTK(
    table1_name text, 
    table2_name text,
    join_column1 text,
    join_column2 text,
    table1_columns text[],
    table2_columns text[]
)
RETURNS SETOF RECORD
LANGUAGE plpgsql
COST 0.000000000000000000000000000001
AS $$
DECLARE
    select_clause text;
BEGIN
    -- Generate the SELECT clause dynamically
    select_clause := format('
        SELECT t1.%s, t2.%s
        FROM %I t1
        JOIN %I t2 ON t1.%I = t2.%I',
        array_to_string(table1_columns, ', t1.'),
        array_to_string(table2_columns, ', t2.'),
        table1_name, table2_name, join_column1, join_column2);

    -- Execute the dynamic query and return the result set
    RETURN QUERY EXECUTE select_clause;
END;
$$;

