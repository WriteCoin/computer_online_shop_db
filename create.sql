CREATE TABLE IF NOT EXISTS person(
  id serial PRIMARY KEY,
  first_name character varying(64) NOT NULL,
  last_name character varying(64) NOT NULL,
  user_name character varying(255) NOT NULL,
  user_password character varying(255) NOT NULL,
  phone character varying(20) NOT NULL,
  email character varying(32) NOT NULL
);




CREATE TABLE IF NOT EXISTS clients(
  id serial PRIMARY KEY,
  person_id integer NOT NULL,
  balance money DEFAULT 0,
  bonus_count money DEFAULT 0
);
ALTER TABLE clients ADD CONSTRAINT clients_to_person FOREIGN KEY (person_id)
	REFERENCES person (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;








CREATE TABLE IF NOT EXISTS moderators(
  id serial PRIMARY KEY,
  person_id integer NOT NULL
);
ALTER TABLE moderators ADD CONSTRAINT moderators_to_person FOREIGN KEY (person_id)
	REFERENCES person (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;







CREATE TABLE IF NOT EXISTS operators(
  id serial PRIMARY KEY,
  person_id integer NOT NULL
);
ALTER TABLE operators ADD CONSTRAINT operators_to_person FOREIGN KEY (person_id)
	REFERENCES person (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;






-- категории
CREATE TABLE IF NOT EXISTS categories(
	id serial PRIMARY KEY,
	category_name varchar(100) NOT NULL
);




-- подкатегории
CREATE TABLE IF NOT EXISTS subcategories(
	id serial PRIMARY KEY,
	subcategory_name varchar(100) NOT NULL,
	category_id integer NOT NULL
);
ALTER TABLE subcategories ADD CONSTRAINT subcategories_to_categories FOREIGN KEY (category_id)
	REFERENCES categories (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;





-- товары
CREATE TABLE IF NOT EXISTS products(
	id serial PRIMARY KEY,
	product_name varchar(100) NOT NULL,
	product_desc text,
	image_path bytea,
	subcategory_id integer NOT NULL,
	price money NOT NULL CHECK(price > '0.00'),
	quantity_in_stock integer NOT NULL,
	additional_bonus_count money DEFAULT 0
);
ALTER TABLE products ADD CONSTRAINT products_to_subcategories FOREIGN KEY (subcategory_id)
	REFERENCES subcategories (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;






-- единицы измерения
CREATE TABLE IF NOT EXISTS measurement_units(
	id serial PRIMARY KEY,
	measurement_unit_name varchar(25) NOT NULL
);


-- типы данных
CREATE TABLE IF NOT EXISTS data_types(
	id serial PRIMARY KEY,
	data_type_name varchar(10) NOT NULL
);


-- типы характеристик
CREATE TABLE IF NOT EXISTS property_types(
	id serial PRIMARY KEY,
	property_name varchar(100) NOT NULL,
	measurement_unit_id integer NOT NULL,
	data_type_id integer NOT NULL,
	subcategory_id integer NOT NULL
);

ALTER TABLE property_types ADD CONSTRAINT property_types_to_measurement_units FOREIGN KEY (measurement_unit_id)
	REFERENCES measurement_units (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;

ALTER TABLE property_types ADD CONSTRAINT property_types_to_data_types FOREIGN KEY (data_type_id)
	REFERENCES data_types (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;

ALTER TABLE property_types ADD CONSTRAINT property_types_to_subcategories FOREIGN KEY (subcategory_id)
	REFERENCES subcategories (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;








-- характеристики
CREATE TABLE IF NOT EXISTS properties(
	id serial PRIMARY KEY,
	property_type_id integer NOT NULL,
	product_id integer NOT NULL,
	property_value varchar(255) NOT NULL
);
ALTER TABLE properties ADD CONSTRAINT properties_to_property_types FOREIGN KEY (property_type_id)
	REFERENCES property_types (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;

ALTER TABLE properties ADD CONSTRAINT properties_to_products FOREIGN KEY (product_id)
	REFERENCES products (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;






-- корзины
CREATE TABLE IF NOT EXISTS baskets(
  id serial PRIMARY KEY,
  client_id integer NOT NULL
);
ALTER TABLE baskets ADD CONSTRAINT baskets_to_clients FOREIGN KEY (client_id)
	REFERENCES clients (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;







-- товары в корзинах
CREATE TABLE IF NOT EXISTS products_in_baskets(
  id serial PRIMARY KEY,
  basket_id integer NOT NULL,
  product_id integer NOT NULL
);
ALTER TABLE products_in_baskets ADD CONSTRAINT products_in_baskets_to_baskets FOREIGN KEY (basket_id)
	REFERENCES baskets (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;

ALTER TABLE products_in_baskets ADD CONSTRAINT products_in_baskets_to_products FOREIGN KEY (product_id)
	REFERENCES products (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;





-- статусы заказа
CREATE TABLE IF NOT EXISTS order_statuses(
  id serial PRIMARY KEY,
  order_status_name character varying(32) NOT NULL
);



-- способы получения заказа
CREATE TABLE IF NOT EXISTS ways_to_receive(
  id serial PRIMARY KEY,
  way_to_receive_name character varying(32) NOT NULL
);


-- способы оплаты
CREATE TABLE IF NOT EXISTS payment_methods(
  id serial PRIMARY KEY,
  payment_method_name character varying(32) NOT NULL
);



-- заказы
CREATE TABLE IF NOT EXISTS orders(
	id serial PRIMARY KEY,
  order_number integer NOT NULL UNIQUE,
	client_id integer NOT NULL,
  way_to_receive_id integer NOT NULL,
  payment_method_id integer NOT NULL,
  delivery_address character varying(255) NOT NULL,
  reg_date date NOT NULL,
  date_of_receipt date NOT NULL,
  order_status_id integer NOT NULL
);
ALTER TABLE orders ADD CONSTRAINT orders_to_clients FOREIGN KEY (client_id)
	REFERENCES clients (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;

ALTER TABLE orders ADD CONSTRAINT orders_to_ways_to_receive FOREIGN KEY (way_to_receive_id)
	REFERENCES ways_to_receive (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;

ALTER TABLE orders ADD CONSTRAINT orders_to_payment_methods FOREIGN KEY (payment_method_id)
	REFERENCES payment_methods (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;

ALTER TABLE orders ADD CONSTRAINT orders_to_order_statuses FOREIGN KEY (order_status_id)
	REFERENCES order_statuses (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;






-- товары в заказах
CREATE TABLE IF NOT EXISTS products_in_orders(
  id serial PRIMARY KEY,
  order_id integer NOT NULL,
  product_id integer NOT NULL,
  quantity integer NOT NULL CHECK(quantity > 0)
);
ALTER TABLE products_in_orders ADD CONSTRAINT products_in_orders_to_orders FOREIGN KEY (order_id)
	REFERENCES orders (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;

ALTER TABLE products_in_orders ADD CONSTRAINT products_in_orders_to_products FOREIGN KEY (product_id)
	REFERENCES products (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;






-- возвраты
CREATE TABLE IF NOT EXISTS refunds(
	id serial PRIMARY KEY,
	order_id integer NOT NULL,
  product_id integer NOT NULL,
	quantity integer NOT NULL,
	date_of_refund date NOT NULL,
	reason_for_refund text
);
ALTER TABLE refunds ADD CONSTRAINT refunds_to_orders FOREIGN KEY (order_id)
	REFERENCES orders (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;

ALTER TABLE refunds ADD CONSTRAINT refunds_to_products FOREIGN KEY (product_id)
	REFERENCES products (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION;