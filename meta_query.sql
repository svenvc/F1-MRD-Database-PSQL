--
-- META QUERY
--

-- given table_name find all foreign key contraints
select table_name, constraint_name
from information_schema.table_constraints
where table_name = 'driverstandings' and constraint_type = 'FOREIGN KEY';

-- given constraint_name find target/references table columns names 
select constraint_name, table_name, column_name
from information_schema.constraint_column_usage
where constraint_name = 'driverstandings_drivers_fkey';

-- given constrain_name find source column names
select constraint_name, table_name, column_name, ordinal_position, position_in_unique_constraint
from information_schema.key_column_usage
where constraint_name = 'driverstandings_drivers_fkey' ;

-- given constraint_name find target/references table
select constraint_name, table_name
from information_schema.constraint_table_usage
where constraint_name = 'driverstandings_drivers_fkey';

-- given table_name find all foreign key constraint targeted/referenced at/to me
select ctu.table_name, tc.table_name, ctu.constraint_name
from information_schema.constraint_table_usage as ctu, information_schema.table_constraints as tc
where ctu.table_name = 'drivers' and ctu.constraint_name = tc.constraint_name and tc.constraint_type = 'FOREIGN KEY';
