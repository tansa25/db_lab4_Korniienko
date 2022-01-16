--function 
CREATE OR REPLACE FUNCTION number_of_books_in_a_given_year(period_id_f text) RETURNS int 
LANGUAGE 'plpgsql'
AS
$$
    DECLARE
         number_of_books int;
    BEGIN
        SELECT COUNT(*) INTO number_of_books FROM Books 
        WHERE Books.period_id = period_id_f;
        RETURN number_of_books;
    END;
$$;
SELECT number_of_books_in_a_given_year('PER2')


--procedure

CREATE OR REPLACE PROCEDURE find_books_of_given_author(author_id_n text)
LANGUAGE 'plpgsql'
AS $$
	DECLARE
		found_books record;
    BEGIN
        FOR found_books IN
            (SELECT (books_name) FROM Books 
            JOIN Author USING(author_id)
            WHERE  author_id = author_id_n)
        LOOP 
            RAISE INFO 'book of author with id % :  %', author_id_n, found_books;
        END LOOP;
    END;
$$;
CALL find_books_of_given_author('AUT2');


--trigger
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
  
  
 
INSERT INTO Books
VALUES('BOOK11', 'GEN1', 'AUT8', 'PER3', 'If I Stay', '9', '7153', '4.3');
SELECT * FROM Books