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
5. Fault tolerance - RDD Files enables reliability over data making Apache Spark fault tolerant.
6. Analytics - Advanced Analytics, Machine Learning and deep learning all come built-in with MLlib Spark with huge capability to add additional ML packages.

## Spark architecture

Apache Spark application consists of two main components: a driver, which converts the user's code into multiple tasks and later jobs that can be distributed across multiple worker nodes, and executors, which run on those nodes and execute the tasks assigned to them. Cluster manager is necessary to orchestrate  between the two.

Spark can run in a standalone cluster mode that simply requires the Apache Spark framework and a JVM on each machine in your cluster, but more likely it is, that you would want more robust resource or cluster management system to take care of allocating workers on demand for you. In the enterprise, this will normally mean running on Hadoop YARN (this is how the Cloudera and Hortonworks distributions run Spark jobs), but Apache Spark can also run on Apache Mesos, Kubernetes, and Docker Swarm.

If you seek a managed solution, then Apache Spark can be found as part of Amazon EMR, Google Cloud Dataproc, and Microsoft Azure HDInsight. Databricks, the company that employs the founders of Apache Spark, also offers the Databricks Unified Analytics Platform, which is a comprehensive managed service that offers Apache Spark clusters, streaming support, integrated web-based notebook development, and optimized cloud I/O performance over a standard Apache Spark distribution.

Apache Spark builds the user’s data processing commands into a Directed Acyclic Graph, or DAG. The DAG is Apache Spark’s scheduling layer; it determines what tasks are executed on what nodes and in what sequence.