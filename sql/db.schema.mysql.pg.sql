--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: mysql; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA mysql;


SET search_path = mysql, pg_catalog;

--
-- Name: TIME(timestamp without time zone); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION "TIME"(timestamp without time zone) RETURNS time without time zone
    LANGUAGE sql
    AS $_$
SELECT mysql."time"($1)
$_$;


--
-- Name: _mysqlf_pgsql(text); Type: FUNCTION; Schema: mysql; Owner: -
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


--
-- Name: adddate(date, interval); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION adddate(date, interval) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT ($1 + $2)::date; $_$;


--
-- Name: char(integer[]); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION "char"(VARIADIC integer[]) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT array_to_string(ARRAY(SELECT chr(unnest($1))),'')
$_$;


--
-- Name: concat(text[]); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION concat(VARIADIC str text[]) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT array_to_string($1, '');
$_$;


--
-- Name: concat_ws(text, text[]); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION concat_ws(separator text, VARIADIC str text[]) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT array_to_string($2, $1);
$_$;


--
-- Name: convert_tz(timestamp without time zone, text, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION convert_tz(dt timestamp without time zone, from_tz text, to_tz text) RETURNS timestamp without time zone
    LANGUAGE sql
    AS $_$
SELECT ($1 AT TIME ZONE $2) AT TIME ZONE $3;
$_$;


--
-- Name: curdate(); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION curdate() RETURNS date
    LANGUAGE sql
    AS $$
SELECT CURRENT_DATE
$$;


--
-- Name: date(anyelement); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION date(anyelement) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT $1::date;
$_$;


--
-- Name: date_add(date, interval); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION date_add(date, interval) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT adddate($1, $2)
$_$;


--
-- Name: date_format(date, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION date_format(date, text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT to_char($1, mysql._mysqlf_pgsql($2))
$_$;


--
-- Name: date_format(timestamp without time zone, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION date_format(timestamp without time zone, text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT to_char($1, mysql._mysqlf_pgsql($2))
$_$;


--
-- Name: date_sub(date, interval); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION date_sub(date, interval) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT ($1 - $2)::date;
$_$;


--
-- Name: datediff(date, date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION datediff(date, date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT $1 - $2
$_$;


--
-- Name: day(date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION day(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT dayofmonth($1)
$_$;


--
-- Name: dayname(date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION dayname(date) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT to_char($1, 'TMDay')
$_$;


--
-- Name: dayofmonth(date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION dayofmonth(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(day from $1)::int
$_$;


--
-- Name: dayofweek(date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION dayofweek(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(dow FROM $1)::int
$_$;


--
-- Name: dayofyear(date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION dayofyear(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(doy FROM $1)::int
$_$;


--
-- Name: elt(integer, text[]); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION elt(integer, VARIADIC text[]) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT $2[$1];
$_$;


--
-- Name: field(text, text[]); Type: FUNCTION; Schema: mysql; Owner: -
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


--
-- Name: field(character varying, text[]); Type: FUNCTION; Schema: mysql; Owner: -
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


--
-- Name: find_in_set(text, text); Type: FUNCTION; Schema: mysql; Owner: -
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


--
-- Name: foreign_key_checks(boolean); Type: FUNCTION; Schema: mysql; Owner: -
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


--
-- Name: from_days(integer); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION from_days(integer) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT date '0001-01-01bc' + $1
$_$;


--
-- Name: from_unixtime(double precision); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION from_unixtime(double precision) RETURNS timestamp without time zone
    LANGUAGE sql
    AS $_$
SELECT to_timestamp($1)::timestamp
$_$;


--
-- Name: get_format(text, text); Type: FUNCTION; Schema: mysql; Owner: -
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


--
-- Name: group_concat_atom(text, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION group_concat_atom(column1 text, column2 text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(column1||','||column2, column2, column1);
END;
$$;


--
-- Name: group_concat_atom(bigint, bigint); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION group_concat_atom(column1 bigint, column2 bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(CAST(column1 AS TEXT)||','||CAST(column2 AS TEXT), CAST(column2 AS TEXT), CAST(column1 AS TEXT));
END;
$$;


--
-- Name: group_concat_atom(bigint, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION group_concat_atom(column1 bigint, column2 text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(CAST(column1 AS TEXT)||','||column2, column2, CAST(column1 AS TEXT));
END;
$$;


--
-- Name: group_concat_atom(text, bigint); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION group_concat_atom(column1 text, column2 bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(column1||','||CAST(column2 AS TEXT), CAST(column2 AS TEXT), column1);
END;
$$;


--
-- Name: group_concat_atom(text, text, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION group_concat_atom(column1 text, column2 text, delimiter text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(column1||delimiter||column2, column2, column1);
END;
$$;


--
-- Name: group_concat_atom(text, bigint, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION group_concat_atom(column1 text, column2 bigint, delimiter text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(column1||delimiter||CAST(column2 AS TEXT), CAST(column2 AS TEXT), column1);
END;
$$;


--
-- Name: group_concat_atom(bigint, text, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION group_concat_atom(column1 bigint, column2 text, delimiter text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(CAST(column1 AS TEXT)||delimiter||column2, column2, CAST(column1 AS TEXT));
END;
$$;


--
-- Name: group_concat_atom(bigint, bigint, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION group_concat_atom(column1 bigint, column2 bigint, delimiter text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN COALESCE(CAST(column1 AS TEXT)||delimiter||CAST(column2 AS TEXT), CAST(column2 AS TEXT), CAST(column1 AS TEXT));
END;
$$;


--
-- Name: hex(integer); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION hex(integer) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT upper(to_hex($1));
$_$;


--
-- Name: hex(bigint); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION hex(bigint) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT upper(to_hex($1));
$_$;


--
-- Name: hex(text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION hex(text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT upper(encode($1::bytea, 'hex'))
$_$;


--
-- Name: hour(time without time zone); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION hour(time without time zone) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(hour FROM $1)::int;
$_$;


--
-- Name: hour(timestamp without time zone); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION hour(timestamp without time zone) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(hour FROM $1)::int;
$_$;


--
-- Name: last_day(date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION last_day(date) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT (date_trunc('month',$1 + interval '1 month'))::date - 1
$_$;


--
-- Name: lcase(text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION lcase(str text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT lower($1)
$_$;


--
-- Name: left(text, integer); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION "left"(str text, len integer) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT substring($1 FROM 1 FOR $2)
$_$;


--
-- Name: locate(text, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION locate(substr text, str text) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT position($1 in $2)
$_$;


--
-- Name: makedate(integer, integer); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION makedate(year integer, dayofyear integer) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT (date '0001-01-01' + ($1 - 1) * interval '1 year' + ($2 - 1) * interval '1 day'):: date
$_$;


--
-- Name: maketime(integer, integer, double precision); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION maketime(integer, integer, double precision) RETURNS time without time zone
    LANGUAGE sql
    AS $_$
SELECT time '00:00:00' + $1 * interval '1 hour' + $2 * interval '1 min'
+ $3 * interval '1 sec'
$_$;


--
-- Name: minute(timestamp without time zone); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION minute(timestamp without time zone) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(minute FROM $1)::int
$_$;


--
-- Name: month(date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION month(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(month FROM $1)::int
$_$;


--
-- Name: monthname(date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION monthname(date) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT to_char($1, 'TMMonth')
$_$;


--
-- Name: rand(); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION rand() RETURNS numeric
    LANGUAGE plperlu
    AS $$
    return rand();
$$;


--
-- Name: reverse(text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION reverse(str text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT array_to_string(ARRAY(SELECT substring($1 FROM i FOR 1)
                                FROM generate_series(length($1),1,-1) g(i)),
                       '')
$_$;


--
-- Name: right(text, integer); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION "right"(str text, len integer) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT substring($1 FROM length($1) - $2 FOR $2)
$_$;


--
-- Name: space(integer); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION space(n integer) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT repeat(' ', $1)
$_$;


--
-- Name: str_to_date(text, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION str_to_date(text, text) RETURNS date
    LANGUAGE sql
    AS $_$
SELECT to_date($1, mysql._mysqlf_pgsql($2))
$_$;


--
-- Name: strcmp(text, text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION strcmp(text, text) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT CASE WHEN $1 < $2 THEN -1
WHEN $1 > $2 THEN 1
ELSE 0 END;
$_$;


--
-- Name: substring_index(text, text, integer); Type: FUNCTION; Schema: mysql; Owner: -
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


--
-- Name: time(timestamp without time zone); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION "time"(timestamp without time zone) RETURNS time without time zone
    LANGUAGE sql
    AS $_$
SELECT $1::time
$_$;


--
-- Name: to_days(date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION to_days(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT $1 - '0001-01-01bc'
$_$;


--
-- Name: ucase(text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION ucase(str text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT upper($1)
$_$;


--
-- Name: unhex(text); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION unhex(text) RETURNS text
    LANGUAGE sql
    AS $_$
SELECT convert_from(decode($1, 'hex'),'utf8');
$_$;


--
-- Name: unix_timestamp(); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION unix_timestamp() RETURNS double precision
    LANGUAGE sql
    AS $$
SELECT EXTRACT(epoch FROM current_timestamp)
$$;


--
-- Name: unix_timestamp(timestamp without time zone); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION unix_timestamp(timestamp without time zone) RETURNS double precision
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(epoch FROM $1)
$_$;


--
-- Name: week(date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION week(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(week FROM $1)::int;
$_$;


--
-- Name: year(date); Type: FUNCTION; Schema: mysql; Owner: -
--

CREATE FUNCTION year(date) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT EXTRACT(year FROM $1)::int
$_$;


--
-- Name: group_concat(text); Type: AGGREGATE; Schema: mysql; Owner: -
--

CREATE AGGREGATE group_concat(text) (
    SFUNC = mysql.group_concat_atom,
    STYPE = text
);


--
-- Name: group_concat(bigint); Type: AGGREGATE; Schema: mysql; Owner: -
--

CREATE AGGREGATE group_concat(bigint) (
    SFUNC = mysql.group_concat_atom,
    STYPE = text
);


--
-- Name: group_concat(text, text); Type: AGGREGATE; Schema: mysql; Owner: -
--

CREATE AGGREGATE group_concat(text, text) (
    SFUNC = mysql.group_concat_atom,
    STYPE = text
);


--
-- Name: group_concat(bigint, text); Type: AGGREGATE; Schema: mysql; Owner: -
--

CREATE AGGREGATE group_concat(bigint, text) (
    SFUNC = mysql.group_concat_atom,
    STYPE = text
);


--
-- PostgreSQL database dump complete
--

