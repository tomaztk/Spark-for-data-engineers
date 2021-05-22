# What is RDD , how does it work and why is it important

Spark revolves around the concept of a resilient distributed dataset, shortly as RDD. RDD is a fault-tolerant collection of elements that can be operated on in parallel. 

There are two ways to create RDDs: parallelizing an existing collection in your driver program, or  referencing a dataset in an external storage system, 
such as a shared filesystem, HDFS, HBase, or any data source offering a Hadoop InputFormat.

