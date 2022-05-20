--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2 (Debian 14.2-1.pgdg110+1)

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

--
-- Name: increment_course; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.increment_course
    START WITH 837827
    INCREMENT BY 23
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: course; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course (
    course_id integer DEFAULT nextval('public.increment_course'::regclass) NOT NULL,
    title character varying(200),
    syllabus character varying(500),
    credits integer
);


--
-- Name: course_offering; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_offering (
    course_id integer,
    sec_id integer NOT NULL,
    year integer,
    semester integer,
    "time" character varying(100),
    classroom integer
);


--
-- Name: enrolls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enrolls (
    student_id integer NOT NULL,
    course_id integer NOT NULL,
    sec_id integer NOT NULL,
    year integer,
    semester integer,
    grade numeric(3,2),
    CONSTRAINT enrolls_grade_check CHECK (((grade >= 1.00) AND (grade <= 5.00)))
);


--
-- Name: increment_student; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.increment_student
    START WITH 7488
    INCREMENT BY 168
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instructor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.instructor (
    instructor_id integer NOT NULL,
    name character varying(200),
    dept character varying(200),
    title character varying(200)
);


--
-- Name: instructor_instructor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.instructor_instructor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instructor_instructor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.instructor_instructor_id_seq OWNED BY public.instructor.instructor_id;


--
-- Name: requires; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.requires (
    main_course integer NOT NULL,
    prereqisite integer NOT NULL
);


--
-- Name: student; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student (
    student_id integer DEFAULT nextval('public.increment_student'::regclass) NOT NULL,
    name character varying(200),
    program character varying(200)
);


--
-- Name: teaches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teaches (
    course_id integer NOT NULL,
    sec_id integer NOT NULL,
    semester integer,
    year integer,
    instructor_id integer NOT NULL
);


--
-- Name: instructor instructor_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instructor ALTER COLUMN instructor_id SET DEFAULT nextval('public.instructor_instructor_id_seq'::regclass);


--
-- Name: course_offering course_offering_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_offering
    ADD CONSTRAINT course_offering_pkey PRIMARY KEY (sec_id);


--
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_id);


--
-- Name: enrolls enrolls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrolls
    ADD CONSTRAINT enrolls_pkey PRIMARY KEY (student_id, course_id, sec_id);


--
-- Name: instructor instructor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT instructor_pkey PRIMARY KEY (instructor_id);


--
-- Name: requires requires_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requires
    ADD CONSTRAINT requires_pkey PRIMARY KEY (main_course, prereqisite);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- Name: teaches teaches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teaches
    ADD CONSTRAINT teaches_pkey PRIMARY KEY (course_id, sec_id, instructor_id);


--
-- Name: course_offering course_offering_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_offering
    ADD CONSTRAINT course_offering_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- Name: enrolls enrolls_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrolls
    ADD CONSTRAINT enrolls_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- Name: enrolls enrolls_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrolls
    ADD CONSTRAINT enrolls_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- Name: requires requires_main_course_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requires
    ADD CONSTRAINT requires_main_course_fkey FOREIGN KEY (main_course) REFERENCES public.course(course_id);


--
-- Name: requires requires_prereqisite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.requires
    ADD CONSTRAINT requires_prereqisite_fkey FOREIGN KEY (prereqisite) REFERENCES public.course(course_id);


--
-- Name: teaches teaches_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teaches
    ADD CONSTRAINT teaches_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- Name: teaches teaches_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teaches
    ADD CONSTRAINT teaches_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id);


--
-- PostgreSQL database dump complete
--

