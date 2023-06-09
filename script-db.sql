-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.captains
(
    cap_id character varying(9) COLLATE pg_catalog."default" NOT NULL,
    cap_name character varying(30) COLLATE pg_catalog."default",
    cap_lastname character varying(50) COLLATE pg_catalog."default",
    cap_birthdate date,
    CONSTRAINT unique_cap_id PRIMARY KEY (cap_id)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE IF NOT EXISTS public.departures
(
    dep_id bigint NOT NULL,
    dep_destination character varying(30) COLLATE pg_catalog."default",
    dep_startdate date,
    dep_enddate date,
    ship_id character varying(25) COLLATE pg_catalog."default",
    cap_id character varying(9) COLLATE pg_catalog."default",
    CONSTRAINT departures_pkey PRIMARY KEY (dep_id)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE IF NOT EXISTS public.partners
(
    part_id character varying(9) COLLATE pg_catalog."default" NOT NULL,
    part_name character varying COLLATE pg_catalog."default",
    part_lastname character varying COLLATE pg_catalog."default",
    part_birthdate date,
    CONSTRAINT unique_part_id PRIMARY KEY (part_id)
)
WITH (
    OIDS = FALSE
);

CREATE TABLE IF NOT EXISTS public.ships
(
    ship_id character varying(30) COLLATE pg_catalog."default" NOT NULL,
    ship_name character varying(30) COLLATE pg_catalog."default",
    ship_num_moorage bigint,
    ship_price double precision,
    part_id character varying(9) COLLATE pg_catalog."default",
    CONSTRAINT unique_ship_id UNIQUE (ship_id)
)
WITH (
    OIDS = FALSE
);

ALTER TABLE IF EXISTS public.departures
    ADD CONSTRAINT fk_departures_cap_id FOREIGN KEY (cap_id)
    REFERENCES public.captains (cap_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.departures
    ADD CONSTRAINT fk_departures_ship_id FOREIGN KEY (ship_id)
    REFERENCES public.ships (ship_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.ships
    ADD CONSTRAINT fk_ships_part_id FOREIGN KEY (part_id)
    REFERENCES public.partners (part_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;