--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Ubuntu 10.4-2.pgdg14.04+1)
-- Dumped by pg_dump version 10.4

-- Started on 2018-08-24 15:59:25

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.stories DROP CONSTRAINT IF EXISTS "Author Foreign Key";
DROP TRIGGER IF EXISTS "updateStory" ON public.stories;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.stories DROP CONSTRAINT IF EXISTS stories_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS "Username constraint";
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.stories ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.stories_id_seq;
DROP TABLE IF EXISTS public.stories;
DROP FUNCTION IF EXISTS public.edited();
DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public;
--
-- TOC entry 7 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 3703 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 1 (class 3079 OID 13809)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3704 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 209 (class 1255 OID 588654)
-- Name: edited(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.edited() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.edited := NOW();
  RETURN NEW;
END;

$$;


--
-- TOC entry 3705 (class 0 OID 0)
-- Dependencies: 209
-- Name: FUNCTION edited(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION public.edited() IS 'Updates edited column timestamp';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 199 (class 1259 OID 578146)
-- Name: stories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stories (
    id integer NOT NULL,
    title text NOT NULL,
    author integer NOT NULL,
    story jsonb NOT NULL,
    created timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    edited timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 3706 (class 0 OID 0)
-- Dependencies: 199
-- Name: TABLE stories; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.stories IS 'Fill In The Blank stories for RUN__ON';


--
-- TOC entry 3707 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN stories.author; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.stories.author IS 'Foreign Key to the users table';


--
-- TOC entry 3708 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN stories.created; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.stories.created IS 'Date the story was created';


--
-- TOC entry 3709 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN stories.edited; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.stories.edited IS 'Date of the most recent edit for this story';


--
-- TOC entry 198 (class 1259 OID 578144)
-- Name: stories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3710 (class 0 OID 0)
-- Dependencies: 198
-- Name: stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stories_id_seq OWNED BY public.stories.id;


--
-- TOC entry 197 (class 1259 OID 562352)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    picture text,
    joined timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 3711 (class 0 OID 0)
-- Dependencies: 197
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.users IS 'Authenticated Users for RUN__ON';


--
-- TOC entry 3712 (class 0 OID 0)
-- Dependencies: 197
-- Name: COLUMN users.joined; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.users.joined IS 'The Date the User Joined';


--
-- TOC entry 196 (class 1259 OID 562350)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3713 (class 0 OID 0)
-- Dependencies: 196
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3565 (class 2604 OID 578149)
-- Name: stories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories ALTER COLUMN id SET DEFAULT nextval('public.stories_id_seq'::regclass);


--
-- TOC entry 3563 (class 2604 OID 562355)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3569 (class 2606 OID 562363)
-- Name: users Username constraint; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "Username constraint" UNIQUE (name);


--
-- TOC entry 3714 (class 0 OID 0)
-- Dependencies: 3569
-- Name: CONSTRAINT "Username constraint" ON users; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON CONSTRAINT "Username constraint" ON public.users IS 'Multiple users cannot have the same username';


--
-- TOC entry 3573 (class 2606 OID 578156)
-- Name: stories stories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT stories_pkey PRIMARY KEY (id);


--
-- TOC entry 3571 (class 2606 OID 562361)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3575 (class 2620 OID 594572)
-- Name: stories updateStory; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER "updateStory" BEFORE UPDATE OF title, story ON public.stories FOR EACH ROW EXECUTE PROCEDURE public.edited();


--
-- TOC entry 3715 (class 0 OID 0)
-- Dependencies: 3575
-- Name: TRIGGER "updateStory" ON stories; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TRIGGER "updateStory" ON public.stories IS 'Triggers update function any time a value in the story changes';


--
-- TOC entry 3574 (class 2606 OID 578157)
-- Name: stories Author Foreign Key; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT "Author Foreign Key" FOREIGN KEY (author) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3716 (class 0 OID 0)
-- Dependencies: 3574
-- Name: CONSTRAINT "Author Foreign Key" ON stories; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON CONSTRAINT "Author Foreign Key" ON public.stories IS 'The Original Author of a Story referenced from the public.users table.';


-- Completed on 2018-08-24 15:59:37

--
-- PostgreSQL database dump complete
--

