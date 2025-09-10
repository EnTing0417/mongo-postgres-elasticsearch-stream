FROM confluentinc/cp-kafka-connect:7.5.0

RUN confluent-hub install --no-prompt debezium/debezium-connector-postgresql:2.7.2 && \
    confluent-hub install --no-prompt debezium/debezium-connector-mongodb:2.7.2
