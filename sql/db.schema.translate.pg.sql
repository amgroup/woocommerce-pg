--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;


--
-- Name: plpython2u; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpython2u WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpython2u; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpython2u IS 'PL/Python2U untrusted procedural language';


--
-- Name: translate; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA translate;


SET search_path = translate, pg_catalog;

--
-- Name: en(text); Type: FUNCTION; Schema: translate; Owner: -
--

CREATE FUNCTION en(ru text) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$DECLARE
  translate text;
BEGIN
  translate := response FROM translate.ru_en c WHERE c.request = lower($1) AND direction = 'ru_en';
  IF (translate != '' AND translate IS NOT NULL) THEN
    RETURN translate;
  ELSE
    translate := lower( translate.ru2en( $1 ) );

    INSERT INTO translate.ru_en(request,response,direction)
    SELECT request,response,direction FROM (
      SELECT lower($1::text) AS request, translate::text AS response, 'ru_en'::text AS direction   
    ) n
    WHERE NOT EXISTS (
      SELECT true FROM translate.ru_en o WHERE n.request = o.request AND o.direction = n.direction
    );

    RETURN translate;
  END IF;

  RETURN NULL;
END;$_$;


--
-- Name: en2ru(text); Type: FUNCTION; Schema: translate; Owner: -
--

CREATE FUNCTION en2ru(word text) RETURNS text
    LANGUAGE plpython2u STRICT
    AS $$# -*- coding: utf8 -*-
import urllib, json

global word
try:
  return ((json.loads( urllib.urlopen('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20130420T090103Z.541db632c0957e3e.5c5df05938d3723f4b5df2e86198ca1774724f49&lang=en-ru&text=' + word.lower() ).read() ))['text'][0]).lower()
except:
  return None
$$;


--
-- Name: ru(text); Type: FUNCTION; Schema: translate; Owner: -
--

CREATE FUNCTION ru(en text) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$DECLARE
  translate text;
BEGIN
  translate := response FROM translate.ru_en c WHERE c.request = lower($1) AND direction = 'en_ru';
  IF (translate != '' AND translate IS NOT NULL) THEN
    RETURN translate;
  ELSE
    translate := lower( translate.en2ru( $1 ) );

    INSERT INTO translate.ru_en(request,response,direction)
    SELECT request,response,direction FROM (
      SELECT lower($1::text) AS request, translate::text AS response, 'en_ru'::text AS direction   
    ) n
    WHERE NOT EXISTS (
      SELECT true FROM translate.ru_en o WHERE n.request = o.request AND o.direction = n.direction
    );

    RETURN translate;
  END IF;

  RETURN NULL;
END;

$_$;


--
-- Name: ru2en(text); Type: FUNCTION; Schema: translate; Owner: -
--

CREATE FUNCTION ru2en(word text) RETURNS text
    LANGUAGE plpython2u STRICT
    AS $$# -*- coding: utf8 -*-
import urllib, json

global word
try:
  return ((json.loads( urllib.urlopen('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20130420T090103Z.541db632c0957e3e.5c5df05938d3723f4b5df2e86198ca1774724f49&lang=ru-en&text=' + word.lower() ).read() ))['text'][0]).lower()
except:
  return None
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ru_en; Type: TABLE; Schema: translate; Owner: -; Tablespace: 
--

CREATE TABLE ru_en (
    request text NOT NULL,
    response text,
    direction text NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: ru_en_pkey; Type: CONSTRAINT; Schema: translate; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ru_en
    ADD CONSTRAINT ru_en_pkey PRIMARY KEY (request, direction);


--
-- Name: cache_ru_created_idx; Type: INDEX; Schema: translate; Owner: -; Tablespace: 
--

CREATE INDEX cache_ru_created_idx ON ru_en USING btree (created);


--
-- PostgreSQL database dump complete
--

