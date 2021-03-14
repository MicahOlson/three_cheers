--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6
-- Dumped by pg_dump version 12.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: Micah
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    title character varying
);


ALTER TABLE public.projects OWNER TO "Micah";

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: Micah
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO "Micah";

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Micah
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: volunteers; Type: TABLE; Schema: public; Owner: Micah
--

CREATE TABLE public.volunteers (
    id integer NOT NULL,
    name character varying,
    project_id integer
);


ALTER TABLE public.volunteers OWNER TO "Micah";

--
-- Name: volunteers_id_seq; Type: SEQUENCE; Schema: public; Owner: Micah
--

CREATE SEQUENCE public.volunteers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.volunteers_id_seq OWNER TO "Micah";

--
-- Name: volunteers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Micah
--

ALTER SEQUENCE public.volunteers_id_seq OWNED BY public.volunteers.id;


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: Micah
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: volunteers id; Type: DEFAULT; Schema: public; Owner: Micah
--

ALTER TABLE ONLY public.volunteers ALTER COLUMN id SET DEFAULT nextval('public.volunteers_id_seq'::regclass);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: Micah
--

COPY public.projects (id, title) FROM stdin;
656	Project A
657	Project B
658	Project D
659	Project C
660	Project E
\.


--
-- Data for Name: volunteers; Type: TABLE DATA; Schema: public; Owner: Micah
--

COPY public.volunteers (id, name, project_id) FROM stdin;
610	Volunteer 7	\N
611	Volunteer 8	\N
608	Volunteer 5	656
609	Volunteer 6	656
606	Volunteer 3	657
607	Volunteer 4	657
604	Volunteer 1	659
605	Volunteer 2	658
612	Volunteer 9	0
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Micah
--

SELECT pg_catalog.setval('public.projects_id_seq', 660, true);


--
-- Name: volunteers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Micah
--

SELECT pg_catalog.setval('public.volunteers_id_seq', 613, true);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: Micah
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: volunteers volunteers_pkey; Type: CONSTRAINT; Schema: public; Owner: Micah
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

