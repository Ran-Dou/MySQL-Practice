use db_countries;
show tables;
-- STR_TO_DATE
 
select * from intl_football;
describe intl_football;

DROP TABLE IF EXISTS intl;
CREATE TEMPORARY TABLE intl
	SELECT * , STR_TO_DATE(date,'%Y-%m-%d') as date_correct
    FROM intl_football;

DESCRIBE intl;
select * from intl;


SELECT date_correct,DAYOFWEEK(date_correct) FROM intl;
SELECT CURDATE() as today, date_correct as day_game FROM intl;

SELECT CURDATE() as today, 
      date_correct as day_game ,
      DATEDIFF(CURDATE(), date_correct)	as days_between		FROM intl;


-- Function			Description
-- CURDATE	 		Returns the current date.
-- DATEDIFF			Calculates the number of days between two DATE values.
-- DAY				Gets the day of the month of a specified date.
-- DATE_ADD			Adds a time value to date value.
-- DATE_SUB			Subtracts a time value from a date value.
-- DATE_FORMAT		Formats a date value based on a specified date format.
-- DAYNAME			Gets the name of a weekday for a specified date.
-- DAYOFWEEK		Returns the weekday index for a date.
-- EXTRACT			Extracts a part of a date.
-- LAST_DAY			Returns the last day of the month of a specified date
-- NOW				Returns the current date and time at which the statement executed.
-- MONTH			Returns an integer that represents a month of a specified date.
-- STR_TO_DATE		Converts a string into a date and time value based on a specified format.
-- SYSDATE			Returns the current date.
-- TIMEDIFF			Calculates the difference between two TIME or DATETIME values.
-- TIMESTAMPDIFF	Calculates the difference between two DATE or DATETIME values.
-- WEEK				Returns a week number of a date.
-- WEEKDAY			Returns a weekday index for a date.
-- YEAR				Return the year for a specified date