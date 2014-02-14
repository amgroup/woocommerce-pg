--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;
-- DROP INDEX public.wp_woocommerce_rewrites_object_id_idx;

CREATE INDEX ON wp_woocommerce_rewrites (object_id);

CREATE INDEX ON wp_woocommerce_rewrites (slug);

CREATE INDEX ON wp_woocommerce_rewrites (uri);

CREATE INDEX ON wp_woocommerce_rewrites (created);

--
-- Name: term_taxonomy_term_id_taxonomy_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_term_taxonomy
    ADD CONSTRAINT term_taxonomy_term_id_taxonomy_key UNIQUE (term_id, taxonomy);


--
-- Name: terms_slug_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_terms
    ADD CONSTRAINT terms_slug_key UNIQUE (slug);


--
-- Name: wp_commentmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_commentmeta
    ADD CONSTRAINT wp_commentmeta_pkey PRIMARY KEY (meta_id);


--
-- Name: wp_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_comments
    ADD CONSTRAINT wp_comments_pkey PRIMARY KEY ("comment_ID");


--
-- Name: wp_faq_termmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_faq_termmeta
    ADD CONSTRAINT wp_faq_termmeta_pkey PRIMARY KEY (meta_id);


--
-- Name: wp_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_links
    ADD CONSTRAINT wp_links_pkey PRIMARY KEY (link_id);


--
-- Name: wp_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_options
    ADD CONSTRAINT wp_options_pkey PRIMARY KEY (option_id);


--
-- Name: wp_postmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_postmeta
    ADD CONSTRAINT wp_postmeta_pkey PRIMARY KEY (meta_id);


--
-- Name: wp_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_posts
    ADD CONSTRAINT wp_posts_pkey PRIMARY KEY ("ID");


--
-- Name: wp_term_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_term_relationships
    ADD CONSTRAINT wp_term_relationships_pkey PRIMARY KEY (object_id, term_taxonomy_id);


--
-- Name: wp_term_taxonomy_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_term_taxonomy
    ADD CONSTRAINT wp_term_taxonomy_pkey PRIMARY KEY (term_taxonomy_id);


--
-- Name: wp_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_terms
    ADD CONSTRAINT wp_terms_pkey PRIMARY KEY (term_id);


--
-- Name: wp_usermeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_usermeta
    ADD CONSTRAINT wp_usermeta_pkey PRIMARY KEY (umeta_id);


--
-- Name: wp_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_users
    ADD CONSTRAINT wp_users_pkey PRIMARY KEY ("ID");


--
-- Name: wp_woo_compare_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_woo_compare_categories
    ADD CONSTRAINT wp_woo_compare_categories_pkey PRIMARY KEY (id);


--
-- Name: wp_woo_compare_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_woo_compare_fields
    ADD CONSTRAINT wp_woo_compare_fields_pkey PRIMARY KEY (id);


--
-- Name: wp_woocommerce_attribute_taxonomies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_attribute_taxonomies
    ADD CONSTRAINT wp_woocommerce_attribute_taxonomies_pkey PRIMARY KEY (attribute_id);


--
-- Name: wp_woocommerce_downloadable_product_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_downloadable_product_permissions
    ADD CONSTRAINT wp_woocommerce_downloadable_product_permissions_pkey PRIMARY KEY (product_id, order_id, order_key, download_id);


--
-- Name: wp_woocommerce_order_itemmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_order_itemmeta
    ADD CONSTRAINT wp_woocommerce_order_itemmeta_pkey PRIMARY KEY (meta_id);


--
-- Name: wp_woocommerce_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_order_items
    ADD CONSTRAINT wp_woocommerce_order_items_pkey PRIMARY KEY (order_item_id);


--
-- Name: wp_woocommerce_tax_rate_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_tax_rate_locations
    ADD CONSTRAINT wp_woocommerce_tax_rate_locations_pkey PRIMARY KEY (location_id);


--
-- Name: wp_woocommerce_tax_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_tax_rates
    ADD CONSTRAINT wp_woocommerce_tax_rates_pkey PRIMARY KEY (tax_rate_id);


--
-- Name: wp_woocommerce_termmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_termmeta
    ADD CONSTRAINT wp_woocommerce_termmeta_pkey PRIMARY KEY (meta_id);


--
-- Name: attribute_taxonomies_attribute_name_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX attribute_taxonomies_attribute_name_idx ON wp_woocommerce_attribute_taxonomies USING btree (attribute_name);


--
-- Name: commentmeta_comment_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX commentmeta_comment_id_idx ON wp_commentmeta USING btree (comment_id);


--
-- Name: commentmeta_meta_key_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX commentmeta_meta_key_idx ON wp_commentmeta USING btree (meta_key);


--
-- Name: commentmeta_meta_value_as_bigint_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX commentmeta_meta_value_as_bigint_idx ON wp_commentmeta USING btree (((meta_value)::bigint));


--
-- Name: commentmeta_meta_value_as_numeric_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX commentmeta_meta_value_as_numeric_idx ON wp_commentmeta USING btree (((meta_value)::numeric));


--
-- Name: commentmeta_meta_value_as_timestamp_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX commentmeta_meta_value_as_timestamp_idx ON wp_commentmeta USING btree (((meta_value)::timestamp without time zone));


--
-- Name: commentmeta_meta_value_as_timestamptz_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX commentmeta_meta_value_as_timestamptz_idx ON wp_commentmeta USING btree (((meta_value)::timestamp with time zone));


--
-- Name: comments_comment_approved_date_gmt_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX comments_comment_approved_date_gmt_idx ON wp_comments USING btree (comment_approved, comment_date_gmt);


--
-- Name: comments_comment_date_gmt_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX comments_comment_date_gmt_idx ON wp_comments USING btree (comment_date_gmt);


--
-- Name: comments_comment_parent_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX comments_comment_parent_idx ON wp_comments USING btree (comment_parent);


--
-- Name: comments_comment_post_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX comments_comment_post_id_idx ON wp_comments USING btree ("comment_post_ID");


--
-- Name: downloadable_product_permissions_download_order_product_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX downloadable_product_permissions_download_order_product_idx ON wp_woocommerce_downloadable_product_permissions USING btree (download_id, order_id, product_id);


--
-- Name: faq_termmeta_meta_value_as_bigint_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX faq_termmeta_meta_value_as_bigint_idx ON wp_faq_termmeta USING btree (((meta_value)::bigint));


--
-- Name: faq_termmeta_meta_value_as_numeric_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX faq_termmeta_meta_value_as_numeric_idx ON wp_faq_termmeta USING btree (((meta_value)::numeric));


--
-- Name: faq_termmeta_meta_value_as_timestamp_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX faq_termmeta_meta_value_as_timestamp_idx ON wp_faq_termmeta USING btree (((meta_value)::timestamp without time zone));


--
-- Name: faq_termmeta_meta_value_as_timestamptz_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX faq_termmeta_meta_value_as_timestamptz_idx ON wp_faq_termmeta USING btree (((meta_value)::timestamp with time zone));


--
-- Name: links_link_visible_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX links_link_visible_idx ON wp_links USING btree (link_visible);


--
-- Name: meta_key_like_attribute_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX meta_key_like_attribute_idx ON wp_postmeta USING btree (((meta_key ~ '^attribute_pa_'::text)));


--
-- Name: meta_key_like_keywords_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX meta_key_like_keywords_idx ON wp_postmeta USING btree (((meta_key ~ '-keywords$'::text)));


--
-- Name: meta_key_like_seofield_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX meta_key_like_seofield_idx ON wp_postmeta USING btree (((meta_key ~ '^seo-'::text)));


--
-- Name: meta_value_as_bigint_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX meta_value_as_bigint_idx ON wp_postmeta USING btree (((meta_value)::bigint));


--
-- Name: meta_value_as_numeric_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX meta_value_as_numeric_idx ON wp_postmeta USING btree (((meta_value)::numeric));


--
-- Name: meta_value_as_text512_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX meta_value_as_text512_idx ON wp_postmeta USING btree (fn.__particular__text__512__idx(meta_value));


--
-- Name: meta_value_as_timestamp_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX meta_value_as_timestamp_idx ON wp_postmeta USING btree (((meta_value)::timestamp without time zone));


--
-- Name: meta_value_as_timestamptz_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX meta_value_as_timestamptz_idx ON wp_postmeta USING btree (((meta_value)::timestamp with time zone));


--
-- Name: meta_value_is_positive_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX meta_value_is_positive_idx ON wp_postmeta USING btree (fn.is_positive((meta_value)::numeric));


--
-- Name: option_value_as_bigint_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX option_value_as_bigint_idx ON wp_options USING btree (((option_value)::bigint));


--
-- Name: option_value_as_timestamp_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX option_value_as_timestamp_idx ON wp_options USING btree (((option_value)::timestamp without time zone));


--
-- Name: option_value_as_timestamptz_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX option_value_as_timestamptz_idx ON wp_options USING btree (((option_value)::timestamp with time zone));


--
-- Name: order_itemmeta_meta_key_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX order_itemmeta_meta_key_idx ON wp_woocommerce_order_itemmeta USING btree (meta_key);


--
-- Name: order_itemmeta_order_item_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX order_itemmeta_order_item_id_idx ON wp_woocommerce_order_itemmeta USING btree (order_item_id);


--
-- Name: order_items_order_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX order_items_order_id_idx ON wp_woocommerce_order_items USING btree (order_id);


--
-- Name: postmeta_meta_key_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX postmeta_meta_key_idx ON wp_postmeta USING btree (meta_key);


--
-- Name: postmeta_post_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX postmeta_post_id_idx ON wp_postmeta USING btree (post_id);


--
-- Name: posts_post_author_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX posts_post_author_idx ON wp_posts USING btree (post_author);


--
-- Name: posts_post_name_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX posts_post_name_idx ON wp_posts USING btree (post_name);


--
-- Name: posts_post_parent_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX posts_post_parent_idx ON wp_posts USING btree (post_parent);


--
-- Name: posts_tsv_updated_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX posts_tsv_updated_idx ON wp_posts USING btree (tsv_updated);


--
-- Name: posts_tsv_updated_is_null_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX posts_tsv_updated_is_null_idx ON wp_posts USING btree (((tsv_updated IS NULL)));


--
-- Name: posts_type_status_date_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX posts_type_status_date_idx ON wp_posts USING btree (post_type, post_status, post_date, "ID");


--
-- Name: tax_rate_locations_location_type_code_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX tax_rate_locations_location_type_code_idx ON wp_woocommerce_tax_rate_locations USING btree (location_type, location_code);


--
-- Name: tax_rate_locations_location_type_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX tax_rate_locations_location_type_idx ON wp_woocommerce_tax_rate_locations USING btree (location_type);


--
-- Name: tax_rates_tax_rate_class_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX tax_rates_tax_rate_class_idx ON wp_woocommerce_tax_rates USING btree (tax_rate_class);


--
-- Name: tax_rates_tax_rate_country_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX tax_rates_tax_rate_country_idx ON wp_woocommerce_tax_rates USING btree (tax_rate_country);


--
-- Name: tax_rates_tax_rate_priority_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX tax_rates_tax_rate_priority_idx ON wp_woocommerce_tax_rates USING btree (tax_rate_priority);


--
-- Name: tax_rates_tax_rate_state_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX tax_rates_tax_rate_state_idx ON wp_woocommerce_tax_rates USING btree (tax_rate_state);


--
-- Name: term_relationships_term_taxonomy_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX term_relationships_term_taxonomy_id_idx ON wp_term_relationships USING btree (term_taxonomy_id);


--
-- Name: term_taxonomy_taxonomy_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX term_taxonomy_taxonomy_idx ON wp_term_taxonomy USING btree (taxonomy);


--
-- Name: term_taxonomy_taxonomy_is_attribute_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX term_taxonomy_taxonomy_is_attribute_idx ON wp_term_taxonomy USING btree (fn.tax_is_attribute(taxonomy));


--
-- Name: termmeta_meta_key_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX termmeta_meta_key_idx ON wp_woocommerce_termmeta USING btree (meta_key);


--
-- Name: termmeta_woocommerce_term_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX termmeta_woocommerce_term_id_idx ON wp_woocommerce_termmeta USING btree (woocommerce_term_id);


--
-- Name: terms_name_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX terms_name_idx ON wp_terms USING btree (name);


--
-- Name: usermeta_meta_key_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX usermeta_meta_key_idx ON wp_usermeta USING btree (meta_key);


--
-- Name: usermeta_meta_value_as_bigint_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX usermeta_meta_value_as_bigint_idx ON wp_usermeta USING btree (((meta_value)::bigint));


--
-- Name: usermeta_meta_value_as_numeric_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX usermeta_meta_value_as_numeric_idx ON wp_usermeta USING btree (((meta_value)::numeric));


--
-- Name: usermeta_meta_value_as_timestamp_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX usermeta_meta_value_as_timestamp_idx ON wp_usermeta USING btree (((meta_value)::timestamp without time zone));


--
-- Name: usermeta_meta_value_as_timestamptz_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX usermeta_meta_value_as_timestamptz_idx ON wp_usermeta USING btree (((meta_value)::timestamp with time zone));


--
-- Name: usermeta_user_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX usermeta_user_id_idx ON wp_usermeta USING btree (user_id);


--
-- Name: users_user_login_key_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX users_user_login_key_idx ON wp_users USING btree (user_login);


--
-- Name: users_user_nicename_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX users_user_nicename_idx ON wp_users USING btree (user_nicename);


--
-- Name: wp_options_regexp_replace_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX wp_options_regexp_replace_idx ON wp_options USING btree (regexp_replace(option_name, '_wc_session.*_([^_]+)'::text, '\1'::text, ''::text));


--
-- Name: wp_posts_date_trunc_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX wp_posts_date_trunc_idx ON wp_posts USING btree (date_trunc('month'::text, post_date));


--
-- Name: wp_posts_post_type_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX wp_posts_post_type_idx ON wp_posts USING btree (post_type);


--
-- Name: wp_woo_compare_categories_fields_cat_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX wp_woo_compare_categories_fields_cat_id_idx ON wp_woo_compare_categories_fields USING btree (cat_id);


--
-- Name: __wp_postmeta_meta_value_changed; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER __wp_postmeta_meta_value_changed AFTER INSERT OR DELETE OR UPDATE OF meta_value ON wp_postmeta FOR EACH ROW EXECUTE PROCEDURE fn.__wp_postmeta_meta_value_changed();


--
-- Name: __wp_terms_deleted; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER __wp_terms_deleted AFTER DELETE ON wp_terms FOR EACH ROW EXECUTE PROCEDURE fn.__wp_terms_deleted();


--
-- Name: __wp_terms_slug_changed; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER __wp_terms_slug_changed AFTER INSERT OR UPDATE OF slug ON wp_terms FOR EACH ROW EXECUTE PROCEDURE fn.__wp_terms_slug_changed();


--
-- Name: tsv; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tsv BEFORE INSERT OR UPDATE OF post_content, post_title, post_name ON wp_posts FOR EACH ROW EXECUTE PROCEDURE fn.tsv();


--
-- Name: wp_commentmeta_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_commentmeta
    ADD CONSTRAINT wp_commentmeta_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES wp_comments("comment_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_comments_comment_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_comments
    ADD CONSTRAINT wp_comments_comment_parent_fkey FOREIGN KEY (comment_parent) REFERENCES wp_comments("comment_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_comments_comment_post_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_comments
    ADD CONSTRAINT "wp_comments_comment_post_ID_fkey" FOREIGN KEY ("comment_post_ID") REFERENCES wp_posts("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_comments
    ADD CONSTRAINT wp_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES wp_users("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_postmeta_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_postmeta
    ADD CONSTRAINT wp_postmeta_post_id_fkey FOREIGN KEY (post_id) REFERENCES wp_posts("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_posts_post_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_posts
    ADD CONSTRAINT wp_posts_post_parent_fkey FOREIGN KEY (post_parent) REFERENCES wp_posts("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_term_relationships_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_term_relationships
    ADD CONSTRAINT wp_term_relationships_object_id_fkey FOREIGN KEY (object_id) REFERENCES wp_posts("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_term_relationships_term_taxonomy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_term_relationships
    ADD CONSTRAINT wp_term_relationships_term_taxonomy_id_fkey FOREIGN KEY (term_taxonomy_id) REFERENCES wp_term_taxonomy(term_taxonomy_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_term_taxonomy_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_term_taxonomy
    ADD CONSTRAINT wp_term_taxonomy_parent_fkey FOREIGN KEY (parent) REFERENCES wp_terms(term_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_term_taxonomy_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_term_taxonomy
    ADD CONSTRAINT wp_term_taxonomy_term_id_fkey FOREIGN KEY (term_id) REFERENCES wp_terms(term_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_usermeta_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_usermeta
    ADD CONSTRAINT wp_usermeta_user_id_fkey FOREIGN KEY (user_id) REFERENCES wp_users("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_woocommerce_order_itemmeta_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_woocommerce_order_itemmeta
    ADD CONSTRAINT wp_woocommerce_order_itemmeta_order_item_id_fkey FOREIGN KEY (order_item_id) REFERENCES wp_woocommerce_order_items(order_item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_woocommerce_order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_woocommerce_order_items
    ADD CONSTRAINT wp_woocommerce_order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES wp_posts("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

