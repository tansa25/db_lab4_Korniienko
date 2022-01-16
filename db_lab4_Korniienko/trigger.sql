CREATE OR REPLACE FUNCTION add_user_rating()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
  UPDATE Books 
  SET books_user_rating = 'rating ' || NEW.books_user_rating WHERE books_id = NEW.books_id; 
  RETURN NULL;
END;
$$;

CREATE TRIGGER add_user_rating_trigger
  AFTER INSERT
  ON Books
  FOR EACH ROW
  EXECUTE PROCEDURE add_user_rating();