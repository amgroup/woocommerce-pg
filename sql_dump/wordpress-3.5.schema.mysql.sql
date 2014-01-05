--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: mysql; Type: SCHEMA; Schema: -; Owner: wordpress
--

CREATE SCHEMA mysql;


ALTER SCHEMA mysql OWNER TO wordpress;

SET search_path = mysql, pg_catalog;

--
-- Name: TIME(timestamp without time zone); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION "TIME"(timestamp without time zone) RETURNS time without time zone
    LANGUAGE sql
    AS $_$
SELECT mysql."time"($1)
$_$;


ALTER FUNCTION mysql."TIME"(timestamp without time zone) OWNER TO postgres;

--
-- Name: _mysqlf_pgsql(text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION _mysqlf_pgsql(text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT array_to_string(ARRAY(SELECT s
FROM (SELECT CASE WHEN substring($1 FROM i FOR 1) <> '%'
AND substring($1 FROM i-1 FOR 1) <> '%'
THEN substring($1 FROM i for 1)
ELSE CASE substring($1 FROM i FOR 2)
WHEN '%H' THEN 'HH24'
WHEN '%p' THEN 'am'
WHEN '%Y' THEN 'YYYY'
WHEN '%m' THEN 'MM'
WHEN '%d' THEN 'DD'
WHEN '%i' THEN 'MI'
WHEN '%s' THEN 'SS'
WHEN '%a' THEN 'Dy'
WHEN '%b' THEN 'Mon'
WHEN '%W' THEN 'Day'
WHEN '%M' THEN 'Month'
END
END s
FROM generate_series(1,length($1)) g(i)) g
WHERE s IS NOT NULL),
'')
$_$;


ALTER FUNCTION mysql._mysqlf_pgsql(text) OWNER TO postgres;

--
-- Name: adddate(date, interval); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION adddate(date, interval) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT ($1 + $2)::date; $_$;


ALTER FUNCTION mysql.adddate(date, interval) OWNER TO postgres;

--
-- Name: char(integer[]); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION "char"(VARIADIC integer[]) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT array_to_string(ARRAY(SELECT chr(unnest($1))),'')
$_$;


ALTER FUNCTION mysql."char"(VARIADIC integer[]) OWNER TO postgres;

--
-- Name: concat(text[]); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION concat(VARIADIC str text[]) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT array_to_string($1, '');
$_$;


ALTER FUNCTION mysql.concat(VARIADIC str text[]) OWNER TO postgres;

--
-- Name: concat_ws(text, text[]); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION concat_ws(separator text, VARIADIC str text[]) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT array_to_string($2, $1);
$_$;


ALTER FUNCTION mysql.concat_ws(separator text, VARIADIC str text[]) OWNER TO postgres;

--
-- Name: convert_tz(timestamp without time zone, text, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION convert_tz(dt timestamp without time zone, from_tz text, to_tz text) RETURNS timestamp without time zone
    LANGUAGE sql
    AS $_$
SELECT ($1 AT TIME ZONE $2) AT TIME ZONE $3;
$_$;


ALTER FUNCTION mysql.convert_tz(dt timestamp without time zone, from_tz text, to_tz text) OWNER TO postgres;

--
-- Name: curdate(); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION curdate() RETURNS date
    LANGUAGE sql
    AS $$
SELECT CURRENT_DATE
$$;


ALTER FUNCTION mysql.curdate() OWNER TO postgres;

--
-- Name: date(anyelement); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION date(anyelement) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT $1::date;
$_$;


ALTER FUNCTION mysql.date(anyelement) OWNER TO postgres;

--
-- Name: date_add(date, interval); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION date_add(date, interval) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT adddate($1, $2)
$_$;


ALTER FUNCTION mysql.date_add(date, interval) OWNER TO postgres;

--
-- Name: date_format(date, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION date_format(date, text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT to_char($1, mysql._mysqlf_pgsql($2))
$_$;


ALTER FUNCTION mysql.date_format(date, text) OWNER TO postgres;

--
-- Name: date_format(timestamp without time zone, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION date_format(timestamp without time zone, text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT to_char($1, mysql._mysqlf_pgsql($2))
$_$;


ALTER FUNCTION mysql.date_format(timestamp without time zone, text) OWNER TO postgres;

--
-- Name: date_sub(date, interval); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION date_sub(date, interval) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT ($1 - $2)::date;
$_$;


ALTER FUNCTION mysql.date_sub(date, interval) OWNER TO postgres;

--
-- Name: datediff(date, date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION datediff(date, date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT $1 - $2
$_$;


ALTER FUNCTION mysql.datediff(date, date) OWNER TO postgres;

--
-- Name: day(date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION day(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT dayofmonth($1)
$_$;


ALTER FUNCTION mysql.day(date) OWNER TO postgres;

--
-- Name: dayname(date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION dayname(date) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT to_char($1, 'TMDay')
$_$;


ALTER FUNCTION mysql.dayname(date) OWNER TO postgres;

--
-- Name: dayofmonth(date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION dayofmonth(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(day from $1)::int
$_$;


ALTER FUNCTION mysql.dayofmonth(date) OWNER TO postgres;

--
-- Name: dayofweek(date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION dayofweek(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(dow FROM $1)::int
$_$;


ALTER FUNCTION mysql.dayofweek(date) OWNER TO postgres;

--
-- Name: dayofyear(date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION dayofyear(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(doy FROM $1)::int
$_$;


ALTER FUNCTION mysql.dayofyear(date) OWNER TO postgres;

--
-- Name: elt(integer, text[]); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION elt(integer, VARIADIC text[]) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT $2[$1];
$_$;


ALTER FUNCTION mysql.elt(integer, VARIADIC text[]) OWNER TO postgres;

--
-- Name: field(text, text[]); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION field(text, VARIADIC text[]) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$
  SELECT i
     FROM generate_subscripts($2,1) g(i)
    WHERE $1 = $2[i]
    UNION ALL
    SELECT 0
    LIMIT 1
$_$;


ALTER FUNCTION mysql.field(text, VARIADIC text[]) OWNER TO postgres;

--
-- Name: field(character varying, text[]); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION field(character varying, VARIADIC text[]) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$
SELECT i
FROM generate_subscripts($2,1) g(i)
WHERE $1 = $2[i]
UNION ALL
SELECT 0
LIMIT 1
$_$;


ALTER FUNCTION mysql.field(character varying, VARIADIC text[]) OWNER TO postgres;

--
-- Name: find_in_set(text, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION find_in_set(str text, strlist text) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$
SELECT i
   FROM generate_subscripts(string_to_array($2,','),1) g(i)
  WHERE (string_to_array($2, ','))[i] = $1
  UNION ALL
  SELECT 0
  LIMIT 1
$_$;


ALTER FUNCTION mysql.find_in_set(str text, strlist text) OWNER TO postgres;

--
-- Name: foreign_key_checks(boolean); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION foreign_key_checks(enable boolean) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE public_table RECORD;
DECLARE count INT8;
BEGIN
count=0;
FOR public_table
IN SELECT tablename
FROM pg_catalog.pg_tables
WHERE schemaname='public' AND hastriggers=TRUE
LOOP
EXECUTE 'ALTER TABLE '||public_table.tablename||' '||
(CASE WHEN enable THEN 'EN' ELSE 'DIS' END)||
'ABLE TRIGGER ALL;';
count=count+1;
END LOOP;
RETURN count;
END;
$$;


ALTER FUNCTION mysql.foreign_key_checks(enable boolean) OWNER TO postgres;

--
-- Name: from_days(integer); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION from_days(integer) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT date '0001-01-01bc' + $1
$_$;


ALTER FUNCTION mysql.from_days(integer) OWNER TO postgres;

--
-- Name: from_unixtime(double precision); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION from_unixtime(double precision) RETURNS timestamp without time zone
    LANGUAGE sql
    AS $_$
SELECT to_timestamp($1)::timestamp
$_$;


ALTER FUNCTION mysql.from_unixtime(double precision) OWNER TO postgres;

--
-- Name: get_format(text, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION get_format(text, text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT CASE lower($1)
WHEN 'date' THEN
CASE lower($2)
WHEN 'usa' THEN '%m.%d.%Y'
WHEN 'jis' THEN '%Y-%m-%d'
WHEN 'iso' THEN '%Y-%m-%d'
WHEN 'eur' THEN '%d.%m.%Y'
WHEN 'internal' THEN '%Y%m%d'
END
WHEN 'datetime' THEN
CASE lower($2)
WHEN 'usa' THEN '%Y-%m-%d %H-.%i.%s'
WHEN 'jis' THEN '%Y-%m-%d %H:%i:%s'
WHEN 'iso' THEN '%Y-%m-%d %H:%i:%s'
WHEN 'eur' THEN '%Y-%m-%d %H.%i.%s'
WHEN 'internal' THEN '%Y%m%d%H%i%s'
END
WHEN 'time' THEN
CASE lower($2)
WHEN 'usa' THEN '%h:%i:%s %p'
WHEN 'jis' THEN '%H:%i:%s'
WHEN 'iso' THEN '%H:%i:%s'
WHEN 'eur' THEN '%H.%i.%s'
WHEN 'internal' THEN '%H%i%s'
END
END;
$_$;


ALTER FUNCTION mysql.get_format(text, text) OWNER TO postgres;

--
-- Name: group_concat_atom(text, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION group_concat_atom(column1 text, column2 text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(column1||','||column2, column2, column1);
END;
$$;


ALTER FUNCTION mysql.group_concat_atom(column1 text, column2 text) OWNER TO postgres;

--
-- Name: group_concat_atom(bigint, bigint); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION group_concat_atom(column1 bigint, column2 bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(CAST(column1 AS TEXT)||','||CAST(column2 AS TEXT), CAST(column2 AS TEXT), CAST(column1 AS TEXT));
END;
$$;


ALTER FUNCTION mysql.group_concat_atom(column1 bigint, column2 bigint) OWNER TO postgres;

--
-- Name: group_concat_atom(bigint, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION group_concat_atom(column1 bigint, column2 text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(CAST(column1 AS TEXT)||','||column2, column2, CAST(column1 AS TEXT));
END;
$$;


ALTER FUNCTION mysql.group_concat_atom(column1 bigint, column2 text) OWNER TO postgres;

--
-- Name: group_concat_atom(text, bigint); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION group_concat_atom(column1 text, column2 bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(column1||','||CAST(column2 AS TEXT), CAST(column2 AS TEXT), column1);
END;
$$;


ALTER FUNCTION mysql.group_concat_atom(column1 text, column2 bigint) OWNER TO postgres;

--
-- Name: group_concat_atom(text, text, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION group_concat_atom(column1 text, column2 text, delimiter text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(column1||delimiter||column2, column2, column1);
END;
$$;


ALTER FUNCTION mysql.group_concat_atom(column1 text, column2 text, delimiter text) OWNER TO postgres;

--
-- Name: group_concat_atom(text, bigint, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION group_concat_atom(column1 text, column2 bigint, delimiter text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(column1||delimiter||CAST(column2 AS TEXT), CAST(column2 AS TEXT), column1);
END;
$$;


ALTER FUNCTION mysql.group_concat_atom(column1 text, column2 bigint, delimiter text) OWNER TO postgres;

--
-- Name: group_concat_atom(bigint, text, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION group_concat_atom(column1 bigint, column2 text, delimiter text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(CAST(column1 AS TEXT)||delimiter||column2, column2, CAST(column1 AS TEXT));
END;
$$;


ALTER FUNCTION mysql.group_concat_atom(column1 bigint, column2 text, delimiter text) OWNER TO postgres;

--
-- Name: group_concat_atom(bigint, bigint, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION group_concat_atom(column1 bigint, column2 bigint, delimiter text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(CAST(column1 AS TEXT)||delimiter||CAST(column2 AS TEXT), CAST(column2 AS TEXT), CAST(column1 AS TEXT));
END;
$$;


ALTER FUNCTION mysql.group_concat_atom(column1 bigint, column2 bigint, delimiter text) OWNER TO postgres;

--
-- Name: hex(integer); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION hex(integer) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT upper(to_hex($1));
$_$;


ALTER FUNCTION mysql.hex(integer) OWNER TO postgres;

--
-- Name: hex(bigint); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION hex(bigint) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT upper(to_hex($1));
$_$;


ALTER FUNCTION mysql.hex(bigint) OWNER TO postgres;

--
-- Name: hex(text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION hex(text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT upper(encode($1::bytea, 'hex'))
$_$;


ALTER FUNCTION mysql.hex(text) OWNER TO postgres;

--
-- Name: hour(time without time zone); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION hour(time without time zone) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(hour FROM $1)::int;
$_$;


ALTER FUNCTION mysql.hour(time without time zone) OWNER TO postgres;

--
-- Name: hour(timestamp without time zone); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION hour(timestamp without time zone) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(hour FROM $1)::int;
$_$;


ALTER FUNCTION mysql.hour(timestamp without time zone) OWNER TO postgres;

--
-- Name: last_day(date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION last_day(date) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT (date_trunc('month',$1 + interval '1 month'))::date - 1
$_$;


ALTER FUNCTION mysql.last_day(date) OWNER TO postgres;

--
-- Name: lcase(text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION lcase(str text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT lower($1)
$_$;


ALTER FUNCTION mysql.lcase(str text) OWNER TO postgres;

--
-- Name: left(text, integer); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION "left"(str text, len integer) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT substring($1 FROM 1 FOR $2)
$_$;


ALTER FUNCTION mysql."left"(str text, len integer) OWNER TO postgres;

--
-- Name: locate(text, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION locate(substr text, str text) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT position($1 in $2)
$_$;


ALTER FUNCTION mysql.locate(substr text, str text) OWNER TO postgres;

--
-- Name: makedate(integer, integer); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION makedate(year integer, dayofyear integer) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT (date '0001-01-01' + ($1 - 1) * interval '1 year' + ($2 - 1) * interval '1 day'):: date
$_$;


ALTER FUNCTION mysql.makedate(year integer, dayofyear integer) OWNER TO postgres;

--
-- Name: maketime(integer, integer, double precision); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION maketime(integer, integer, double precision) RETURNS time without time zone
    LANGUAGE sql
    AS $_$
SELECT time '00:00:00' + $1 * interval '1 hour' + $2 * interval '1 min'
+ $3 * interval '1 sec'
$_$;


ALTER FUNCTION mysql.maketime(integer, integer, double precision) OWNER TO postgres;

--
-- Name: minute(timestamp without time zone); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION minute(timestamp without time zone) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(minute FROM $1)::int
$_$;


ALTER FUNCTION mysql.minute(timestamp without time zone) OWNER TO postgres;

--
-- Name: month(date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION month(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(month FROM $1)::int
$_$;


ALTER FUNCTION mysql.month(date) OWNER TO postgres;

--
-- Name: monthname(date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION monthname(date) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT to_char($1, 'TMMonth')
$_$;


ALTER FUNCTION mysql.monthname(date) OWNER TO postgres;

--
-- Name: reverse(text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION reverse(str text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT array_to_string(ARRAY(SELECT substring($1 FROM i FOR 1)
                                FROM generate_series(length($1),1,-1) g(i)),
                       '')
$_$;


ALTER FUNCTION mysql.reverse(str text) OWNER TO postgres;

--
-- Name: right(text, integer); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION "right"(str text, len integer) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT substring($1 FROM length($1) - $2 FOR $2)
$_$;


ALTER FUNCTION mysql."right"(str text, len integer) OWNER TO postgres;

--
-- Name: space(integer); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION space(n integer) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT repeat(' ', $1)
$_$;


ALTER FUNCTION mysql.space(n integer) OWNER TO postgres;

--
-- Name: str_to_date(text, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION str_to_date(text, text) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT to_date($1, mysql._mysqlf_pgsql($2))
$_$;


ALTER FUNCTION mysql.str_to_date(text, text) OWNER TO postgres;

--
-- Name: strcmp(text, text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION strcmp(text, text) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT CASE WHEN $1 < $2 THEN -1
WHEN $1 > $2 THEN 1
ELSE 0 END;
$_$;


ALTER FUNCTION mysql.strcmp(text, text) OWNER TO postgres;

--
-- Name: substring_index(text, text, integer); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION substring_index(str text, delim text, count integer) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT CASE WHEN $3 > 0 
THEN array_to_string((string_to_array($1, $2))[1:$3], $2)
ELSE array_to_string(ARRAY(SELECT unnest(string_to_array($1,$2))
                             OFFSET array_upper(string_to_array($1,$2),1) + $3),
                     $2)
END
$_$;


ALTER FUNCTION mysql.substring_index(str text, delim text, count integer) OWNER TO postgres;

--
-- Name: time(timestamp without time zone); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION "time"(timestamp without time zone) RETURNS time without time zone
    LANGUAGE sql
    AS $_$
SELECT $1::time
$_$;


ALTER FUNCTION mysql."time"(timestamp without time zone) OWNER TO postgres;

--
-- Name: to_days(date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION to_days(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT $1 - '0001-01-01bc'
$_$;


ALTER FUNCTION mysql.to_days(date) OWNER TO postgres;

--
-- Name: ucase(text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION ucase(str text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT upper($1)
$_$;


ALTER FUNCTION mysql.ucase(str text) OWNER TO postgres;

--
-- Name: unhex(text); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION unhex(text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT convert_from(decode($1, 'hex'),'utf8');
$_$;


ALTER FUNCTION mysql.unhex(text) OWNER TO postgres;

--
-- Name: unix_timestamp(); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION unix_timestamp() RETURNS double precision
    LANGUAGE sql
    AS $$
SELECT EXTRACT(epoch FROM current_timestamp)
$$;


ALTER FUNCTION mysql.unix_timestamp() OWNER TO postgres;

--
-- Name: unix_timestamp(timestamp without time zone); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION unix_timestamp(timestamp without time zone) RETURNS double precision
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(epoch FROM $1)
$_$;


ALTER FUNCTION mysql.unix_timestamp(timestamp without time zone) OWNER TO postgres;

--
-- Name: week(date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION week(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(week FROM $1)::int;
$_$;


ALTER FUNCTION mysql.week(date) OWNER TO postgres;

--
-- Name: year(date); Type: FUNCTION; Schema: mysql; Owner: postgres
--

CREATE FUNCTION year(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(year FROM $1)::int
$_$;


ALTER FUNCTION mysql.year(date) OWNER TO postgres;

--
-- Name: group_concat(text); Type: AGGREGATE; Schema: mysql; Owner: postgres
--

CREATE AGGREGATE group_concat(text) (
    SFUNC = mysql.group_concat_atom,
    STYPE = text
);


ALTER AGGREGATE mysql.group_concat(text) OWNER TO postgres;

--
-- Name: group_concat(bigint); Type: AGGREGATE; Schema: mysql; Owner: postgres
--

CREATE AGGREGATE group_concat(bigint) (
    SFUNC = mysql.group_concat_atom,
    STYPE = text
);


ALTER AGGREGATE mysql.group_concat(bigint) OWNER TO postgres;

--
-- Name: group_concat(text, text); Type: AGGREGATE; Schema: mysql; Owner: postgres
--

CREATE AGGREGATE group_concat(text, text) (
    SFUNC = mysql.group_concat_atom,
    STYPE = text
);


ALTER AGGREGATE mysql.group_concat(text, text) OWNER TO postgres;

--
-- Name: group_concat(bigint, text); Type: AGGREGATE; Schema: mysql; Owner: postgres
--

CREATE AGGREGATE group_concat(bigint, text) (
    SFUNC = mysql.group_concat_atom,
    STYPE = text
);


ALTER AGGREGATE mysql.group_concat(bigint, text) OWNER TO postgres;

--
-- PostgreSQL database dump complete
--

