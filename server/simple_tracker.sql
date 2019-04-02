--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.2

-- Started on 2019-04-02 16:05:21 EDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE simple_tracker;
--
-- TOC entry 3339 (class 1262 OID 17048)
-- Name: simple_tracker; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE simple_tracker WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE simple_tracker OWNER TO postgres;

\connect simple_tracker

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 232 (class 1255 OID 24599)
-- Name: before_delete_set_balance(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.before_delete_set_balance() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
UPDATE public.transactions_user SET balance = balance - old.amount where id = old.user_id;
RAISE NOTICE 'Deleting';
return old;
END;$$;


ALTER FUNCTION public.before_delete_set_balance() OWNER TO postgres;

--
-- TOC entry 219 (class 1255 OID 17265)
-- Name: before_insert_set_balance(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.before_insert_set_balance() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
UPDATE public.transactions_user SET balance = balance + new.amount where id = new.user_id;

return new;
END;$$;


ALTER FUNCTION public.before_insert_set_balance() OWNER TO postgres;

--
-- TOC entry 3340 (class 0 OID 0)
-- Dependencies: 219
-- Name: FUNCTION before_insert_set_balance(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.before_insert_set_balance() IS 'Set the balance in the user table when the user transaction is created';


--
-- TOC entry 233 (class 1255 OID 24602)
-- Name: before_update_set_balance(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.before_update_set_balance() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
UPDATE public.transactions_user SET balance = balance + new.amount -old.amount where id = new.user_id;

return new;
END;$$;


ALTER FUNCTION public.before_update_set_balance() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 203 (class 1259 OID 17080)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO "Student_06";

--
-- TOC entry 202 (class 1259 OID 17078)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: Student_06
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO "Student_06";

--
-- TOC entry 3341 (class 0 OID 0)
-- Dependencies: 202
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Student_06
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- TOC entry 205 (class 1259 OID 17090)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO "Student_06";

--
-- TOC entry 204 (class 1259 OID 17088)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: Student_06
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO "Student_06";

--
-- TOC entry 3342 (class 0 OID 0)
-- Dependencies: 204
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Student_06
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- TOC entry 201 (class 1259 OID 17072)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO "Student_06";

--
-- TOC entry 200 (class 1259 OID 17070)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: Student_06
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO "Student_06";

--
-- TOC entry 3343 (class 0 OID 0)
-- Dependencies: 200
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Student_06
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- TOC entry 213 (class 1259 OID 17179)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO "Student_06";

--
-- TOC entry 212 (class 1259 OID 17177)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: Student_06
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO "Student_06";

--
-- TOC entry 3344 (class 0 OID 0)
-- Dependencies: 212
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Student_06
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- TOC entry 199 (class 1259 OID 17062)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO "Student_06";

--
-- TOC entry 198 (class 1259 OID 17060)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: Student_06
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO "Student_06";

--
-- TOC entry 3345 (class 0 OID 0)
-- Dependencies: 198
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Student_06
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- TOC entry 197 (class 1259 OID 17051)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO "Student_06";

--
-- TOC entry 196 (class 1259 OID 17049)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: Student_06
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO "Student_06";

--
-- TOC entry 3346 (class 0 OID 0)
-- Dependencies: 196
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Student_06
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- TOC entry 214 (class 1259 OID 17201)
-- Name: django_session; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO "Student_06";

--
-- TOC entry 218 (class 1259 OID 17231)
-- Name: transactions_image; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.transactions_image (
    id integer NOT NULL,
    image text NOT NULL,
    transaction_id integer NOT NULL
);


ALTER TABLE public.transactions_image OWNER TO "Student_06";

--
-- TOC entry 217 (class 1259 OID 17229)
-- Name: transactions_image_id_seq; Type: SEQUENCE; Schema: public; Owner: Student_06
--

CREATE SEQUENCE public.transactions_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_image_id_seq OWNER TO "Student_06";

--
-- TOC entry 3347 (class 0 OID 0)
-- Dependencies: 217
-- Name: transactions_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Student_06
--

ALTER SEQUENCE public.transactions_image_id_seq OWNED BY public.transactions_image.id;


--
-- TOC entry 216 (class 1259 OID 17213)
-- Name: transactions_transaction; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.transactions_transaction (
    id integer NOT NULL,
    amount numeric(9,2) NOT NULL,
    description character varying(70) NOT NULL,
    comment text NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    user_id integer NOT NULL,
    is_expense boolean NOT NULL
);


ALTER TABLE public.transactions_transaction OWNER TO "Student_06";

--
-- TOC entry 215 (class 1259 OID 17211)
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: Student_06
--

CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_transaction_id_seq OWNER TO "Student_06";

--
-- TOC entry 3348 (class 0 OID 0)
-- Dependencies: 215
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Student_06
--

ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions_transaction.id;


--
-- TOC entry 207 (class 1259 OID 17121)
-- Name: transactions_user; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.transactions_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    balance numeric(22,2) NOT NULL,
    avatar text NOT NULL,
    CONSTRAINT postitive_balance CHECK ((balance >= (0)::numeric))
);


ALTER TABLE public.transactions_user OWNER TO "Student_06";

--
-- TOC entry 3349 (class 0 OID 0)
-- Dependencies: 207
-- Name: CONSTRAINT postitive_balance ON transactions_user; Type: COMMENT; Schema: public; Owner: Student_06
--

COMMENT ON CONSTRAINT postitive_balance ON public.transactions_user IS 'The user balance has to be positive or cero.';


--
-- TOC entry 209 (class 1259 OID 17134)
-- Name: transactions_user_groups; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.transactions_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.transactions_user_groups OWNER TO "Student_06";

--
-- TOC entry 208 (class 1259 OID 17132)
-- Name: transactions_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: Student_06
--

CREATE SEQUENCE public.transactions_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_user_groups_id_seq OWNER TO "Student_06";

--
-- TOC entry 3350 (class 0 OID 0)
-- Dependencies: 208
-- Name: transactions_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Student_06
--

ALTER SEQUENCE public.transactions_user_groups_id_seq OWNED BY public.transactions_user_groups.id;


--
-- TOC entry 206 (class 1259 OID 17119)
-- Name: transactions_user_id_seq; Type: SEQUENCE; Schema: public; Owner: Student_06
--

CREATE SEQUENCE public.transactions_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_user_id_seq OWNER TO "Student_06";

--
-- TOC entry 3351 (class 0 OID 0)
-- Dependencies: 206
-- Name: transactions_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Student_06
--

ALTER SEQUENCE public.transactions_user_id_seq OWNED BY public.transactions_user.id;


--
-- TOC entry 211 (class 1259 OID 17142)
-- Name: transactions_user_user_permissions; Type: TABLE; Schema: public; Owner: Student_06
--

CREATE TABLE public.transactions_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.transactions_user_user_permissions OWNER TO "Student_06";

--
-- TOC entry 210 (class 1259 OID 17140)
-- Name: transactions_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: Student_06
--

CREATE SEQUENCE public.transactions_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_user_user_permissions_id_seq OWNER TO "Student_06";

--
-- TOC entry 3352 (class 0 OID 0)
-- Dependencies: 210
-- Name: transactions_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Student_06
--

ALTER SEQUENCE public.transactions_user_user_permissions_id_seq OWNED BY public.transactions_user_user_permissions.id;


--
-- TOC entry 3113 (class 2604 OID 17083)
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- TOC entry 3114 (class 2604 OID 17093)
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 3112 (class 2604 OID 17075)
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- TOC entry 3119 (class 2604 OID 17182)
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- TOC entry 3111 (class 2604 OID 17065)
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- TOC entry 3110 (class 2604 OID 17054)
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- TOC entry 3122 (class 2604 OID 17234)
-- Name: transactions_image id; Type: DEFAULT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_image ALTER COLUMN id SET DEFAULT nextval('public.transactions_image_id_seq'::regclass);


--
-- TOC entry 3121 (class 2604 OID 17216)
-- Name: transactions_transaction id; Type: DEFAULT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_transaction ALTER COLUMN id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);


--
-- TOC entry 3115 (class 2604 OID 17124)
-- Name: transactions_user id; Type: DEFAULT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user ALTER COLUMN id SET DEFAULT nextval('public.transactions_user_id_seq'::regclass);


--
-- TOC entry 3117 (class 2604 OID 17137)
-- Name: transactions_user_groups id; Type: DEFAULT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user_groups ALTER COLUMN id SET DEFAULT nextval('public.transactions_user_groups_id_seq'::regclass);


--
-- TOC entry 3118 (class 2604 OID 17145)
-- Name: transactions_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.transactions_user_user_permissions_id_seq'::regclass);


--
-- TOC entry 3318 (class 0 OID 17080)
-- Dependencies: 203
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: Student_06
--



--
-- TOC entry 3320 (class 0 OID 17090)
-- Dependencies: 205
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: Student_06
--



--
-- TOC entry 3316 (class 0 OID 17072)
-- Dependencies: 201
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: Student_06
--

INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (21, 'Can add user', 6, 'add_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (22, 'Can change user', 6, 'change_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (23, 'Can delete user', 6, 'delete_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (24, 'Can view user', 6, 'view_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (25, 'Can add transaction', 7, 'add_transaction');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (26, 'Can change transaction', 7, 'change_transaction');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (27, 'Can delete transaction', 7, 'delete_transaction');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (28, 'Can view transaction', 7, 'view_transaction');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (29, 'Can add image', 8, 'add_image');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (30, 'Can change image', 8, 'change_image');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (31, 'Can delete image', 8, 'delete_image');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (32, 'Can view image', 8, 'view_image');


--
-- TOC entry 3328 (class 0 OID 17179)
-- Dependencies: 213
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: Student_06
--



--
-- TOC entry 3314 (class 0 OID 17062)
-- Dependencies: 199
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: Student_06
--

INSERT INTO public.django_content_type (id, app_label, model) VALUES (1, 'admin', 'logentry');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (2, 'auth', 'permission');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (3, 'auth', 'group');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (5, 'sessions', 'session');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (6, 'transactions', 'user');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (7, 'transactions', 'transaction');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (8, 'transactions', 'image');


--
-- TOC entry 3312 (class 0 OID 17051)
-- Dependencies: 197
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: Student_06
--

INSERT INTO public.django_migrations (id, app, name, applied) VALUES (1, 'contenttypes', '0001_initial', '2019-02-26 17:16:51.463716-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2019-02-26 17:16:51.503079-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (3, 'auth', '0001_initial', '2019-02-26 17:16:51.589804-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2019-02-26 17:16:51.604673-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (5, 'auth', '0003_alter_user_email_max_length', '2019-02-26 17:16:51.618514-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (6, 'auth', '0004_alter_user_username_opts', '2019-02-26 17:16:51.630852-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (7, 'auth', '0005_alter_user_last_login_null', '2019-02-26 17:16:51.643678-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (8, 'auth', '0006_require_contenttypes_0002', '2019-02-26 17:16:51.647244-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2019-02-26 17:16:51.658796-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (10, 'auth', '0008_alter_user_username_max_length', '2019-02-26 17:16:51.673792-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2019-02-26 17:16:51.684295-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (12, 'transactions', '0001_initial', '2019-02-26 17:33:25.722169-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (13, 'admin', '0001_initial', '2019-02-26 17:33:25.775349-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (14, 'admin', '0002_logentry_remove_auto_add', '2019-02-26 17:33:25.789957-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (15, 'admin', '0003_logentry_add_action_flag_choices', '2019-02-26 17:33:25.809544-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (16, 'sessions', '0001_initial', '2019-02-26 17:33:25.846303-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (17, 'transactions', '0002_auto_20190226_2239', '2019-02-26 17:39:19.875679-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (18, 'transactions', '0003_transaction', '2019-02-26 18:21:16.279282-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (19, 'transactions', '0004_image', '2019-02-26 19:51:49.762085-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (20, 'transactions', '0005_auto_20190302_0426', '2019-03-01 23:27:17.398004-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (21, 'transactions', '0006_auto_20190302_0434', '2019-03-01 23:34:35.415259-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (22, 'transactions', '0007_auto_20190302_0455', '2019-03-01 23:55:58.81487-05');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (23, 'transactions', '0008_auto_20190302_0513', '2019-03-02 00:13:03.154824-05');


--
-- TOC entry 3329 (class 0 OID 17201)
-- Dependencies: 214
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: Student_06
--

INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('esctlpz7r763srvde9d9vs2rjfjnpjpm', 'MTEzNjJiN2EzNGEzNDRjMTQxNDJiNGM3NThjNjAzYmFhMGUwMGU3YTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjYjBiNjk0NmI3N2M5ZDY0N2UyOTUwMjk3MmU0OTkwZTYwZWNhOTA0In0=', '2019-03-14 15:12:42.256544-04');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('nsfoz6ntz5usjilb6x8droxbsux4gda8', 'MTEzNjJiN2EzNGEzNDRjMTQxNDJiNGM3NThjNjAzYmFhMGUwMGU3YTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjYjBiNjk0NmI3N2M5ZDY0N2UyOTUwMjk3MmU0OTkwZTYwZWNhOTA0In0=', '2019-03-14 15:19:33.05379-04');
INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('682ap9ocsnoy9eat71q749u00w772jzs', 'MTEzNjJiN2EzNGEzNDRjMTQxNDJiNGM3NThjNjAzYmFhMGUwMGU3YTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjYjBiNjk0NmI3N2M5ZDY0N2UyOTUwMjk3MmU0OTkwZTYwZWNhOTA0In0=', '2019-03-21 19:40:24.355959-04');


--
-- TOC entry 3333 (class 0 OID 17231)
-- Dependencies: 218
-- Data for Name: transactions_image; Type: TABLE DATA; Schema: public; Owner: Student_06
--



--
-- TOC entry 3331 (class 0 OID 17213)
-- Dependencies: 216
-- Data for Name: transactions_transaction; Type: TABLE DATA; Schema: public; Owner: Student_06
--

INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (39, 10.00, 'pass', 'lksajdas', '2019-03-02', '20:05:37', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (40, -10.00, 'pass', 'lksajdas', '2019-03-02', '20:05:37', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (41, -10.00, 'aksjdasd', 'lkdajsdas', '2019-03-02', '21:21:32', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (42, -1000.00, 'Sta', 'alskd', '2019-03-02', '21:23:45', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (43, -10.00, 'asd', 'asdasd', '2019-03-03', '20:25:35', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (44, -10.00, 'asd', 'asdasd', '2019-03-03', '20:25:35', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (45, -10.00, 'asd', 'asdasd', '2019-03-03', '20:25:35', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (46, -10.00, 'asd', 'asdasd', '2019-03-03', '20:25:35', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (48, -10.00, 'asd', 'asdasd', '2019-03-03', '20:25:35', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (49, -10.00, 'asd', 'asdasd', '2019-03-03', '20:25:35', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (50, -10.00, 'asd', 'asdasd', '2019-03-03', '20:25:35', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (51, -10.00, 'asd', 'asdasd', '2019-03-03', '20:25:35', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (94, 50000.00, 'More money', 'All the money!', '2019-03-06', '16:21:42', 20, false);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (95, -1000.00, 'paid Stanley', 'I owe him money', '2019-03-06', '16:25:19', 20, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (60, -100.00, 'prueba', 'comentario', '2019-03-03', '13:02:00', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (101, 10.00, 'klsajd', 'askjdlsjd', '2019-03-08', '00:46:13', 24, false);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (102, 1000.00, 'aslkdjalsjd', '', '2019-03-09', '20:50:02', 2, false);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (103, 1000.00, 'lkasjdaslkj', '', '2019-03-09', '20:50:41', 25, false);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (104, 1000.00, 'klajsdlkjasd', '', '2019-03-10', '04:29:02', 2, false);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (106, -10.00, 'lkdasjd', '', '2019-03-10', '07:07:00', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (53, 10.00, 'asd0909890', 'asdasd', '2019-03-03', '20:25:35', 2, false);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (72, 5.00, 'asdsa', 'asdas', '2019-03-06', '00:14:15', 8, false);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (73, -5.00, 'asdsad', '', '2019-03-06', '00:16:24', 8, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (81, -10.00, 'msand', 'klsadj', '2019-03-06', '04:45:30', 2, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (83, 100.00, 'primer ingreso', '', '2019-03-06', '05:48:16', 12, false);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (84, -10.00, 'ksljad', 'klasdj', '2019-03-06', '05:50:29', 12, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (85, -10.00, 'lksda', '', '2019-03-06', '05:59:39', 12, true);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (86, 10.00, 'klasjd', 'lkajsd', '2019-03-06', '05:59:50', 13, false);
INSERT INTO public.transactions_transaction (id, amount, description, comment, date, "time", user_id, is_expense) VALUES (87, 5.00, 'Income', '', '2019-03-06', '14:13:20', 14, false);


--
-- TOC entry 3322 (class 0 OID 17121)
-- Dependencies: 207
-- Data for Name: transactions_user; Type: TABLE DATA; Schema: public; Owner: Student_06
--

INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (12, 'pbkdf2_sha256$120000$QXeNET5xm2mB$KleFVWnyjqKtX7rRlAkLShHV2m4+ldd3eAqdHKmTPgo=', NULL, false, 'luis', 'Luis', 'Alberto', 'luis@gmail.com', false, true, '2019-03-06 00:49:21.835149-05', 80.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (13, 'pbkdf2_sha256$120000$uo7XX9Oagg4m$tf2q/8WzGMibr1I372b3b5u5MJUrhljALJtcxktea8Q=', NULL, false, 'oneil', 'Oneil', 'Pena', 'oneil@gmail.com', false, true, '2019-03-06 01:00:30.574609-05', 10.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (22, 'pbkdf2_sha256$120000$B7RW809inKx9$YEoD47CwQDn87YcHgxfh8MynA+9tvQ7c+TAT4Dqfh88=', '2019-03-07 18:35:08.813046-05', false, 'stormie', 'Stormie', 'Evans', 'evans@hotmail.com', false, true, '2019-03-07 18:32:04.579014-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (14, 'pbkdf2_sha256$120000$7abq2oIok47K$WFpHBwudIYs5zA6rYi7Tg/SbKgByVK75r5P+WRznLLM=', NULL, false, 'roth', 'Michael', 'Roth', 'roth@hotmail.com', false, true, '2019-03-06 09:13:53.056617-05', 5.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (15, 'pbkdf2_sha256$120000$BqlZHCYtHHdL$Av8wzX8orShAQeyWxt6CZc1QjFcgoHjdrV4aHjXk+A0=', NULL, false, 'bryant', 'Bryan', 'Perez', 'bryant@gmail.com', false, true, '2019-03-06 09:34:52.21771-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (17, 'pbkdf2_sha256$120000$AnbVZNPXDHGt$YrlC3PbigLzEgUSX5sJy7hwtvpjgf9Buh9dBggx0DJA=', NULL, false, 'json', 'Jason', 'perez', 'json@gmail.com', false, true, '2019-03-06 09:37:49.894788-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (3, 'pbkdf2_sha256$120000$0BmykXTe10uJ$2MeWIUvSz0/F6n1kjEHrayJeCUER2NTVMDD3pD/gSYk=', NULL, false, 'aaron', '', '', 'aaron@gmail.com', false, true, '2019-03-05 18:45:46.559691-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (4, 'pbkdf2_sha256$120000$PNfEsz02FOJe$MGfdXh5BJszDD7PqiTwUpDW4VM6lmtH9Q0k1OkTKgww=', NULL, false, 'ash', 'Ashley', 'Guzman', 'ash@gmail.com', false, true, '2019-03-05 18:48:28.044481-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (5, 'pbkdf2_sha256$120000$vvMGGw2C5zJu$5GZaeWr+DlKdmvrKbPq7Ra29DdIYPMEUaiQu+qIdgRo=', NULL, false, 'rachel', '', '', 'kalsjds@gmail.com', false, true, '2019-03-05 19:06:27.939075-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (6, 'pbkdf2_sha256$120000$2bvIGbJOQuJH$O5L0d/zhrDWdVV7iRsg46Tdc9FBrqzwX44XXlSizjnM=', NULL, false, 'erika', 'erika', 'genora', 'erika@gmail.com', false, true, '2019-03-05 19:11:12.71711-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (7, 'pbkdf2_sha256$120000$Io4GBIQUkLkR$kAgzYaLNAZIdxHyLSDvTxTc2TWNwqTDqjuAc1z3CvAs=', NULL, false, 'danny', 'danny', '', 'danny@gmail.com', false, true, '2019-03-05 19:13:30.472502-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (18, 'pbkdf2_sha256$120000$Nzk0Dgd4P7fZ$zrmOPmnU58W2Is1EJEn5FNbaaJ0zU/9v932ZNFUlHEs=', NULL, false, 'richard', 'Richard', 'Perez', 'perez@gmail.com', false, true, '2019-03-06 09:42:48.127511-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (8, 'pbkdf2_sha256$120000$Di9AvEMRnyXU$yjX4lRSXPKUnZvhQeKrCJqb3t4V0aNY2MbwXbFuIwmI=', NULL, false, 'kwadow', '', '', 'kwadow@gmail.com', false, true, '2019-03-05 19:14:38.768193-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (9, 'pbkdf2_sha256$120000$XXBwHpttY4eb$eAEpXX3hfrquUxDX17wb6HMui4UOv+BdqOR8y/FQDoU=', NULL, false, 'irene', 'Irene', 'Gonzalez', 'irene@gmail.com', false, true, '2019-03-05 23:27:47.0157-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (11, 'pbkdf2_sha256$120000$cx0JCo3M4HKP$Xrb0kodCurqTYnhmeFs5UI3QY+NErT8lIsuKFjgn1jA=', NULL, false, 'alex', 'Alex', 'Peralez', 'alex@gmail.com', false, true, '2019-03-05 23:32:34.194507-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (25, 'pbkdf2_sha256$120000$JnQ64IqA8Z0U$k/PQB2k4SzZxJFxnd+FwY9ZmHoRMiYhxTMDVHIe4F/Q=', '2019-03-09 16:00:27.667565-05', false, 'beltran', 'irene', 'gonzalez', 'beltran@gmail.com', false, true, '2019-03-09 16:00:27.237456-05', 1000.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (20, 'pbkdf2_sha256$120000$bUZRodTdjmqO$VUMSfeGH7taqDk3CvVBGQxJFTmfdEkgu2Yma7FcYSVE=', NULL, false, 'Stve', '', '', 'v@gmail.com', false, true, '2019-03-06 11:24:17.590467-05', 49000.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (19, 'pbkdf2_sha256$120000$R1y4cw28T0WA$ikTnImyeNG86zTu7ktA9X1tJwgEDV6GnUpVCns/leKM=', '2019-03-06 09:59:03.88832-05', false, 'krys', 'Krystina', 'Sopova', 'krys@gmail.com', false, true, '2019-03-06 09:59:03.407317-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (21, 'pbkdf2_sha256$120000$I17AiMjNHsjT$6FM7gU1I3ovlZfMx80BEoPtPzj3k6H7876d2ahH3mXM=', NULL, false, 'chuck24', 'Charlie', 'shep', 'charlie@charlie.com', false, true, '2019-03-06 11:29:23.253401-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (23, 'pbkdf2_sha256$120000$vmJgXOExqwsD$JhZKJfOTR3mkXG5GyNM2Hfq1Xwwykdj3fWM4JaK27bM=', '2019-03-07 19:41:30.727936-05', false, 'rich', 'Richard', 'Lee', 'ajkhsdkajshd@kalsjdlkas.com', false, true, '2019-03-07 19:41:30.243269-05', 0.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (2, 'pbkdf2_sha256$120000$Sj9BxCbZ7CBb$v0uDyfBOeGDn7AfxtzS3SUrmBDJ62tZsHUMJDY1u+BQ=', '2019-03-10 03:08:19.412602-04', true, 'bestanly', '', '', 'ibestanly@gmail.com', true, true, '2019-02-26 17:39:41.533757-05', 4160.00, '');
INSERT INTO public.transactions_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, balance, avatar) VALUES (24, 'pbkdf2_sha256$120000$8voyf8OK5cjc$WhVE/3NKzGhXWKjfKb7iseau2RfkWMAdWwhG4FLVRWw=', NULL, false, 'jose', 'jose', 'pe', 'jose@gmail.com', false, true, '2019-03-07 19:48:09.849043-05', 10.00, '');


--
-- TOC entry 3324 (class 0 OID 17134)
-- Dependencies: 209
-- Data for Name: transactions_user_groups; Type: TABLE DATA; Schema: public; Owner: Student_06
--



--
-- TOC entry 3326 (class 0 OID 17142)
-- Dependencies: 211
-- Data for Name: transactions_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: Student_06
--



--
-- TOC entry 3353 (class 0 OID 0)
-- Dependencies: 202
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Student_06
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 3354 (class 0 OID 0)
-- Dependencies: 204
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Student_06
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 3355 (class 0 OID 0)
-- Dependencies: 200
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Student_06
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 32, true);


--
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 212
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Student_06
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- TOC entry 3357 (class 0 OID 0)
-- Dependencies: 198
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Student_06
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 8, true);


--
-- TOC entry 3358 (class 0 OID 0)
-- Dependencies: 196
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Student_06
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 23, true);


--
-- TOC entry 3359 (class 0 OID 0)
-- Dependencies: 217
-- Name: transactions_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Student_06
--

SELECT pg_catalog.setval('public.transactions_image_id_seq', 1, false);


--
-- TOC entry 3360 (class 0 OID 0)
-- Dependencies: 215
-- Name: transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Student_06
--

SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 106, true);


--
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 208
-- Name: transactions_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Student_06
--

SELECT pg_catalog.setval('public.transactions_user_groups_id_seq', 1, false);


--
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 206
-- Name: transactions_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Student_06
--

SELECT pg_catalog.setval('public.transactions_user_id_seq', 25, true);


--
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 210
-- Name: transactions_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Student_06
--

SELECT pg_catalog.setval('public.transactions_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 3136 (class 2606 OID 17087)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 3141 (class 2606 OID 17116)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 3144 (class 2606 OID 17095)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3138 (class 2606 OID 17085)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3131 (class 2606 OID 17102)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 3133 (class 2606 OID 17077)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3164 (class 2606 OID 17188)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3126 (class 2606 OID 17069)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 3128 (class 2606 OID 17067)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3124 (class 2606 OID 17059)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3168 (class 2606 OID 17208)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 3174 (class 2606 OID 17239)
-- Name: transactions_image transactions_image_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_image
    ADD CONSTRAINT transactions_image_pkey PRIMARY KEY (id);


--
-- TOC entry 3171 (class 2606 OID 17221)
-- Name: transactions_transaction transactions_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_transaction
    ADD CONSTRAINT transactions_transaction_pkey PRIMARY KEY (id);


--
-- TOC entry 3152 (class 2606 OID 17139)
-- Name: transactions_user_groups transactions_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user_groups
    ADD CONSTRAINT transactions_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3155 (class 2606 OID 17160)
-- Name: transactions_user_groups transactions_user_groups_user_id_group_id_125558f5_uniq; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user_groups
    ADD CONSTRAINT transactions_user_groups_user_id_group_id_125558f5_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 3146 (class 2606 OID 17129)
-- Name: transactions_user transactions_user_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user
    ADD CONSTRAINT transactions_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3157 (class 2606 OID 17174)
-- Name: transactions_user_user_permissions transactions_user_user_p_user_id_permission_id_a2b48671_uniq; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user_user_permissions
    ADD CONSTRAINT transactions_user_user_p_user_id_permission_id_a2b48671_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 3160 (class 2606 OID 17147)
-- Name: transactions_user_user_permissions transactions_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user_user_permissions
    ADD CONSTRAINT transactions_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3149 (class 2606 OID 17131)
-- Name: transactions_user transactions_user_username_key; Type: CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user
    ADD CONSTRAINT transactions_user_username_key UNIQUE (username);


--
-- TOC entry 3134 (class 1259 OID 17104)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 3139 (class 1259 OID 17117)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 3142 (class 1259 OID 17118)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 3129 (class 1259 OID 17103)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 3162 (class 1259 OID 17199)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 3165 (class 1259 OID 17200)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 3166 (class 1259 OID 17210)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 3169 (class 1259 OID 17209)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 3175 (class 1259 OID 17245)
-- Name: transactions_image_transaction_id_c3a42460; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX transactions_image_transaction_id_c3a42460 ON public.transactions_image USING btree (transaction_id);


--
-- TOC entry 3172 (class 1259 OID 17227)
-- Name: transactions_transaction_user_id_b9ecc248; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX transactions_transaction_user_id_b9ecc248 ON public.transactions_transaction USING btree (user_id);


--
-- TOC entry 3150 (class 1259 OID 17162)
-- Name: transactions_user_groups_group_id_d0970fb9; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX transactions_user_groups_group_id_d0970fb9 ON public.transactions_user_groups USING btree (group_id);


--
-- TOC entry 3153 (class 1259 OID 17161)
-- Name: transactions_user_groups_user_id_4adf6c83; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX transactions_user_groups_user_id_4adf6c83 ON public.transactions_user_groups USING btree (user_id);


--
-- TOC entry 3158 (class 1259 OID 17176)
-- Name: transactions_user_user_permissions_permission_id_0a85ca4c; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX transactions_user_user_permissions_permission_id_0a85ca4c ON public.transactions_user_user_permissions USING btree (permission_id);


--
-- TOC entry 3161 (class 1259 OID 17175)
-- Name: transactions_user_user_permissions_user_id_a4dcbf61; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX transactions_user_user_permissions_user_id_a4dcbf61 ON public.transactions_user_user_permissions USING btree (user_id);


--
-- TOC entry 3147 (class 1259 OID 17148)
-- Name: transactions_user_username_92f35969_like; Type: INDEX; Schema: public; Owner: Student_06
--

CREATE INDEX transactions_user_username_92f35969_like ON public.transactions_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 3187 (class 2620 OID 24601)
-- Name: transactions_transaction before_delete_set_balance; Type: TRIGGER; Schema: public; Owner: Student_06
--

CREATE TRIGGER before_delete_set_balance BEFORE DELETE ON public.transactions_transaction FOR EACH ROW EXECUTE PROCEDURE public.before_delete_set_balance();


--
-- TOC entry 3188 (class 2620 OID 24603)
-- Name: transactions_transaction before_update_set_balance; Type: TRIGGER; Schema: public; Owner: Student_06
--

CREATE TRIGGER before_update_set_balance BEFORE UPDATE ON public.transactions_transaction FOR EACH ROW EXECUTE PROCEDURE public.before_update_set_balance();


--
-- TOC entry 3189 (class 2620 OID 17266)
-- Name: transactions_transaction last_name_changes; Type: TRIGGER; Schema: public; Owner: Student_06
--

CREATE TRIGGER last_name_changes AFTER INSERT ON public.transactions_transaction FOR EACH ROW EXECUTE PROCEDURE public.before_insert_set_balance();


--
-- TOC entry 3178 (class 2606 OID 17110)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3177 (class 2606 OID 17105)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3176 (class 2606 OID 17096)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3183 (class 2606 OID 17189)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3184 (class 2606 OID 17194)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_transactions_user_id; Type: FK CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_transactions_user_id FOREIGN KEY (user_id) REFERENCES public.transactions_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3186 (class 2606 OID 17240)
-- Name: transactions_image transactions_image_transaction_id_c3a42460_fk_transacti; Type: FK CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_image
    ADD CONSTRAINT transactions_image_transaction_id_c3a42460_fk_transacti FOREIGN KEY (transaction_id) REFERENCES public.transactions_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3185 (class 2606 OID 17222)
-- Name: transactions_transaction transactions_transac_user_id_b9ecc248_fk_transacti; Type: FK CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_transaction
    ADD CONSTRAINT transactions_transac_user_id_b9ecc248_fk_transacti FOREIGN KEY (user_id) REFERENCES public.transactions_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3179 (class 2606 OID 17149)
-- Name: transactions_user_groups transactions_user_gr_user_id_4adf6c83_fk_transacti; Type: FK CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user_groups
    ADD CONSTRAINT transactions_user_gr_user_id_4adf6c83_fk_transacti FOREIGN KEY (user_id) REFERENCES public.transactions_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3180 (class 2606 OID 17154)
-- Name: transactions_user_groups transactions_user_groups_group_id_d0970fb9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user_groups
    ADD CONSTRAINT transactions_user_groups_group_id_d0970fb9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3182 (class 2606 OID 17168)
-- Name: transactions_user_user_permissions transactions_user_us_permission_id_0a85ca4c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user_user_permissions
    ADD CONSTRAINT transactions_user_us_permission_id_0a85ca4c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3181 (class 2606 OID 17163)
-- Name: transactions_user_user_permissions transactions_user_us_user_id_a4dcbf61_fk_transacti; Type: FK CONSTRAINT; Schema: public; Owner: Student_06
--

ALTER TABLE ONLY public.transactions_user_user_permissions
    ADD CONSTRAINT transactions_user_us_user_id_a4dcbf61_fk_transacti FOREIGN KEY (user_id) REFERENCES public.transactions_user(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2019-04-02 16:05:22 EDT

--
-- PostgreSQL database dump complete
--

