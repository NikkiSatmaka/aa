CREATE OR REPLACE FUNCTION remove_constraints_and_backup(p_schema_name TEXT, p_table_name TEXT)
RETURNS void AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT 
            conname AS constraint_name,
            contype AS constraint_type,
            pg_catalog.pg_get_constraintdef(oid) AS definition
        FROM pg_constraint
        WHERE conrelid = (
            SELECT oid 
            FROM pg_class 
            WHERE relname = p_table_name 
            AND relnamespace = (SELECT oid FROM pg_namespace WHERE nspname = p_schema_name)
        )
    LOOP
        INSERT INTO constraint_backup (schema_name, table_name, constraint_name, constraint_type, definition)
        VALUES (p_schema_name, p_table_name, rec.constraint_name, rec.constraint_type, rec.definition);
        EXECUTE format('ALTER TABLE %I.%I DROP CONSTRAINT IF EXISTS %I', p_schema_name, p_table_name, rec.constraint_name);
    END LOOP;
END;

$$ LANGUAGE plpgsql;