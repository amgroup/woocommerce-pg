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
-- Name: wp_commentmeta; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_commentmeta (
    meta_id bigint NOT NULL,
    comment_id bigint DEFAULT (0)::bigint NOT NULL,
    meta_key text,
    meta_value text
);


ALTER TABLE public.wp_commentmeta OWNER TO wordpress;

--
-- Name: wp_commentmeta_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_commentmeta_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_commentmeta_meta_id_seq OWNER TO wordpress;

--
-- Name: wp_commentmeta_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_commentmeta_meta_id_seq OWNED BY wp_commentmeta.meta_id;


--
-- Name: wp_comments; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
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


ALTER TABLE public.wp_comments OWNER TO wordpress;

--
-- Name: wp_comments_comment_ID_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE "wp_comments_comment_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."wp_comments_comment_ID_seq" OWNER TO wordpress;

--
-- Name: wp_comments_comment_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE "wp_comments_comment_ID_seq" OWNED BY wp_comments."comment_ID";


--
-- Name: wp_faq_termmeta; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_faq_termmeta (
    meta_id bigint NOT NULL,
    faq_term_id bigint NOT NULL,
    meta_key text,
    meta_value text
);


ALTER TABLE public.wp_faq_termmeta OWNER TO wordpress;

--
-- Name: wp_faq_termmeta_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_faq_termmeta_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_faq_termmeta_meta_id_seq OWNER TO wordpress;

--
-- Name: wp_faq_termmeta_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_faq_termmeta_meta_id_seq OWNED BY wp_faq_termmeta.meta_id;


--
-- Name: wp_links; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
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


ALTER TABLE public.wp_links OWNER TO wordpress;

--
-- Name: wp_links_link_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_links_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_links_link_id_seq OWNER TO wordpress;

--
-- Name: wp_links_link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_links_link_id_seq OWNED BY wp_links.link_id;


--
-- Name: wp_options; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_options (
    option_id bigint NOT NULL,
    option_name text NOT NULL,
    option_value text NOT NULL,
    autoload text DEFAULT 'yes'::text NOT NULL
);


ALTER TABLE public.wp_options OWNER TO wordpress;

--
-- Name: wp_options.bak; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE "wp_options.bak" (
    option_id bigint NOT NULL,
    option_name text NOT NULL,
    option_value text NOT NULL,
    autoload text DEFAULT 'yes'::text NOT NULL
);


ALTER TABLE public."wp_options.bak" OWNER TO wordpress;

--
-- Name: wp_options_option_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_options_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_options_option_id_seq OWNER TO wordpress;

--
-- Name: wp_options_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_options_option_id_seq OWNED BY "wp_options.bak".option_id;


--
-- Name: wp_options_option_id_seq1; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_options_option_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_options_option_id_seq1 OWNER TO wordpress;

--
-- Name: wp_options_option_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_options_option_id_seq1 OWNED BY wp_options.option_id;


--
-- Name: wp_postmeta; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_postmeta (
    meta_id bigint NOT NULL,
    post_id bigint DEFAULT (0)::bigint NOT NULL,
    meta_key text,
    meta_value text
);


ALTER TABLE public.wp_postmeta OWNER TO wordpress;

--
-- Name: wp_postmeta_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_postmeta_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_postmeta_meta_id_seq OWNER TO wordpress;

--
-- Name: wp_postmeta_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_postmeta_meta_id_seq OWNED BY wp_postmeta.meta_id;


--
-- Name: wp_posts; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
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


ALTER TABLE public.wp_posts OWNER TO wordpress;

--
-- Name: wp_posts_ID_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE "wp_posts_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."wp_posts_ID_seq" OWNER TO wordpress;

--
-- Name: wp_posts_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE "wp_posts_ID_seq" OWNED BY wp_posts."ID";


--
-- Name: wp_term_relationships; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_term_relationships (
    object_id bigint DEFAULT (0)::bigint NOT NULL,
    term_taxonomy_id bigint DEFAULT (0)::bigint NOT NULL,
    term_order bigint DEFAULT (0)::bigint NOT NULL
);


ALTER TABLE public.wp_term_relationships OWNER TO wordpress;

--
-- Name: wp_term_taxonomy; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_term_taxonomy (
    term_taxonomy_id bigint NOT NULL,
    term_id bigint DEFAULT (0)::bigint NOT NULL,
    taxonomy text NOT NULL,
    description text,
    parent bigint DEFAULT (0)::bigint NOT NULL,
    count bigint DEFAULT (0)::bigint NOT NULL
);


ALTER TABLE public.wp_term_taxonomy OWNER TO wordpress;

--
-- Name: wp_term_taxonomy_term_taxonomy_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_term_taxonomy_term_taxonomy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_term_taxonomy_term_taxonomy_id_seq OWNER TO wordpress;

--
-- Name: wp_term_taxonomy_term_taxonomy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_term_taxonomy_term_taxonomy_id_seq OWNED BY wp_term_taxonomy.term_taxonomy_id;


--
-- Name: wp_terms; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_terms (
    term_id bigint NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    term_group bigint DEFAULT (0)::bigint NOT NULL
);


ALTER TABLE public.wp_terms OWNER TO wordpress;

--
-- Name: wp_terms_term_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_terms_term_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_terms_term_id_seq OWNER TO wordpress;

--
-- Name: wp_terms_term_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_terms_term_id_seq OWNED BY wp_terms.term_id;


--
-- Name: wp_usermeta; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_usermeta (
    umeta_id bigint NOT NULL,
    user_id bigint DEFAULT (0)::bigint NOT NULL,
    meta_key text,
    meta_value text
);


ALTER TABLE public.wp_usermeta OWNER TO wordpress;

--
-- Name: wp_usermeta_umeta_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_usermeta_umeta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_usermeta_umeta_id_seq OWNER TO wordpress;

--
-- Name: wp_usermeta_umeta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_usermeta_umeta_id_seq OWNED BY wp_usermeta.umeta_id;


--
-- Name: wp_users; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
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


ALTER TABLE public.wp_users OWNER TO wordpress;

--
-- Name: wp_users_ID_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE "wp_users_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."wp_users_ID_seq" OWNER TO wordpress;

--
-- Name: wp_users_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE "wp_users_ID_seq" OWNED BY wp_users."ID";


--
-- Name: wp_woo_compare_categories; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_woo_compare_categories (
    id bigint NOT NULL,
    category_name bytea NOT NULL,
    category_order bigint NOT NULL
);


ALTER TABLE public.wp_woo_compare_categories OWNER TO wordpress;

--
-- Name: wp_woo_compare_categories_fields; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_woo_compare_categories_fields (
    cat_id bigint NOT NULL,
    field_id bigint NOT NULL,
    field_order bigint NOT NULL
);


ALTER TABLE public.wp_woo_compare_categories_fields OWNER TO wordpress;

--
-- Name: wp_woo_compare_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_woo_compare_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_woo_compare_categories_id_seq OWNER TO wordpress;

--
-- Name: wp_woo_compare_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_woo_compare_categories_id_seq OWNED BY wp_woo_compare_categories.id;


--
-- Name: wp_woo_compare_fields; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
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


ALTER TABLE public.wp_woo_compare_fields OWNER TO wordpress;

--
-- Name: wp_woo_compare_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_woo_compare_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_woo_compare_fields_id_seq OWNER TO wordpress;

--
-- Name: wp_woo_compare_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_woo_compare_fields_id_seq OWNED BY wp_woo_compare_fields.id;


--
-- Name: wp_woocommerce_attribute_taxonomies; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_woocommerce_attribute_taxonomies (
    attribute_id bigint NOT NULL,
    attribute_name text NOT NULL,
    attribute_label text,
    attribute_type text NOT NULL,
    attribute_orderby text NOT NULL,
    attribute_description text
);


ALTER TABLE public.wp_woocommerce_attribute_taxonomies OWNER TO wordpress;

--
-- Name: wp_woocommerce_attribute_taxonomies_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_woocommerce_attribute_taxonomies_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_woocommerce_attribute_taxonomies_attribute_id_seq OWNER TO wordpress;

--
-- Name: wp_woocommerce_attribute_taxonomies_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_woocommerce_attribute_taxonomies_attribute_id_seq OWNED BY wp_woocommerce_attribute_taxonomies.attribute_id;


--
-- Name: wp_woocommerce_downloadable_product_permissions; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
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


ALTER TABLE public.wp_woocommerce_downloadable_product_permissions OWNER TO wordpress;

--
-- Name: wp_woocommerce_order_itemmeta; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_woocommerce_order_itemmeta (
    meta_id bigint NOT NULL,
    order_item_id bigint NOT NULL,
    meta_key text,
    meta_value text
);


ALTER TABLE public.wp_woocommerce_order_itemmeta OWNER TO wordpress;

--
-- Name: wp_woocommerce_order_itemmeta_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_woocommerce_order_itemmeta_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_woocommerce_order_itemmeta_meta_id_seq OWNER TO wordpress;

--
-- Name: wp_woocommerce_order_itemmeta_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_woocommerce_order_itemmeta_meta_id_seq OWNED BY wp_woocommerce_order_itemmeta.meta_id;


--
-- Name: wp_woocommerce_order_items; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_woocommerce_order_items (
    order_item_id bigint NOT NULL,
    order_item_name text NOT NULL,
    order_item_type text NOT NULL,
    order_id bigint NOT NULL
);


ALTER TABLE public.wp_woocommerce_order_items OWNER TO wordpress;

--
-- Name: wp_woocommerce_order_items_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_woocommerce_order_items_order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_woocommerce_order_items_order_item_id_seq OWNER TO wordpress;

--
-- Name: wp_woocommerce_order_items_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_woocommerce_order_items_order_item_id_seq OWNED BY wp_woocommerce_order_items.order_item_id;


--
-- Name: wp_woocommerce_tax_rate_locations; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_woocommerce_tax_rate_locations (
    location_id bigint NOT NULL,
    location_code text NOT NULL,
    tax_rate_id bigint NOT NULL,
    location_type text NOT NULL
);


ALTER TABLE public.wp_woocommerce_tax_rate_locations OWNER TO wordpress;

--
-- Name: wp_woocommerce_tax_rate_locations_location_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_woocommerce_tax_rate_locations_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_woocommerce_tax_rate_locations_location_id_seq OWNER TO wordpress;

--
-- Name: wp_woocommerce_tax_rate_locations_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_woocommerce_tax_rate_locations_location_id_seq OWNED BY wp_woocommerce_tax_rate_locations.location_id;


--
-- Name: wp_woocommerce_tax_rates; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
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


ALTER TABLE public.wp_woocommerce_tax_rates OWNER TO wordpress;

--
-- Name: wp_woocommerce_tax_rates_tax_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_woocommerce_tax_rates_tax_rate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_woocommerce_tax_rates_tax_rate_id_seq OWNER TO wordpress;

--
-- Name: wp_woocommerce_tax_rates_tax_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_woocommerce_tax_rates_tax_rate_id_seq OWNED BY wp_woocommerce_tax_rates.tax_rate_id;


--
-- Name: wp_woocommerce_termmeta; Type: TABLE; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE TABLE wp_woocommerce_termmeta (
    meta_id bigint NOT NULL,
    woocommerce_term_id bigint NOT NULL,
    meta_key text,
    meta_value text
);


ALTER TABLE public.wp_woocommerce_termmeta OWNER TO wordpress;

--
-- Name: wp_woocommerce_termmeta_meta_id_seq; Type: SEQUENCE; Schema: public; Owner: wordpress
--

CREATE SEQUENCE wp_woocommerce_termmeta_meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wp_woocommerce_termmeta_meta_id_seq OWNER TO wordpress;

--
-- Name: wp_woocommerce_termmeta_meta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wordpress
--

ALTER SEQUENCE wp_woocommerce_termmeta_meta_id_seq OWNED BY wp_woocommerce_termmeta.meta_id;


--
-- Name: meta_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_commentmeta ALTER COLUMN meta_id SET DEFAULT nextval('wp_commentmeta_meta_id_seq'::regclass);


--
-- Name: comment_ID; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_comments ALTER COLUMN "comment_ID" SET DEFAULT nextval('"wp_comments_comment_ID_seq"'::regclass);


--
-- Name: meta_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_faq_termmeta ALTER COLUMN meta_id SET DEFAULT nextval('wp_faq_termmeta_meta_id_seq'::regclass);


--
-- Name: link_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_links ALTER COLUMN link_id SET DEFAULT nextval('wp_links_link_id_seq'::regclass);


--
-- Name: option_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_options ALTER COLUMN option_id SET DEFAULT nextval('wp_options_option_id_seq1'::regclass);


--
-- Name: option_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY "wp_options.bak" ALTER COLUMN option_id SET DEFAULT nextval('wp_options_option_id_seq'::regclass);


--
-- Name: meta_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_postmeta ALTER COLUMN meta_id SET DEFAULT nextval('wp_postmeta_meta_id_seq'::regclass);


--
-- Name: ID; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_posts ALTER COLUMN "ID" SET DEFAULT nextval('"wp_posts_ID_seq"'::regclass);


--
-- Name: term_taxonomy_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_term_taxonomy ALTER COLUMN term_taxonomy_id SET DEFAULT nextval('wp_term_taxonomy_term_taxonomy_id_seq'::regclass);


--
-- Name: term_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_terms ALTER COLUMN term_id SET DEFAULT nextval('wp_terms_term_id_seq'::regclass);


--
-- Name: umeta_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_usermeta ALTER COLUMN umeta_id SET DEFAULT nextval('wp_usermeta_umeta_id_seq'::regclass);


--
-- Name: ID; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_users ALTER COLUMN "ID" SET DEFAULT nextval('"wp_users_ID_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_woo_compare_categories ALTER COLUMN id SET DEFAULT nextval('wp_woo_compare_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_woo_compare_fields ALTER COLUMN id SET DEFAULT nextval('wp_woo_compare_fields_id_seq'::regclass);


--
-- Name: attribute_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_woocommerce_attribute_taxonomies ALTER COLUMN attribute_id SET DEFAULT nextval('wp_woocommerce_attribute_taxonomies_attribute_id_seq'::regclass);


--
-- Name: meta_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_woocommerce_order_itemmeta ALTER COLUMN meta_id SET DEFAULT nextval('wp_woocommerce_order_itemmeta_meta_id_seq'::regclass);


--
-- Name: order_item_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_woocommerce_order_items ALTER COLUMN order_item_id SET DEFAULT nextval('wp_woocommerce_order_items_order_item_id_seq'::regclass);


--
-- Name: location_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_woocommerce_tax_rate_locations ALTER COLUMN location_id SET DEFAULT nextval('wp_woocommerce_tax_rate_locations_location_id_seq'::regclass);


--
-- Name: tax_rate_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_woocommerce_tax_rates ALTER COLUMN tax_rate_id SET DEFAULT nextval('wp_woocommerce_tax_rates_tax_rate_id_seq'::regclass);


--
-- Name: meta_id; Type: DEFAULT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_woocommerce_termmeta ALTER COLUMN meta_id SET DEFAULT nextval('wp_woocommerce_termmeta_meta_id_seq'::regclass);


--
-- Name: term_taxonomy_term_id_taxonomy_key; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_term_taxonomy
    ADD CONSTRAINT term_taxonomy_term_id_taxonomy_key UNIQUE (term_id, taxonomy);


--
-- Name: terms_slug_key; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_terms
    ADD CONSTRAINT terms_slug_key UNIQUE (slug);


--
-- Name: wp_commentmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_commentmeta
    ADD CONSTRAINT wp_commentmeta_pkey PRIMARY KEY (meta_id);


--
-- Name: wp_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_comments
    ADD CONSTRAINT wp_comments_pkey PRIMARY KEY ("comment_ID");


--
-- Name: wp_faq_termmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_faq_termmeta
    ADD CONSTRAINT wp_faq_termmeta_pkey PRIMARY KEY (meta_id);


--
-- Name: wp_links_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_links
    ADD CONSTRAINT wp_links_pkey PRIMARY KEY (link_id);


--
-- Name: wp_options_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY "wp_options.bak"
    ADD CONSTRAINT wp_options_pkey PRIMARY KEY (option_id);


--
-- Name: wp_options_pkey_new; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_options
    ADD CONSTRAINT wp_options_pkey_new PRIMARY KEY (option_id);


--
-- Name: wp_postmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_postmeta
    ADD CONSTRAINT wp_postmeta_pkey PRIMARY KEY (meta_id);


--
-- Name: wp_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_posts
    ADD CONSTRAINT wp_posts_pkey PRIMARY KEY ("ID");


--
-- Name: wp_term_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_term_relationships
    ADD CONSTRAINT wp_term_relationships_pkey PRIMARY KEY (object_id, term_taxonomy_id);


--
-- Name: wp_term_taxonomy_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_term_taxonomy
    ADD CONSTRAINT wp_term_taxonomy_pkey PRIMARY KEY (term_taxonomy_id);


--
-- Name: wp_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_terms
    ADD CONSTRAINT wp_terms_pkey PRIMARY KEY (term_id);


--
-- Name: wp_usermeta_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_usermeta
    ADD CONSTRAINT wp_usermeta_pkey PRIMARY KEY (umeta_id);


--
-- Name: wp_users_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_users
    ADD CONSTRAINT wp_users_pkey PRIMARY KEY ("ID");


--
-- Name: wp_woo_compare_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_woo_compare_categories
    ADD CONSTRAINT wp_woo_compare_categories_pkey PRIMARY KEY (id);


--
-- Name: wp_woo_compare_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_woo_compare_fields
    ADD CONSTRAINT wp_woo_compare_fields_pkey PRIMARY KEY (id);


--
-- Name: wp_woocommerce_attribute_taxonomies_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_attribute_taxonomies
    ADD CONSTRAINT wp_woocommerce_attribute_taxonomies_pkey PRIMARY KEY (attribute_id);


--
-- Name: wp_woocommerce_downloadable_product_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_downloadable_product_permissions
    ADD CONSTRAINT wp_woocommerce_downloadable_product_permissions_pkey PRIMARY KEY (product_id, order_id, order_key, download_id);


--
-- Name: wp_woocommerce_order_itemmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_order_itemmeta
    ADD CONSTRAINT wp_woocommerce_order_itemmeta_pkey PRIMARY KEY (meta_id);


--
-- Name: wp_woocommerce_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_order_items
    ADD CONSTRAINT wp_woocommerce_order_items_pkey PRIMARY KEY (order_item_id);


--
-- Name: wp_woocommerce_tax_rate_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_tax_rate_locations
    ADD CONSTRAINT wp_woocommerce_tax_rate_locations_pkey PRIMARY KEY (location_id);


--
-- Name: wp_woocommerce_tax_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_tax_rates
    ADD CONSTRAINT wp_woocommerce_tax_rates_pkey PRIMARY KEY (tax_rate_id);


--
-- Name: wp_woocommerce_termmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: wordpress; Tablespace: 
--

ALTER TABLE ONLY wp_woocommerce_termmeta
    ADD CONSTRAINT wp_woocommerce_termmeta_pkey PRIMARY KEY (meta_id);


--
-- Name: attribute_taxonomies_attribute_name_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX attribute_taxonomies_attribute_name_idx ON wp_woocommerce_attribute_taxonomies USING btree (attribute_name);


--
-- Name: commentmeta_comment_id_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX commentmeta_comment_id_idx ON wp_commentmeta USING btree (comment_id);


--
-- Name: commentmeta_meta_key_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX commentmeta_meta_key_idx ON wp_commentmeta USING btree (meta_key);


--
-- Name: commentmeta_meta_value_as_bigint_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX commentmeta_meta_value_as_bigint_idx ON wp_commentmeta USING btree (((meta_value)::bigint));


--
-- Name: commentmeta_meta_value_as_numeric_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX commentmeta_meta_value_as_numeric_idx ON wp_commentmeta USING btree (((meta_value)::numeric));


--
-- Name: commentmeta_meta_value_as_timestamp_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX commentmeta_meta_value_as_timestamp_idx ON wp_commentmeta USING btree (((meta_value)::timestamp without time zone));


--
-- Name: commentmeta_meta_value_as_timestamptz_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX commentmeta_meta_value_as_timestamptz_idx ON wp_commentmeta USING btree (((meta_value)::timestamp with time zone));


--
-- Name: comments_comment_approved_date_gmt_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX comments_comment_approved_date_gmt_idx ON wp_comments USING btree (comment_approved, comment_date_gmt);


--
-- Name: comments_comment_date_gmt_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX comments_comment_date_gmt_idx ON wp_comments USING btree (comment_date_gmt);


--
-- Name: comments_comment_parent_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX comments_comment_parent_idx ON wp_comments USING btree (comment_parent);


--
-- Name: comments_comment_post_id_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX comments_comment_post_id_idx ON wp_comments USING btree ("comment_post_ID");


--
-- Name: downloadable_product_permissions_download_order_product_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX downloadable_product_permissions_download_order_product_idx ON wp_woocommerce_downloadable_product_permissions USING btree (download_id, order_id, product_id);


--
-- Name: faq_termmeta_meta_value_as_bigint_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX faq_termmeta_meta_value_as_bigint_idx ON wp_faq_termmeta USING btree (((meta_value)::bigint));


--
-- Name: faq_termmeta_meta_value_as_numeric_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX faq_termmeta_meta_value_as_numeric_idx ON wp_faq_termmeta USING btree (((meta_value)::numeric));


--
-- Name: faq_termmeta_meta_value_as_timestamp_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX faq_termmeta_meta_value_as_timestamp_idx ON wp_faq_termmeta USING btree (((meta_value)::timestamp without time zone));


--
-- Name: faq_termmeta_meta_value_as_timestamptz_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX faq_termmeta_meta_value_as_timestamptz_idx ON wp_faq_termmeta USING btree (((meta_value)::timestamp with time zone));


--
-- Name: links_link_visible_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX links_link_visible_idx ON wp_links USING btree (link_visible);


--
-- Name: meta_key_like_attribute_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX meta_key_like_attribute_idx ON wp_postmeta USING btree (((meta_key ~ '^attribute_pa_'::text)));


--
-- Name: meta_key_like_keywords_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX meta_key_like_keywords_idx ON wp_postmeta USING btree (((meta_key ~ '-keywords$'::text)));


--
-- Name: meta_key_like_seofield_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX meta_key_like_seofield_idx ON wp_postmeta USING btree (((meta_key ~ '^seo-'::text)));


--
-- Name: meta_value_as_bigint_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX meta_value_as_bigint_idx ON wp_postmeta USING btree (((meta_value)::bigint));


--
-- Name: meta_value_as_numeric_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX meta_value_as_numeric_idx ON wp_postmeta USING btree (((meta_value)::numeric));


--
-- Name: meta_value_as_text512_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX meta_value_as_text512_idx ON wp_postmeta USING btree (fn.__particular__text__512__idx(meta_value));


--
-- Name: meta_value_as_timestamp_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX meta_value_as_timestamp_idx ON wp_postmeta USING btree (((meta_value)::timestamp without time zone));


--
-- Name: meta_value_as_timestamptz_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX meta_value_as_timestamptz_idx ON wp_postmeta USING btree (((meta_value)::timestamp with time zone));


--
-- Name: option_value_as_bigint_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX option_value_as_bigint_idx ON "wp_options.bak" USING btree (((option_value)::bigint));


--
-- Name: option_value_as_bigint_idx_new; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX option_value_as_bigint_idx_new ON wp_options USING btree (((option_value)::bigint));


--
-- Name: option_value_as_timestamp_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX option_value_as_timestamp_idx ON "wp_options.bak" USING btree (((option_value)::timestamp without time zone));


--
-- Name: option_value_as_timestamp_idx_new; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX option_value_as_timestamp_idx_new ON wp_options USING btree (((option_value)::timestamp without time zone));


--
-- Name: option_value_as_timestamptz_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX option_value_as_timestamptz_idx ON "wp_options.bak" USING btree (((option_value)::timestamp with time zone));


--
-- Name: option_value_as_timestamptz_idx_new; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX option_value_as_timestamptz_idx_new ON wp_options USING btree (((option_value)::timestamp with time zone));


--
-- Name: order_itemmeta_meta_key_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX order_itemmeta_meta_key_idx ON wp_woocommerce_order_itemmeta USING btree (meta_key);


--
-- Name: order_itemmeta_order_item_id_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX order_itemmeta_order_item_id_idx ON wp_woocommerce_order_itemmeta USING btree (order_item_id);


--
-- Name: order_items_order_id_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX order_items_order_id_idx ON wp_woocommerce_order_items USING btree (order_id);


--
-- Name: postmeta_meta_key_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX postmeta_meta_key_idx ON wp_postmeta USING btree (meta_key);


--
-- Name: postmeta_post_id_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX postmeta_post_id_idx ON wp_postmeta USING btree (post_id);


--
-- Name: posts_post_author_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX posts_post_author_idx ON wp_posts USING btree (post_author);


--
-- Name: posts_post_name_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX posts_post_name_idx ON wp_posts USING btree (post_name);


--
-- Name: posts_post_parent_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX posts_post_parent_idx ON wp_posts USING btree (post_parent);


--
-- Name: posts_tsv_updated_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX posts_tsv_updated_idx ON wp_posts USING btree (tsv_updated);


--
-- Name: posts_tsv_updated_is_null_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX posts_tsv_updated_is_null_idx ON wp_posts USING btree (((tsv_updated IS NULL)));


--
-- Name: posts_type_status_date_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX posts_type_status_date_idx ON wp_posts USING btree (post_type, post_status, post_date, "ID");


--
-- Name: tax_rate_locations_location_type_code_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX tax_rate_locations_location_type_code_idx ON wp_woocommerce_tax_rate_locations USING btree (location_type, location_code);


--
-- Name: tax_rate_locations_location_type_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX tax_rate_locations_location_type_idx ON wp_woocommerce_tax_rate_locations USING btree (location_type);


--
-- Name: tax_rates_tax_rate_class_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX tax_rates_tax_rate_class_idx ON wp_woocommerce_tax_rates USING btree (tax_rate_class);


--
-- Name: tax_rates_tax_rate_country_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX tax_rates_tax_rate_country_idx ON wp_woocommerce_tax_rates USING btree (tax_rate_country);


--
-- Name: tax_rates_tax_rate_priority_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX tax_rates_tax_rate_priority_idx ON wp_woocommerce_tax_rates USING btree (tax_rate_priority);


--
-- Name: tax_rates_tax_rate_state_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX tax_rates_tax_rate_state_idx ON wp_woocommerce_tax_rates USING btree (tax_rate_state);


--
-- Name: term_relationships_term_taxonomy_id_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX term_relationships_term_taxonomy_id_idx ON wp_term_relationships USING btree (term_taxonomy_id);


--
-- Name: term_taxonomy_taxonomy_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX term_taxonomy_taxonomy_idx ON wp_term_taxonomy USING btree (taxonomy);


--
-- Name: termmeta_meta_key_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX termmeta_meta_key_idx ON wp_woocommerce_termmeta USING btree (meta_key);


--
-- Name: termmeta_woocommerce_term_id_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX termmeta_woocommerce_term_id_idx ON wp_woocommerce_termmeta USING btree (woocommerce_term_id);


--
-- Name: terms_name_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX terms_name_idx ON wp_terms USING btree (name);


--
-- Name: usermeta_meta_key_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX usermeta_meta_key_idx ON wp_usermeta USING btree (meta_key);


--
-- Name: usermeta_meta_value_as_bigint_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX usermeta_meta_value_as_bigint_idx ON wp_usermeta USING btree (((meta_value)::bigint));


--
-- Name: usermeta_meta_value_as_numeric_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX usermeta_meta_value_as_numeric_idx ON wp_usermeta USING btree (((meta_value)::numeric));


--
-- Name: usermeta_meta_value_as_timestamp_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX usermeta_meta_value_as_timestamp_idx ON wp_usermeta USING btree (((meta_value)::timestamp without time zone));


--
-- Name: usermeta_meta_value_as_timestamptz_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX usermeta_meta_value_as_timestamptz_idx ON wp_usermeta USING btree (((meta_value)::timestamp with time zone));


--
-- Name: usermeta_user_id_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX usermeta_user_id_idx ON wp_usermeta USING btree (user_id);


--
-- Name: users_user_login_key_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX users_user_login_key_idx ON wp_users USING btree (user_login);


--
-- Name: users_user_nicename_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX users_user_nicename_idx ON wp_users USING btree (user_nicename);


--
-- Name: wp_options_regexp_replace_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX wp_options_regexp_replace_idx ON "wp_options.bak" USING btree (regexp_replace(option_name, '_wc_session.*_([^_]+)'::text, '\1'::text, ''::text));


--
-- Name: wp_options_regexp_replace_idx_new; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX wp_options_regexp_replace_idx_new ON wp_options USING btree (regexp_replace(option_name, '_wc_session.*_([^_]+)'::text, '\1'::text, ''::text));


--
-- Name: wp_posts_date_trunc_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX wp_posts_date_trunc_idx ON wp_posts USING btree (date_trunc('month'::text, post_date));


--
-- Name: wp_posts_post_type_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX wp_posts_post_type_idx ON wp_posts USING btree (post_type);


--
-- Name: wp_woo_compare_categories_fields_cat_id_idx; Type: INDEX; Schema: public; Owner: wordpress; Tablespace: 
--

CREATE INDEX wp_woo_compare_categories_fields_cat_id_idx ON wp_woo_compare_categories_fields USING btree (cat_id);


--
-- Name: tsv; Type: TRIGGER; Schema: public; Owner: wordpress
--

CREATE TRIGGER tsv BEFORE INSERT OR UPDATE OF post_content, post_title, post_name ON wp_posts FOR EACH ROW EXECUTE PROCEDURE fn.post_tsv();


--
-- Name: wp_commentmeta_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_commentmeta
    ADD CONSTRAINT wp_commentmeta_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES wp_comments("comment_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_comments_comment_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_comments
    ADD CONSTRAINT wp_comments_comment_parent_fkey FOREIGN KEY (comment_parent) REFERENCES wp_comments("comment_ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_comments_comment_post_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_comments
    ADD CONSTRAINT "wp_comments_comment_post_ID_fkey" FOREIGN KEY ("comment_post_ID") REFERENCES wp_posts("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_comments
    ADD CONSTRAINT wp_comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES wp_users("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_postmeta_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_postmeta
    ADD CONSTRAINT wp_postmeta_post_id_fkey FOREIGN KEY (post_id) REFERENCES wp_posts("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_posts_post_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_posts
    ADD CONSTRAINT wp_posts_post_parent_fkey FOREIGN KEY (post_parent) REFERENCES wp_posts("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_term_relationships_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_term_relationships
    ADD CONSTRAINT wp_term_relationships_object_id_fkey FOREIGN KEY (object_id) REFERENCES wp_posts("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_term_relationships_term_taxonomy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_term_relationships
    ADD CONSTRAINT wp_term_relationships_term_taxonomy_id_fkey FOREIGN KEY (term_taxonomy_id) REFERENCES wp_term_taxonomy(term_taxonomy_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_term_taxonomy_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_term_taxonomy
    ADD CONSTRAINT wp_term_taxonomy_parent_fkey FOREIGN KEY (parent) REFERENCES wp_terms(term_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_term_taxonomy_term_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_term_taxonomy
    ADD CONSTRAINT wp_term_taxonomy_term_id_fkey FOREIGN KEY (term_id) REFERENCES wp_terms(term_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_usermeta_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_usermeta
    ADD CONSTRAINT wp_usermeta_user_id_fkey FOREIGN KEY (user_id) REFERENCES wp_users("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_woocommerce_order_itemmeta_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_woocommerce_order_itemmeta
    ADD CONSTRAINT wp_woocommerce_order_itemmeta_order_item_id_fkey FOREIGN KEY (order_item_id) REFERENCES wp_woocommerce_order_items(order_item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wp_woocommerce_order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: wordpress
--

ALTER TABLE ONLY wp_woocommerce_order_items
    ADD CONSTRAINT wp_woocommerce_order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES wp_posts("ID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

