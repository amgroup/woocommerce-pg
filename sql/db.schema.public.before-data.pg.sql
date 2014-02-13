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

--
-- Name: wp_commentmeta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_commentmeta (
    meta_id bigint NOT NULL,
    comment_id bigint DEFAULT (0)::bigint NOT NULL,
    meta_key text,
    meta_value text
);


--
-- Name: wp_commentmeta_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_commentmeta_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_commentmeta_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_commentmeta_meta_id_seq OWNED BY wp_commentmeta.meta_id;


--
-- Name: wp_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_comments (
    "comment_ID" bigint NOT NULL,
    "comment_post_ID" bigint DEFAULT (0)::bigint NOT NULL,
    comment_author text NOT NULL,
    comment_author_email text NOT NULL,
    comment_author_url text NOT NULL,
    "comment_author_IP" text NOT NULL,
    comment_date timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    comment_date_gmt timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    comment_content text NOT NULL,
    comment_karma bigint DEFAULT (0)::bigint NOT NULL,
    comment_approved text DEFAULT '1'::text NOT NULL,
    comment_agent text NOT NULL,
    comment_type text NOT NULL,
    comment_parent bigint DEFAULT (0)::bigint NOT NULL,
    user_id bigint DEFAULT (0)::bigint NOT NULL
);


--
-- Name: wp_comments_comment_ID_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "wp_comments_comment_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_comments_comment_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "wp_comments_comment_ID_seq" OWNED BY wp_comments."comment_ID";


--
-- Name: wp_faq_termmeta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_faq_termmeta (
    meta_id bigint NOT NULL,
    faq_term_id bigint NOT NULL,
    meta_key text,
    meta_value text
);


--
-- Name: wp_faq_termmeta_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_faq_termmeta_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_faq_termmeta_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_faq_termmeta_meta_id_seq OWNED BY wp_faq_termmeta.meta_id;


--
-- Name: wp_links; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_links (
    link_id bigint NOT NULL,
    link_url text NOT NULL,
    link_name text NOT NULL,
    link_image text NOT NULL,
    link_target text NOT NULL,
    link_description text NOT NULL,
    link_visible text DEFAULT 'Y'::text NOT NULL,
    link_owner bigint DEFAULT (1)::bigint NOT NULL,
    link_rating bigint DEFAULT (0)::bigint NOT NULL,
    link_updated timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    link_rel text NOT NULL,
    link_notes text NOT NULL,
    link_rss text NOT NULL
);


--
-- Name: wp_links_link_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_links_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_links_link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_links_link_id_seq OWNED BY wp_links.link_id;


--
-- Name: wp_options; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_options (
    option_id bigint NOT NULL,
    option_name text NOT NULL,
    option_value text NOT NULL,
    autoload text DEFAULT 'yes'::text NOT NULL
);


--
-- Name: wp_options_option_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_options_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_options_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_options_option_id_seq OWNED BY wp_options.option_id;


--
-- Name: wp_postmeta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_postmeta (
    meta_id bigint NOT NULL,
    post_id bigint DEFAULT (0)::bigint NOT NULL,
    meta_key text,
    meta_value text
);


--
-- Name: wp_postmeta_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_postmeta_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_postmeta_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_postmeta_meta_id_seq OWNED BY wp_postmeta.meta_id;


--
-- Name: wp_posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_posts (
    "ID" bigint NOT NULL,
    post_author bigint DEFAULT (0)::bigint NOT NULL,
    post_date timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    post_date_gmt timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    post_content text NOT NULL,
    post_title text NOT NULL,
    post_excerpt text NOT NULL,
    post_status text DEFAULT 'publish'::text NOT NULL,
    comment_status text DEFAULT 'open'::text NOT NULL,
    ping_status text DEFAULT 'open'::text NOT NULL,
    post_password text NOT NULL,
    post_name text,
    to_ping text NOT NULL,
    pinged text NOT NULL,
    post_modified timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    post_modified_gmt timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    post_content_filtered text NOT NULL,
    post_parent bigint DEFAULT (0)::bigint NOT NULL,
    guid text,
    menu_order bigint DEFAULT (0)::bigint NOT NULL,
    post_type text DEFAULT 'post'::text NOT NULL,
    post_mime_type text,
    comment_count bigint DEFAULT (0)::bigint NOT NULL,
    tsv tsvector,
    tsv_updated timestamp with time zone
);


--
-- Name: wp_posts_ID_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "wp_posts_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_posts_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "wp_posts_ID_seq" OWNED BY wp_posts."ID";


--
-- Name: wp_term_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_term_relationships (
    object_id bigint DEFAULT (0)::bigint NOT NULL,
    term_taxonomy_id bigint DEFAULT (0)::bigint NOT NULL,
    term_order bigint DEFAULT (0)::bigint NOT NULL
);


--
-- Name: wp_term_taxonomy; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_term_taxonomy (
    term_taxonomy_id bigint NOT NULL,
    term_id bigint DEFAULT (0)::bigint NOT NULL,
    taxonomy text NOT NULL,
    description text,
    parent bigint DEFAULT (0)::bigint NOT NULL,
    count bigint DEFAULT (0)::bigint NOT NULL
);


--
-- Name: wp_term_taxonomy_term_taxonomy_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_term_taxonomy_term_taxonomy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_term_taxonomy_term_taxonomy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_term_taxonomy_term_taxonomy_id_seq OWNED BY wp_term_taxonomy.term_taxonomy_id;


--
-- Name: wp_terms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_terms (
    term_id bigint NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    term_group bigint DEFAULT (0)::bigint NOT NULL
);


--
-- Name: wp_terms_term_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_terms_term_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_terms_term_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_terms_term_id_seq OWNED BY wp_terms.term_id;


--
-- Name: wp_usermeta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_usermeta (
    umeta_id bigint NOT NULL,
    user_id bigint DEFAULT (0)::bigint NOT NULL,
    meta_key text,
    meta_value text
);


--
-- Name: wp_usermeta_umeta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_usermeta_umeta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_usermeta_umeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_usermeta_umeta_id_seq OWNED BY wp_usermeta.umeta_id;


--
-- Name: wp_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_users (
    "ID" bigint NOT NULL,
    user_login text NOT NULL,
    user_pass text NOT NULL,
    user_nicename text NOT NULL,
    user_email text NOT NULL,
    user_url text NOT NULL,
    user_registered timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    user_activation_key text,
    user_status bigint DEFAULT (0)::bigint NOT NULL,
    display_name text NOT NULL
);


--
-- Name: wp_users_ID_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "wp_users_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_users_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "wp_users_ID_seq" OWNED BY wp_users."ID";


--
-- Name: wp_woo_compare_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_woo_compare_categories (
    id bigint NOT NULL,
    category_name bytea NOT NULL,
    category_order bigint NOT NULL
);


--
-- Name: wp_woo_compare_categories_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_woo_compare_categories_fields (
    cat_id bigint NOT NULL,
    field_id bigint NOT NULL,
    field_order bigint NOT NULL
);


--
-- Name: wp_woo_compare_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_woo_compare_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_woo_compare_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_woo_compare_categories_id_seq OWNED BY wp_woo_compare_categories.id;


--
-- Name: wp_woo_compare_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_woo_compare_fields (
    id bigint NOT NULL,
    field_name bytea NOT NULL,
    field_key text NOT NULL,
    field_type text NOT NULL,
    default_value bytea NOT NULL,
    field_unit bytea NOT NULL,
    field_description bytea NOT NULL,
    field_order bigint NOT NULL
);


--
-- Name: wp_woo_compare_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_woo_compare_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_woo_compare_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_woo_compare_fields_id_seq OWNED BY wp_woo_compare_fields.id;


--
-- Name: wp_woocommerce_attribute_taxonomies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_woocommerce_attribute_taxonomies (
    attribute_id bigint NOT NULL,
    attribute_name text NOT NULL,
    attribute_label text,
    attribute_type text NOT NULL,
    attribute_orderby text NOT NULL,
    attribute_description text
);


--
-- Name: wp_woocommerce_attribute_taxonomies_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_woocommerce_attribute_taxonomies_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_woocommerce_attribute_taxonomies_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_woocommerce_attribute_taxonomies_attribute_id_seq OWNED BY wp_woocommerce_attribute_taxonomies.attribute_id;


--
-- Name: wp_woocommerce_downloadable_product_permissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_woocommerce_downloadable_product_permissions (
    download_id text NOT NULL,
    product_id bigint NOT NULL,
    order_id bigint DEFAULT (0)::bigint NOT NULL,
    order_key text NOT NULL,
    user_email text NOT NULL,
    user_id bigint,
    downloads_remaining text,
    access_granted timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    access_expires timestamp without time zone,
    download_count bigint DEFAULT (0)::bigint NOT NULL
);


--
-- Name: wp_woocommerce_order_itemmeta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_woocommerce_order_itemmeta (
    meta_id bigint NOT NULL,
    order_item_id bigint NOT NULL,
    meta_key text,
    meta_value text
);


--
-- Name: wp_woocommerce_order_itemmeta_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_woocommerce_order_itemmeta_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_woocommerce_order_itemmeta_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_woocommerce_order_itemmeta_meta_id_seq OWNED BY wp_woocommerce_order_itemmeta.meta_id;


--
-- Name: wp_woocommerce_order_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_woocommerce_order_items (
    order_item_id bigint NOT NULL,
    order_item_name text NOT NULL,
    order_item_type text NOT NULL,
    order_id bigint NOT NULL
);


--
-- Name: wp_woocommerce_order_items_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_woocommerce_order_items_order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_woocommerce_order_items_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_woocommerce_order_items_order_item_id_seq OWNED BY wp_woocommerce_order_items.order_item_id;


--
-- Name: wp_woocommerce_tax_rate_locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_woocommerce_tax_rate_locations (
    location_id bigint NOT NULL,
    location_code text NOT NULL,
    tax_rate_id bigint NOT NULL,
    location_type text NOT NULL
);


--
-- Name: wp_woocommerce_tax_rate_locations_location_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_woocommerce_tax_rate_locations_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_woocommerce_tax_rate_locations_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_woocommerce_tax_rate_locations_location_id_seq OWNED BY wp_woocommerce_tax_rate_locations.location_id;


--
-- Name: wp_woocommerce_tax_rates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_woocommerce_tax_rates (
    tax_rate_id bigint NOT NULL,
    tax_rate_country text NOT NULL,
    tax_rate_state text NOT NULL,
    tax_rate text NOT NULL,
    tax_rate_name text NOT NULL,
    tax_rate_priority bigint NOT NULL,
    tax_rate_compound bigint DEFAULT (0)::bigint NOT NULL,
    tax_rate_shipping bigint DEFAULT (1)::bigint NOT NULL,
    tax_rate_order bigint NOT NULL,
    tax_rate_class text NOT NULL
);


--
-- Name: wp_woocommerce_tax_rates_tax_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_woocommerce_tax_rates_tax_rate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_woocommerce_tax_rates_tax_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_woocommerce_tax_rates_tax_rate_id_seq OWNED BY wp_woocommerce_tax_rates.tax_rate_id;


--
-- Name: wp_woocommerce_termmeta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wp_woocommerce_termmeta (
    meta_id bigint NOT NULL,
    woocommerce_term_id bigint NOT NULL,
    meta_key text,
    meta_value text
);


--
-- Name: wp_woocommerce_termmeta_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wp_woocommerce_termmeta_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wp_woocommerce_termmeta_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wp_woocommerce_termmeta_meta_id_seq OWNED BY wp_woocommerce_termmeta.meta_id;


--
-- Name: meta_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_commentmeta ALTER COLUMN meta_id SET DEFAULT nextval('wp_commentmeta_meta_id_seq'::regclass);


--
-- Name: comment_ID; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_comments ALTER COLUMN "comment_ID" SET DEFAULT nextval('"wp_comments_comment_ID_seq"'::regclass);


--
-- Name: meta_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_faq_termmeta ALTER COLUMN meta_id SET DEFAULT nextval('wp_faq_termmeta_meta_id_seq'::regclass);


--
-- Name: link_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_links ALTER COLUMN link_id SET DEFAULT nextval('wp_links_link_id_seq'::regclass);


--
-- Name: option_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_options ALTER COLUMN option_id SET DEFAULT nextval('wp_options_option_id_seq'::regclass);


--
-- Name: meta_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_postmeta ALTER COLUMN meta_id SET DEFAULT nextval('wp_postmeta_meta_id_seq'::regclass);


--
-- Name: ID; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_posts ALTER COLUMN "ID" SET DEFAULT nextval('"wp_posts_ID_seq"'::regclass);


--
-- Name: term_taxonomy_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_term_taxonomy ALTER COLUMN term_taxonomy_id SET DEFAULT nextval('wp_term_taxonomy_term_taxonomy_id_seq'::regclass);


--
-- Name: term_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_terms ALTER COLUMN term_id SET DEFAULT nextval('wp_terms_term_id_seq'::regclass);


--
-- Name: umeta_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_usermeta ALTER COLUMN umeta_id SET DEFAULT nextval('wp_usermeta_umeta_id_seq'::regclass);


--
-- Name: ID; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_users ALTER COLUMN "ID" SET DEFAULT nextval('"wp_users_ID_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_woo_compare_categories ALTER COLUMN id SET DEFAULT nextval('wp_woo_compare_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_woo_compare_fields ALTER COLUMN id SET DEFAULT nextval('wp_woo_compare_fields_id_seq'::regclass);


--
-- Name: attribute_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_woocommerce_attribute_taxonomies ALTER COLUMN attribute_id SET DEFAULT nextval('wp_woocommerce_attribute_taxonomies_attribute_id_seq'::regclass);


--
-- Name: meta_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_woocommerce_order_itemmeta ALTER COLUMN meta_id SET DEFAULT nextval('wp_woocommerce_order_itemmeta_meta_id_seq'::regclass);


--
-- Name: order_item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_woocommerce_order_items ALTER COLUMN order_item_id SET DEFAULT nextval('wp_woocommerce_order_items_order_item_id_seq'::regclass);


--
-- Name: location_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_woocommerce_tax_rate_locations ALTER COLUMN location_id SET DEFAULT nextval('wp_woocommerce_tax_rate_locations_location_id_seq'::regclass);


--
-- Name: tax_rate_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_woocommerce_tax_rates ALTER COLUMN tax_rate_id SET DEFAULT nextval('wp_woocommerce_tax_rates_tax_rate_id_seq'::regclass);


--
-- Name: meta_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wp_woocommerce_termmeta ALTER COLUMN meta_id SET DEFAULT nextval('wp_woocommerce_termmeta_meta_id_seq'::regclass);


--
-- Name: public; Type: ACL; Schema: -; Owner: -
--

CREATE TABLE public.wp_woocommerce_rewrites
(
  rewrite_id bigserial,
  object_id bigint,
  uri text NOT NULL,
  object_type text,
  created timestamp without time zone DEFAULT (now())::timestamp without time zone,
  accessed timestamp without time zone DEFAULT now(),
  CONSTRAINT wp_woocommerce_rewrites_pkey PRIMARY KEY (rewrite_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.wp_woocommerce_rewrites
  OWNER TO wordpress;


REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

