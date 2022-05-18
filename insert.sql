DELETE FROM property_types;
DELETE FROM data_types;
DELETE FROM measurement_units;
DELETE FROM subcategories;
DELETE FROM categories;



INSERT INTO categories(category_name)
VALUES
('Компьютеры, ноутбуки и ПО'),
('Комплектующие для ПК'),
('Периферия и аксессуары');

INSERT INTO subcategories(subcategory_name, category_id)
VALUES
('Персональные компьютеры', (SELECT id FROM categories WHERE category_name = 'Компьютеры, ноутбуки и ПО')),
('Ноутбуки', (SELECT id FROM categories WHERE category_name = 'Компьютеры, ноутбуки и ПО')),
('Программное обеспечение', (SELECT id FROM categories WHERE category_name = 'Компьютеры, ноутбуки и ПО')),

('Процессоры', (SELECT id FROM categories WHERE category_name = 'Комплектующие для ПК')),
('Материнские платы', (SELECT id FROM categories WHERE category_name = 'Комплектующие для ПК')),
('Видеокарты', (SELECT id FROM categories WHERE category_name = 'Комплектующие для ПК')),
('Оперативная память', (SELECT id FROM categories WHERE category_name = 'Комплектующие для ПК')),
('Корпуса', (SELECT id FROM categories WHERE category_name = 'Комплектующие для ПК')),
('SSD накопители', (SELECT id FROM categories WHERE category_name = 'Комплектующие для ПК')),
('Жесткие диски', (SELECT id FROM categories WHERE category_name = 'Комплектующие для ПК')),

('Мониторы', (SELECT id FROM categories WHERE category_name = 'Периферия и аксессуары')),
('Клавиатуры', (SELECT id FROM categories WHERE category_name = 'Периферия и аксессуары')),
('Мыши', (SELECT id FROM categories WHERE category_name = 'Периферия и аксессуары')),
('Коврики для мыши', (SELECT id FROM categories WHERE category_name = 'Периферия и аксессуары')),
('Веб-камеры', (SELECT id FROM categories WHERE category_name = 'Периферия и аксессуары')),
('Наушники', (SELECT id FROM categories WHERE category_name = 'Периферия и аксессуары'));

INSERT INTO measurement_units(measurement_unit_name)
VALUES
('мес.'),
('МГц'),
('МБ'),
('ГБ'),
('ТБ'),
('Гбит/с'),
('мм'),
('″'),
('Гц'),
('ppi'),
('Кд/м²'),
('%'),
('Мп'),
('Вт*ч'),
('ч'),
('Вт'),
('кг'),
('г'),
('°'),
('Мбайт/сек'),
('об/мин'),
('');

INSERT INTO data_types(data_type_name)
VALUES
('string'),
('integer'),
('real'),
('boolean');

-- DECLARE personal_computers_id integer;
-- DECLARE laptops_id integer;
-- DECLARE software_id integer;
-- DECLARE processors_id integer;
-- DECLARE motherboards_id integer;
-- DECLARE videocards_id integer;
-- DECLARE ram_id integer;
-- DECLARE enclosures_id integer;
-- DECLARE ssd_drives_id integer;
-- DECLARE hard_drives_id integer;
-- DECLARE monitors_id integer;
-- DECLARE keyboards_id integer;
-- DECLARE mouses_id integer;
-- DECLARE mouse_pads_id integer;
-- DECLARE webcams_id integer;
-- DECLARE headphones_id integer;

-- DECLARE type_string_id integer;
-- DECLARE type_integer_id integer;
-- DECLARE type_real_id integer;
-- DECLARE type_boolean_id integer;

DROP FUNCTION add_property_type(property_name varchar, param_measurement_unit_name varchar, param_data_type_name varchar, param_subcategory_name varchar);
CREATE OR REPLACE FUNCTION add_property_type(property_name varchar, param_measurement_unit_name varchar, param_data_type_name varchar, param_subcategory_name varchar) RETURNS void AS $$
  DECLARE var_measurement_unit_id integer;
  DECLARE var_data_type_id integer;
  DECLARE var_subcategory_id integer;
  BEGIN
    SELECT id FROM measurement_units WHERE measurement_unit_name = param_measurement_unit_name INTO var_measurement_unit_id;
    SELECT id FROM data_types WHERE data_type_name = param_data_type_name INTO var_data_type_id;
    SELECT id FROM subcategories WHERE subcategory_name = param_subcategory_name INTO var_subcategory_id;

    INSERT INTO property_types(property_name, measurement_unit_id, data_type_id, subcategory_id)
    VALUES (property_name, var_measurement_unit_id, var_data_type_id, var_subcategory_id);
  END
$$ LANGUAGE plpgsql;

DROP FUNCTION add_property_personal_computer_type(property_name varchar, param_measurement_unit_name varchar, param_data_type_name varchar);
CREATE OR REPLACE FUNCTION add_property_personal_computer_type(property_name varchar, param_measurement_unit_name varchar, param_data_type_name varchar) RETURNS void AS $$
  -- add_property_type(property_type, param_measurement_unit_name, param_data_type_name, 'Персональные компьютеры');
  -- DECLARE var_measurement_unit_id integer;
  -- DECLARE var_data_type_id integer;
  -- DECLARE var_subcategory_id integer;
  BEGIN
  --   SELECT id FROM measurement_units WHERE measurement_unit_name = param_measurement_unit_name INTO var_measurement_unit_id;
  --   SELECT id FROM data_types WHERE data_type_name = param_data_type_name INTO var_data_type_id;
  --   SELECT id FROM subcategories WHERE subcategory_name = param_subcategory_name INTO var_subcategory_id;

  --   INSERT INTO property_types(property_name, measurement_unit_id, data_type_id, subcategory_id)
  --   VALUES (property_name, var_measurement_unit_id, var_data_type_id, var_subcategory_id);
  END
$$ LANGUAGE plpgsql;

DO $$

DECLARE personal_computers_name varchar;
DECLARE laptops_name varchar;
DECLARE software_name varchar;
DECLARE processors_name varchar;
DECLARE motherboards_name varchar;
DECLARE videocards_name varchar;
DECLARE ram_name varchar;
DECLARE enclosures_name varchar;
DECLARE ssd_drives_name varchar;
DECLARE hard_drives_name varchar;
DECLARE monitors_name varchar;
DECLARE keyboards_name varchar;
DECLARE mouses_name varchar;
DECLARE mouse_pads_name varchar;
DECLARE webcams_name varchar;
DECLARE headphones_name varchar;

BEGIN
  SELECT 'Персональные компьютеры' INTO personal_computers_name;
  SELECT 'Ноутубки' INTO laptops_name;
  SELECT 'Программное обеспечение' INTO software_name;
  SELECT 'Процессоры' INTO processors_name;
  SELECT 'Материнские платы' INTO motherboards_name;
  SELECT 'Видеокарты' INTO videocards_name;
  SELECT 'Оперативная память' INTO ram_name;
  SELECT 'Корпуса' INTO enclosures_name;
  SELECT 'SSD накопители' INTO ssd_drives_name;
  SELECT 'Жесткие диски' INTO hard_drives_name;
  SELECT 'Мониторы' INTO monitors_name;
  SELECT 'Клавиатуры' INTO keyboards_name;
  SELECT 'Мыши' INTO mouses_name;
  SELECT 'Коврики для мыши' INTO mouse_pads_name;
  SELECT 'Веб-камеры' INTO webcams_name;
  SELECT 'Наушники' INTO headphones_name;

  -- SELECT id FROM subcategories WHERE subcategory_name = personal_computers_name INTO personal_computers_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = laptops_name INTO laptops_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = software_name INTO software_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = processors_name INTO processors_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = motherboards_name INTO motherboards_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = videocards_name INTO videocards_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = ram_name INTO ram_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = enclosures_name INTO enclosures_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = ssd_drives_name INTO ssd_drives_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = hard_drives_name INTO hard_drives_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = monitors_name INTO monitors_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = keyboards_name INTO keyboards_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = mouses_name INTO mouses_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = mouse_pads_name INTO mouse_pads_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = webcams_name INTO webcams_id;
  -- SELECT id FROM subcategories WHERE subcategory_name = headphones_name INTO headphones_id;

  -- SELECT id FROM data_types WHERE data_type_name = 'string' INTO type_string_id;
  -- SELECT id FROM data_types WHERE data_type_name = 'integer' INTO type_integer_id;
  -- SELECT id FROM data_types WHERE data_type_name = 'real' INTO type_real_id;
  -- SELECT id FROM data_types WHERE data_type_name = 'boolean' INTO type_boolean_id;

  SELECT add_property_personal_computer_type('ПК: Гарантия', 'мес.', 'integer');
-- SELECT add_property_type('ПК: Гарантия', 'мес.', 'integer', 'Персональные компьютеры');

END $$;

-- BEGIN
--   SELECT 'Персональные компьютеры' INTO personal_computers_name;
--   SELECT 'Ноутубки' INTO laptops_name;
--   SELECT 'Программное обеспечение' INTO software_name;
--   SELECT 'Процессоры' INTO processors_name;
--   SELECT 'Материнские платы' INTO motherboards_name;
--   SELECT 'Видеокарты' INTO videocards_name;
--   SELECT 'Оперативная память' INTO ram_name;
--   SELECT 'Корпуса' INTO enclosures_name;
--   SELECT 'SSD накопители' INTO ssd_drives_name;
--   SELECT 'Жесткие диски' INTO hard_drives_name;
--   SELECT 'Мониторы' INTO monitors_name;
--   SELECT 'Клавиатуры' INTO keyboards_name;
--   SELECT 'Мыши' INTO mouses_name;
--   SELECT 'Коврики для мыши' INTO mouse_pads_name;
--   SELECT 'Веб-камеры' INTO webcams_name;
--   SELECT 'Наушники' INTO headphones_name;

--   -- SELECT add_property_type('ПК: Гарантия', 'мес.', 'integer', personal_computers_name);



-- DELETE FROM property_types;
-- INSERT INTO property_types(property_name, measurement_unit_id, data_type_id, subcategory_id)
-- VALUES
-- ('ПК: Гарантия', 'мес.', 'integer', 'Персональные компьютеры'),