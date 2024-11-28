CREATE OR REPLACE FUNCTION restore_constraints(p_schema_name TEXT, p_table_name TEXT)
RETURNS void AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT constraint_name, definition
        FROM constraint_backup
        WHERE schema_name = p_schema_name
        AND table_name = p_table_name
    LOOP
        EXECUTE format('ALTER TABLE %I.%I ADD CONSTRAINT %I %s', 
            p_schema_name, 
            p_table_name, 
            rec.constraint_name, 
            rec.definition);
    END LOOP;
END;
$$ LANGUAGE plpgsql;