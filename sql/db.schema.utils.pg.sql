--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: utils; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA utils;


SET search_path = utils, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: synonym; Type: TABLE; Schema: utils; Owner: -; Tablespace: 
--

CREATE TABLE synonym (
    phrase text NOT NULL,
    replacement text NOT NULL,
    type text DEFAULT 'generator'::text NOT NULL,
    rate numeric DEFAULT 1,
    updated timestamp without time zone DEFAULT now()
);


--
-- Name: synonym_pkey; Type: CONSTRAINT; Schema: utils; Owner: -; Tablespace: 
--

ALTER TABLE ONLY synonym
    ADD CONSTRAINT synonym_pkey PRIMARY KEY (phrase, replacement, type);


--
-- Name: synonym_phrase_idx; Type: INDEX; Schema: utils; Owner: -; Tablespace: 
--

CREATE INDEX synonym_phrase_idx ON synonym USING btree (phrase);


--
-- Name: synonym_type_idx; Type: INDEX; Schema: utils; Owner: -; Tablespace: 
--

CREATE INDEX synonym_type_idx ON synonym USING btree (type);


--
-- PostgreSQL database dump complete
--

