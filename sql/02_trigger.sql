-- ============================================
-- Trigger: validate amount sign vs category type
-- ============================================

CREATE OR REPLACE FUNCTION fn_check_movement_amount()
RETURNS TRIGGER AS $$
DECLARE
    cat_type category_type;
BEGIN
    SELECT type INTO cat_type FROM category WHERE category_id = NEW.category_id;

    IF cat_type = 'income' AND NEW.amount <= 0 THEN
        RAISE EXCEPTION 'Income movements must have a positive amount';
    ELSIF cat_type = 'expense' AND NEW.amount >= 0 THEN
        RAISE EXCEPTION 'Expense movements must have a negative amount';
    ELSIF cat_type = 'transfer' AND NEW.amount = 0 THEN
        RAISE EXCEPTION 'Transfer movements cannot have a zero amount';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_movement_amount
    BEFORE INSERT OR UPDATE ON movement
    FOR EACH ROW
    EXECUTE FUNCTION fn_check_movement_amount();