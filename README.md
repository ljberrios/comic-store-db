# Databases Course: Final Project

This was the final project for a databases course I took for my CS degree. A narrative was provided by my professor, which introduced a hypothetical company, their need for a database, and its requirements. The following sections of this file contain a summary of the narrative, the diagrams drawn for the database design, and some information related to the database implementation.

This repository contains four files:
- README.md
    - This file, which contains a summary of the project.

- matrix.png
    - A matrix diagram, which is used to identify the entities to be stored in the database and their relationships, omitting details such as attributes, for example.

- erd.png
    - An entity relationship diagram, which contains all the information from the matrix diagram, but also contains entity attributes, mutually exclusive relationships, supertype/subtype relationships, and more.

- script.sql
    - The SQL commands that create the tables and insert mock data.


## Narrative

David's Comic Clan, a hypothetical comic store based in San Juan, Puerto Rico, had a significant rise in its number of clients. Therefore, they would like to expand and improve their services. One of the things they would like to do is store most of their information in a database. 

They would like to store the information of the following: comics, clients, subscriptions, orders, pre-orders, stores, employees, stores, and offices. 

## Database Design

### Matrix Diagram
First, the entities to be stored and their relationships should be identified and written down (even if they could change). The following picture shows a matrix diagram containing the possible entities to be stored and their relationships, without showing a lot of detail: 

![Matrix Diagram](<matrix.png>)

1:1 represents a one-to-one relationship. 1:M represents a one-to-many relationship. This diagram doesn't have any many-to-many relationships because they've already been resolved through associative entities.

Keep in mind that this is similar to a draft when writing down an essay. Some things may change, even in the next design phase.

### Entity Relationship Diagram (ERD)
Next, we identify entity attributes, mutually exclusive relationships and supertype/subtype relationships. The following picture shows an entity relationship diagram containing the entities to be stored, their attributes, and their relationships:

![Entity Relationship Diagram](<erd.png>)

As opposed to a matrix diagram, an entity relationship diagram shows more detail. Also, the entities, attributes, and relationships in it should be the ones used in the database implementation.

## Database Implementation

The database management system used was Oracle DB Express Edition, version 11g. This repository contains a file named *script.sql* which contains the SQL commands to create the tables and insert mock data. 

