--Setup the context for the database and schema
use database demo;
use schema public;

--Create a small table
create or replace table "snowflake2kafka"
(
    "id"         integer   not null,
    "created_at" timestamp not null,
    "updated_at" timestamp not null,
    "first_name"       varchar(255),
    "address" varchar(255)
);

--Add some data to this table

INSERT INTO "snowflake2kafka" ("id", "created_at", "updated_at", "first_name",  "address") VALUES (11, '2023-01-28 10:00:00.400121', '2023-01-28 11:00:19.400121', 'Sudhendu',  'Somewhere');
INSERT INTO "snowflake2kafka" ("id", "created_at", "updated_at", "first_name",  "address") VALUES (12, '2023-01-29 10:00:00.400121', '2023-01-29 11:00:19.400121', 'Prakash',  'Mumbai');

--Verify your data
select * from "snowflake2kafka";
