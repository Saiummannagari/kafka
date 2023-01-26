#!/bin/bash


# https://acloudguru.com/hands-on-labs/streaming-data-using-kafka-streams-to-count-words
# download kafka at  https://www.apache.org/dyn/closer.cgi?path=/kafka/0.11.0.1/kafka_2.11-0.11.0.1.tgz
# extract kafka in a folder

### LINUX / MAC OS X ONLY

# open a shell - zookeeper is at localhost:2181
bin/zookeeper-server-start.sh config/zookeeper.properties

# open another shell - kafka is at localhost:9092
bin/kafka-server-start.sh config/server.properties

# create input topic
bin/kafka-topics.sh --create --topic testtopicinput --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1

# create output topic
bin/kafka-topics.sh --create --topic testtopicoutput --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1

# start a kafka producer
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic testtopicinput
# enter
kafka streams udemy
kafka data processing
kafka streams course
# exit

# verify the data has been written
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic testtopicinput --from-beginning

# start a consumer on the output topic
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic testtopicoutput \
    --from-beginning \
    --formatter kafka.tools.DefaultMessageFormatter \
    --property print.key=true \
    --property print.value=true \
    --property key.deserializer=org.apache.kafka.common.serialization.StringDeserializer \
    --property value.deserializer=org.apache.kafka.common.serialization.LongDeserializer

# start the streams application
bin/kafka-run-class.sh org.apache.kafka.streams.examples.wordcount.WordCountDemo

# list of topic 
bin/kafka-topics.sh --list --bootstrap-server localhost:9092    

#delete topic
bin/kafka-topics.sh --bootstrap-server localhost:9092 --delete --topic testtopicoutput


#describe topic
bin/kafka-topics.sh --describe --bootstrap-server localhost:9092 --topic testtopicinput

# verify the data has been written to the output topic!
