# Mongo Postgres Elasticsearch Stream: MongoDB & Postgres → Kafka → Elasticsearch

This project implements a **real-time data streaming pipeline** using Kafka Connect and Debezium. It captures changes from **MongoDB** and **Postgres**, streams them to **Kafka topics**, and sinks the data into **Elasticsearch** for search and analytics.

---

## Architecture

MongoDB + Postgres
│
▼
Debezium Connectors
│
▼
Kafka Topics
│
▼
Elasticsearch Sink Connector
│
▼
Elasticsearch

- **Debezium**: Captures change data from MongoDB and Postgres.  
- **Kafka Connect**: Manages source and sink connectors.  
- **Kafka Topics**: Intermediate storage for streaming events.  
- **Elasticsearch**: Sink for real-time indexing and search.  

---

## Prerequisites

- Docker & Docker Compose  
- Java 11+ (for Kafka Connect)  
- MongoDB & Postgres databases with test data