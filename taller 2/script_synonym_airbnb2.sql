/* SYNONYM TABLES */

CREATE SYNONYM review
FOR AIRBNB.review;

CREATE SYNONYM user_id
FOR AIRBNB.user_id;

CREATE SYNONYM place
FOR AIRBNB.place;

CREATE SYNONYM amenity
FOR AIRBNB.amenity;

CREATE SYNONYM place_amenity
FOR AIRBNB.place_amenity;

CREATE SYNONYM state
FOR AIRBNB.state;

CREATE SYNONYM city
FOR AIRBNB.city;


/* SYNONYM VIEWS */

CREATE OR REPLACE SYNONYM view_review_user_place
FOR AIRBNB.view_review_user_place;

CREATE OR REPLACE SYNONYM view_place_city_state
FOR AIRBNB.view_place_city_state;

CREATE OR REPLACE SYNONYM view_place_amenity
FOR AIRBNB.view_place_amenity;

