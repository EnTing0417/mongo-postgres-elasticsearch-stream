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

## How to run the project

**Step 1: Docker Compose**

 <code>docker-compose up - d</code>
 <p> To run all the docker images required for this project. </p>

**Step 2: Add Test Data to Mongo**

* Execute -docker commands under WSL terminal.

**Connect to MongoDB shell :**

 <code> docker exec -it mongo mongo </code>

**Switch to your database:**

<code> use inventory_db </code>

**Insert sample documents:**

 <code> db.inventory.insertMany([
  { _id: 1, name: "Item A", quantity: 100, category: "Electronics" },
  { _id: 2, name: "Item B", quantity: 50, category: "Books" },
  { _id: 3, name: "Item C", quantity: 200, category: "Clothing" }
])
</code>

**Verify insertion:**

 <code> db.inventory.find().pretty() </code>

 **Exit terminal:**

 <code> exit </code>

**Step 2: Add Test Data to Postgres**

**Connect to Postgres shell :**

 <code> docker exec -it postgres psql -U postgres -d inventory_db</code>

**Create a sample table:**

<code>CREATE TABLE IF NOT EXISTS inventory (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  quantity INT,
  category VARCHAR(50)
);</code>

**Insert sample data:**

 <code> INSERT INTO inventory (name, quantity, category) VALUES
('Item D', 120, 'Electronics'),
('Item E', 70, 'Books'),
('Item F', 250, 'Clothing');
</code>

**Verify insertion:**

 <code> SELECT * FROM inventory;</code>

  **Exit terminal:**

 <code> /q </code>

## How to check Kafka real-time messages

* Check mongo database:

<code> docker exec -it kafka \
kafka-console-consumer --bootstrap-server localhost:9092 \
--topic mongo.inventory.customers --from-beginning</code>

* Check postgres database:

<code> docker exec -it kafka \
kafka-console-consumer --bootstrap-server localhost:9092 \
--topic postgres.public.customers --from-beginning</code>

## How to list all connectors

*run in bash terminal*

 <code> curl -s http://localhost:8083/connectors</code>







