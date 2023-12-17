--
-- additional foreign key constraints
--

--
-- TABLE constructorresults
--

ALTER TABLE constructorresults
DROP CONSTRAINT IF EXISTS constructorresults_races_fkey;

ALTER TABLE constructorresults
ADD CONSTRAINT constructorresults_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE constructorresults
DROP CONSTRAINT IF EXISTS constructorresults_constructors_fkey;

ALTER TABLE constructorresults
ADD CONSTRAINT constructorresults_constructors_fkey
FOREIGN KEY (constructorid)
REFERENCES constructors(constructorid);

--
-- TABLE constructorstandings
--

ALTER TABLE constructorstandings
DROP CONSTRAINT IF EXISTS constructorstandings_races_fkey;

ALTER TABLE constructorstandings
ADD CONSTRAINT constructorstandings_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE constructorstandings
DROP CONSTRAINT IF EXISTS constructorstandings_constructors_fkey;

ALTER TABLE constructorstandings
ADD CONSTRAINT constructorstandings_constructors_fkey
FOREIGN KEY (constructorid)
REFERENCES constructors(constructorid);

--
-- TABLE driverstandings
--

ALTER TABLE driverstandings
DROP CONSTRAINT IF EXISTS driverstandings_races_fkey;

ALTER TABLE driverstandings
ADD CONSTRAINT driverstandings_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE driverstandings
DROP CONSTRAINT IF EXISTS driverstandings_drivers_fkey;

ALTER TABLE driverstandings
ADD CONSTRAINT driverstandings_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

--
-- TABLE results
--

ALTER TABLE results
DROP CONSTRAINT IF EXISTS results_races_fkey;

ALTER TABLE results
ADD CONSTRAINT results_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE results
DROP CONSTRAINT IF EXISTS results_drivers_fkey;

ALTER TABLE results
ADD CONSTRAINT results_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

ALTER TABLE results
DROP CONSTRAINT IF EXISTS results_constructors_fkey;

ALTER TABLE results
ADD CONSTRAINT results_constructors_fkey
FOREIGN KEY (constructorid)
REFERENCES constructors(constructorid);

ALTER TABLE results
DROP CONSTRAINT IF EXISTS results_status_fkey;

ALTER TABLE results
ADD CONSTRAINT results_status_fkey
FOREIGN KEY (statusid)
REFERENCES status(statusid);

--
-- TABLE sprintresults
--

ALTER TABLE sprintresults
DROP CONSTRAINT IF EXISTS sprintresults_races_fkey;

ALTER TABLE sprintresults
ADD CONSTRAINT sprintresults_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE sprintresults
DROP CONSTRAINT IF EXISTS sprintresults_drivers_fkey;

ALTER TABLE sprintresults
ADD CONSTRAINT sprintresults_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

ALTER TABLE sprintresults
DROP CONSTRAINT IF EXISTS sprintresults_constructors_fkey;

ALTER TABLE sprintresults
ADD CONSTRAINT sprintresults_constructors_fkey
FOREIGN KEY (constructorid)
REFERENCES constructors(constructorid);

ALTER TABLE sprintresults
DROP CONSTRAINT IF EXISTS sprintresults_status_fkey;

ALTER TABLE sprintresults
ADD CONSTRAINT sprintresults_status_fkey
FOREIGN KEY (statusid)
REFERENCES status(statusid);

--
-- TABLE qualifying
--

ALTER TABLE qualifying
DROP CONSTRAINT IF EXISTS qualifying_races_fkey;

ALTER TABLE qualifying
ADD CONSTRAINT qualifying_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE qualifying
DROP CONSTRAINT IF EXISTS qualifying_drivers_fkey;

ALTER TABLE qualifying
ADD CONSTRAINT qualifying_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

ALTER TABLE qualifying
DROP CONSTRAINT IF EXISTS qualifying_constructors_fkey;

ALTER TABLE qualifying
ADD CONSTRAINT qualifying_constructors_fkey
FOREIGN KEY (constructorid)
REFERENCES constructors(constructorid);

--
-- TABLE pitstops
--

ALTER TABLE pitstops
DROP CONSTRAINT IF EXISTS pitstops_races_fkey;

ALTER TABLE pitstops
ADD CONSTRAINT pitstops_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE pitstops
DROP CONSTRAINT IF EXISTS pitstops_drivers_fkey;

ALTER TABLE pitstops
ADD CONSTRAINT pitstops_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

--
-- TABLE laptimes
--

ALTER TABLE laptimes
DROP CONSTRAINT IF EXISTS laptimes_races_fkey;

ALTER TABLE laptimes
ADD CONSTRAINT laptimes_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE laptimes
DROP CONSTRAINT IF EXISTS laptimes_drivers_fkey;

ALTER TABLE laptimes
ADD CONSTRAINT laptimes_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

--
-- TABLE races
--

ALTER TABLE races
DROP CONSTRAINT IF EXISTS races_circuits_fkey;

ALTER TABLE races
ADD CONSTRAINT races_circuits_fkey
FOREIGN KEY (circuitid)
REFERENCES circuits(circuitid);

ALTER TABLE races
DROP CONSTRAINT IF EXISTS races_seasons_fkey;

ALTER TABLE races
ADD CONSTRAINT races_seasons_fkey
FOREIGN KEY (year)
REFERENCES seasons(year);
