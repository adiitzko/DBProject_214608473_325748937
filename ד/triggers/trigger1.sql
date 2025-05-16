CREATE TRIGGER prevent_negative_payment
BEFORE INSERT ON payment
FOR EACH ROW
EXECUTE FUNCTION check_totalpay();
