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