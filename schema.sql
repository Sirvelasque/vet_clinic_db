/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
)
ALTER TABLE animals ADD species VARCHAR(50);
CREATE TABLE owners(id SERIAL PRIMARY KEY, full_name VARCHAR(50), age INT);
CREATE TABLE species(id SERIAL PRIMARY KEY, name VARCHAR(50));
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD CONSTRAINT FK_species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT FK_owners FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets(id SERIAL PRIMARY KEY, name VARCHAR(50), age INT, date_of_graduation DATE );
CREATE TABLE specializations(vet_id INT, species_id int);
CREATE TABLE visits(animal_id int, vet_id int, visit_date DATE);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Performance audit for: EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
CREATE INDEX animals_asc ON visits(animal_id ASC);

-- Performance audit for: EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
CREATE INDEX vets_asc ON visits(vet_id ASC);

-- Performance audit for: EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
CREATE INDEX owners_asc ON visits(vet_id DESC);
