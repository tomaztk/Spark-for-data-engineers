# What is Apache Spark?

Apache Spark is an open-source unified analytics engine for large-scale data processing. It provides an interface for programming entire clusters with implicit data parallelism and fault tolerance. Originally it was developed at the Berkeley's AMPLab, and later donated to the Apache Software Foundation, which has maintained it since.


Spark is used at a wide range of organizations to process large datasets. 


## Hadoop vs. Spark

| Hadoop     | Spark |
| ----------- | ----------- |
| Process data using MapReduce; Slow     | Processes data 100x faster as MapReduce; Done in memory       |
| Performs batch processing of data   | Performs batch processing and real-time processing of data        |
| Written in Java; more lines of code; longer execution times   | Written in Scala; fewer lines of code        |
| Supports kerberous authentication | Support shared-secrets authentication. Also capable running on YARN with kerberous capability |


## Spark Features

1. Fast Processing - Resilient Distributed Dataset (RDD) is immutable distributed collections of objects. Each dataset in RDD is divided into logical partitions, which may be computed on different nodes of the cluster.
3. In-memory computing -  Data can be stored in RAM (Cached) and hence making it fast for data analysis.
4. Flexibility - Spark supports multiple languages, from Scala, Python, R and Java for application development and data analysis.
5. Fault tolerance
6. Analytics

