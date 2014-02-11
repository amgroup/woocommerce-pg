--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: casts; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA casts;


SET search_path = casts, pg_catalog;

--
-- Name: _date_to_bigint(date); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _date_to_bigint(date) RETURNS bigint
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT casts._date_to_integer($1)::bigint
$_$;


--
-- Name: _date_to_integer(date); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _date_to_integer(date) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT
    EXTRACT(YEAR FROM $1)::integer * 10000
    + EXTRACT(MONTH FROM $1)::integer * 100
    + EXTRACT(DAY FROM $1)::integer
$_$;


--
-- Name: _interval_to_bigint(interval); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _interval_to_bigint(interval) RETURNS bigint
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT
    EXTRACT(YEAR FROM $1)::bigint * 10000000000
    + EXTRACT(MONTH FROM $1)::bigint * 100000000
    + EXTRACT(DAY FROM $1)::bigint * 1000000
    + EXTRACT(HOUR FROM $1)::bigint * 10000
    + EXTRACT(MINUTE FROM $1)::bigint * 100
    + EXTRACT(SECONDS FROM $1)::bigint
$_$;


--
-- Name: _text_to_bigint(text); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _text_to_bigint(text) RETURNS bigint
    LANGUAGE plperlu IMMUTABLE STRICT COST 1
    AS $_X$
  return $1 if ($_[0] =~ m/^(\d+)(\.\d+)?$/);
  return undef;
$_X$;


--
-- Name: _text_to_date(text); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _text_to_date(text) RETURNS date
    LANGUAGE plperlu IMMUTABLE STRICT COST 1
    AS $_X$
  $_[0] =~ s/0000-00-00/0001-01-01/; #its just for mysql date format
  return $& if( $_[0] =~ m/^(\d{4}-\d{1,2}-\d{1,2})/ );
  return undef;
$_X$;


--
-- Name: _text_to_numeric(text); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _text_to_numeric(text) RETURNS numeric
    LANGUAGE plperlu IMMUTABLE STRICT COST 1
    AS $_X$
  return $1.$2 if( $_[0] =~ m/^(\d+)(\.\d+)?$/);
  return undef;
$_X$;


--
-- Name: _text_to_time(text); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _text_to_time(text) RETURNS time without time zone
    LANGUAGE plperlu IMMUTABLE STRICT COST 1
    AS $_X$
  
  return $& if( $_[0] =~ s/^(\d{1,2}:\d{1,2})(:\d{1,2}(\.\d+)?)?$/$1$2/ );
  return undef;
$_X$;


--
-- Name: _text_to_timestamp(text); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _text_to_timestamp(text) RETURNS timestamp without time zone
    LANGUAGE plperlu IMMUTABLE STRICT COST 1
    AS $_X$
  $_[0] =~ s/0000-00-00/0001-01-01/; #its just for mysql date format
  return $_[0] if( $_[0] =~ s/^(\d{4}-\d{2}-\d{2})( \d{1,2}:\d{2}:\d{2})?(\.\d+)?([\+\-\d\:.]+)?/$1$2$3$4/ );
  return undef;
$_X$;


--
-- Name: _text_to_timestamptz(text); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _text_to_timestamptz(text) RETURNS timestamp with time zone
    LANGUAGE plperlu IMMUTABLE STRICT COST 1
    AS $_X$
  $_[0] =~ s/0000-00-00/0001-01-01/; #its just for mysql date format
  return $_[0] if( $_[0] =~ s/^(\d{4}-\d{2}-\d{2})( \d{1,2}:\d{2}:\d{2})?(\.\d+)?([\+\-\d\:.]+)?/$1$2$3$4/ );
  return undef;
$_X$;


--
-- Name: _time_to_integer(time without time zone); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _time_to_integer(time without time zone) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT
    EXTRACT(HOUR FROM $1)::integer * 10000
    + EXTRACT(MINUTE FROM $1)::integer * 100
    + EXTRACT(SECONDS FROM $1)::integer
$_$;


--
-- Name: _time_to_integer(time with time zone); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _time_to_integer(time with time zone) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT
    EXTRACT(HOUR FROM $1)::integer * 10000
    + EXTRACT(MINUTE FROM $1)::integer * 100
    + EXTRACT(SECONDS FROM $1)::integer
$_$;


--
-- Name: _unknown_to_bigint(unknown); Type: FUNCTION; Schema: casts; Owner: -
--

CREATE OR REPLACE FUNCTION _unknown_to_bigint(unknown) RETURNS bigint
    LANGUAGE plperlu
    AS $_X$
  return $1 if ($_[0] =~ m/^(\d+)(\.\d+)?$/);
  return undef;
$_X$;


SET search_path = pg_catalog;

--
-- Name: CAST (date AS integer); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (date AS integer) WITH FUNCTION casts._date_to_integer(date) AS IMPLICIT;


--
-- Name: CAST (date AS bigint); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (date AS bigint) WITH FUNCTION casts._date_to_bigint(date) AS IMPLICIT;


--
-- Name: CAST (interval AS bigint); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (interval AS bigint) WITH FUNCTION casts._interval_to_bigint(interval) AS IMPLICIT;


--
-- Name: CAST (text AS date); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (text AS date) WITH FUNCTION casts._text_to_date(text) AS IMPLICIT;


--
-- Name: CAST (text AS bigint); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (text AS bigint) WITH FUNCTION casts._text_to_bigint(text) AS IMPLICIT;


--
-- Name: CAST (text AS numeric); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (text AS numeric) WITH FUNCTION casts._text_to_numeric(text) AS IMPLICIT;


--
-- Name: CAST (text AS time without time zone); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (text AS time without time zone) WITH FUNCTION casts._text_to_time(text) AS IMPLICIT;


--
-- Name: CAST (text AS timestamp without time zone); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (text AS timestamp without time zone) WITH FUNCTION casts._text_to_timestamp(text) AS IMPLICIT;


--
-- Name: CAST (text AS timestamp with time zone); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (text AS timestamp with time zone) WITH FUNCTION casts._text_to_timestamptz(text) AS IMPLICIT;


--
-- Name: CAST (time without time zone AS integer); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (time without time zone AS integer) WITH FUNCTION casts._time_to_integer(time without time zone) AS IMPLICIT;


--
-- Name: CAST (time with time zone AS integer); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (time with time zone AS integer) WITH FUNCTION casts._time_to_integer(time with time zone) AS IMPLICIT;


--
-- Name: CAST (unknown AS bigint); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (unknown AS bigint) WITH FUNCTION casts._unknown_to_bigint(unknown) AS IMPLICIT;


--
-- PostgreSQL database dump complete
--

