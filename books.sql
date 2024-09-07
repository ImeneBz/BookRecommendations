--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.8 (Homebrew)

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
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    book_id integer NOT NULL,
    creationdate date,
    title character varying(45),
    author character varying(45)
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: books_book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_book_id_seq OWNER TO postgres;

--
-- Name: books_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_book_id_seq OWNED BY public.books.book_id;


--
-- Name: opinions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opinions (
    id integer NOT NULL,
    user_id character varying(45),
    book_id integer NOT NULL,
    ranking integer,
    creationdate date NOT NULL,
    notes character varying(100)
);


ALTER TABLE public.opinions OWNER TO postgres;

--
-- Name: opinions_book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.opinions_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.opinions_book_id_seq OWNER TO postgres;

--
-- Name: opinions_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.opinions_book_id_seq OWNED BY public.opinions.book_id;


--
-- Name: opinions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.opinions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.opinions_id_seq OWNER TO postgres;

--
-- Name: opinions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.opinions_id_seq OWNED BY public.opinions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id character varying(45) NOT NULL,
    email character varying(45)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: books book_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN book_id SET DEFAULT nextval('public.books_book_id_seq'::regclass);


--
-- Name: opinions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opinions ALTER COLUMN id SET DEFAULT nextval('public.opinions_id_seq'::regclass);


--
-- Name: opinions book_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opinions ALTER COLUMN book_id SET DEFAULT nextval('public.opinions_book_id_seq'::regclass);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (book_id, creationdate, title, author) FROM stdin;
2	2024-08-28	Funny Story	Emily Henry
3	2024-08-27	Harry Potter et la Coupe de feu	J.K Rowling
4	2024-08-26	Harry Potter à l"ecole des sorciers	J.K Rowling
5	2024-08-25	Harry Potter et l"ordre du Phénix	J.K Rowling
6	2024-08-28	Hercule Poirot's Christmas	Agatha Christie
7	2024-08-28	Thinking, fast and slow	Daniel Kahneman
8	2024-08-28	Le rouge et le noir	Stendhal
9	2024-08-28	Madame Bovary	Gustave Flaubert
\.


--
-- Data for Name: opinions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.opinions (id, user_id, book_id, ranking, creationdate, notes) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, email) FROM stdin;
\.


--
-- Name: books_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_book_id_seq', 9, true);


--
-- Name: opinions_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.opinions_book_id_seq', 1, false);


--
-- Name: opinions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.opinions_id_seq', 1, false);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (book_id);


--
-- Name: opinions opinions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opinions
    ADD CONSTRAINT opinions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: opinions book_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opinions
    ADD CONSTRAINT book_id FOREIGN KEY (book_id) REFERENCES public.books(book_id);


--
-- Name: opinions user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opinions
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

