# Mongo Postgres Elasticsearch Stream: MongoDB & Postgres → Kafka → Elasticsearch

This project implements a **real-time data streaming pipeline** using Kafka Connect and Debezium. It captures changes from **MongoDB** and **Postgres**, streams them to **Kafka topics**, and sinks the data into **Elasticsearch** for search and analytics.

---

## Architecture

MongoDB + Postgres → Debezium Connectors →  Kafka Topics
→ Elasticsearch Sink Connector → Elasticsearch

- **Debezium**: Captures change data from MongoDB and Postgres.  
- **Kafka Connect**: Manages source and sink connectors.  
- **Kafka Topics**: Intermediate storage for streaming events.  
- **Elasticsearch**: Sink for real-time indexing and search.  

---

## Prerequisites

- Docker & Docker Compose  
- Java 11+ (for Kafka Connect)  
- MongoDB & Postgres databases with test data
- WSL in VSCode 

*Execute -docker commands under WSL terminal.*

---

## How to run the project

## Step 1: Docker Compose

 <code>docker-compose up - d</code>
 <p> To run all the docker images required for this project. </p>


## Step 2: Register Debezium connectors

<p> Register to connect with mongo database</p>

<code>curl -X POST http://localhost:18084/connectors \
-H "Content-Type: application/json" \
-d @mongo-source.json</code>

<p> Register to connect with Postgres database</p>

<code>curl -X POST http://localhost:18084/connectors \
-H "Content-Type: application/json" \
-d @postgres-source.json</code>

- Ensure connectors are active

 <code>curl -s http://localhost:18084/connectors</code>

 <p>Expected output:</p>

<code> ["postgres-source","mongo-source"] </code>

- Ensure Kafka topics are created automatically**

<code> docker exec -it kafka kafka-topics --bootstrap-server localhost:9092 --list</code>


## Step 3: Add Test Data to Mongo

**Connect to MongoDB shell :**

 <code>docker exec -it mongo mongosh</code>

**Switch to your database:**

<code>use inventory</code>

**Insert sample documents:**

 <code>db.customers.insertMany([
  { _id: 1, name: "Alice" },
  { _id: 2, name: "Bob" },
  { _id: 3, name: "Calvin" }
])</code>

**Verify insertion:**

 <code> db.customers.find().pretty() </code>

 **Exit terminal:**

 <code> exit </code>

## Step 4: Add Test Data to Postgres

**Connect to Postgres shell :**

 <code>docker exec -it postgres psql -U postgres -d inventory</code>

**Create a sample table:**

<code>CREATE TABLE IF NOT EXISTS inventory (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  quantity INT,
  category VARCHAR(50)
);</code>

**Insert sample data:**

 <code>INSERT INTO inventory (name, quantity, category) VALUES
('Item D', 120, 'Electronics'),
('Item E', 70, 'Books'),
('Item F', 250, 'Clothing');
</code>

**Verify insertion:**

 <code>SELECT * FROM inventory;</code>

  **Exit terminal:**

 <code>\q</code>

## How to check Kafka real-time messages

* Check the connection with mongo database:

<code> docker exec -it kafka \
kafka-console-consumer --bootstrap-server localhost:9092 \
--topic mongo.inventory.customers --from-beginning</code>

* Check the connection with postgres database:

<code> docker exec -it kafka \
kafka-console-consumer --bootstrap-server localhost:9092 \
--topic postgres.public.inventory --from-beginning</code>

<p>Open another WSL terminal in VS Code. Make changes to mongo db/postgres db to observe the changes in kafka stream.</p>

## How to restart all docker containers 
 <code> docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q) && docker volume prune -f && docker network prune -f </code>







