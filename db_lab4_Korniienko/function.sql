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
