## snowflake-to-kafka-sync
This repository is supporting the medium article I authored on the topic. The artifacts are for syncing Snowflake tables to Kafka using Kafka Connect

All steps mentioned [here] (https://pandeysudhendu.medium.com/streaming-data-from-snowflake-to-kafka-ed76ce0400c2)

In one of my previous blogs, I covered step-by-step how to [move data from Kafka to Snowflake](https://pandeysudhendu.medium.com/getting-started-with-kafka-connector-for-snowflake-3bf596e550bb).

But how about a reverse pattern? Moving data from **Snowflake to Kafka**. There can be a number of use cases for this, but the overarching one could be propagating Snowflake table (change) data to the downstream systems.By the nature of [Apache Kafka](https://kafka.apache.org/), it is purpose-built for a performant pub-sub architecture. This means if you have data from Snowflake that needs to be *streamed *to multiple sinks, you can have Kafka do this routing for you.

Surprisingly, there are not many ‘*how to*’ for this pattern. A few I stumbled upon ([1](https://hevodata.com/learn/snowflake-to-kafka/), [2](https://airbyte.com/connections/Snowflake-to-Kafka)) either involved a cloud storage hop or an EL tool. In fact, I saw [this StackOverflow question](https://stackoverflow.com/questions/62444348/moving-data-from-snowflake-to-kafka) from 2020 with no answer yet!



## What are we going to achieve?

We want to create a flow that streams changes in a Snowflake table to a Kafka Topic. This Kafka topic can then be consumed by downstream applications.

![](https://cdn-images-1.medium.com/max/2876/1*yt9H1QX1fh5-3xP0uCISGg.png)

*The below guide will be step-by-step on how you can achieve this. There is an assumption of knowledge of Snowflake and Kafka. We will concentrate on how to achieve the pattern. This means we will skip some concepts that are not core (docker, wsl2, etc) for this tutorial, but you can easily google them. The objective is to get this setup up and running!*

### Some Kafka terminology:

 1. **Kafka Source**: It is a system that can push (or Kafka can pull) data.

 2. **Kafka Sink**: It is the target system where Kafka feeds the data.

 3. **Kafka Connect:** Free, open-source component of Apache Kafka® that works as a centralized data hub for simple data integration between databases.

 4. **Kafka Topic**: A log of events. It can be a multi-publisher and multi-subscriber.

## High-Level Steps

 1. Create and setup a Snowflake Instance.

 2. Create a Kafka Environment (this will involve setting the Kafka, zookeeper, kafka-connect, etc.)

 3. Setting up Confluent Kafka connect JBDC Source connector.

 4. Installing Snowflake JDBC driver.

 5. Run the Kafka Connector and do a sanity check.

 6. Final step: to see if change data is getting captured!

## Extras:

 1. The Kafka JDBC Connect is very well-built and the [properties](https://docs.confluent.io/kafka-connectors/jdbc/current/source-connector/source_config_options.html) are worth fiddling with.

 2. In our example, our mode was set to increment, but you can set it to incrementing and timestamp. That way, the watermark column (for example updated_at) will be considered and you will receive updates as well.

 3. Since this is not log-based CDC, you suffer from all the drawback (missing deletes, missing subsequent updates, etc.) For that, we can check other options such as [Kafka Connect Debezium](https://rmoff.net/2018/03/24/streaming-data-from-mysql-into-kafka-with-kafka-connect-and-debezium/).

 4. You can write any SQL in the **query** tag. For example, if don’t want the connector to create its custom query of (id< and timestamp <), you can just write a complex SQL expression.

## References:
[**Kafka JDBC Source Connector for Large Data - DZone**
*In this article we are going to look at how we can use Kafka's JDBC Source Connector to query a large table/view in…*dzone.com](https://dzone.com/articles/kafka-jdbc-source-connector-for-large-data)

[**Streaming Data From MySQL with Kafka Connect JDBC Source Connector**
*Kafka Connect is an essential component of the Çiçeksepeti Data Engineering Team’s streaming pipelines. It allows us to…*medium.com](https://medium.com/cstech/streaming-data-from-mysql-with-kafka-connect-jdbc-source-connector-428f4db20b5b)
