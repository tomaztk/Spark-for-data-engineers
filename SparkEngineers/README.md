# Spark for data engineers

Spark for data engineers is repository that will provide readers overview, code samples and examples for better tackling Spark.

<img src="images/Spark_logo.png"  width="240" />


## What is Spark and why does it matter for Data Engineers

Data Analysts, data Scientist, Business Intelligence analysts and many other roles require data on demand.
Fighting with data silos, many scatter databases, Excel files, CSV files, JSON files, APIs and  potentially different flavours of cloud storage may be tedious, nerve-wracking
and time-consuming.

Automated process that would follow set of steps, procedures and processes take subsets of data, columns from database, binary files and merged them together to 
serve business needs and potentials is and still will be a favorable job for many organizations and teams.

Spark is an absolute winner for this tasks and a great choice for adoption.

Data Engineering should have the extent and capability to do:

1. System architecture
1. Programming
1. Database design and configuration
1. Interface and sensor configuration


And in addition to that, it is as important as familiarity with the technical tools is, the concepts of data architecture and pipeline design are even more important. The tools are worthless without a solid conceptual understanding of:

1. Data models
1. Relational and non-relational database design
1. Information flow
1. Query execution and optimization
1. Comparative analysis of data stores
1. Logical operations

Apache Spark have all the technology built-in to cover these topics and has the capacity for achieving a concrete goal for assembling together functional systems to do the goal.


Apache Spark™ is designed to to build faster and more reliable data pipelines, cover low level and structured API and brings tools and packages for Streaming data, Machine Learning, data engineering and building pipelines and extending the Spark ecosystem.

## Spark’s Basic Architecture

Single machines do not have enough power and resources to perform computations on huge amounts of information (or the user may not have time to wait for the computation to finish). 

A cluster, or group of machines, pools the resources of many machines together allowing us to use all the cumulative  resources as if they were one. Now a group of machines alone is not powerful, you need a framework to coordinate  work across them. Spark is a tool for just that, managing and coordinating the execution of tasks on data across a  cluster of computers.
The cluster of machines that Spark will leverage to execute tasks will be managed by a cluster manager like Spark’s  Standalone cluster manager, YARN, or Mesos. We then submit Spark Applications to these cluster managers which will  grant resources to our application so that we can complete our work.

## Spark Applications

Spark Applications consist of a driver process and a set of executor processes. The driver process runs your main() function, sits on a node in the cluster, and is responsible for three things: maintaining information about the Spark  Application; responding to a user’s program or input; and analyzing, distributing, and scheduling work across the  executors (defined momentarily). The driver process is absolutely essential - it’s the heart of a Spark Application and  maintains all relevant information during the lifetime of the application.

The executors are responsible for actually executing the work that the driver assigns them. This means, each executor is responsible for only two things: executing code assigned to it by the driver and reporting the state of the computation, on that executor, back to the driver node.


## Learning Spark for Data Engineers

Data engineers position is slightly different of analytical positions. Instead of mathematics, statistics and advanced analytics skills, learning Spark for data engineers will be focus on topics:

1. Installation and seting up the environment
1. Data transformation, data modeling 
1. Using relational and non-relational data
1. Desinging pipelines, ETL and data movement
1. Orchestration and architectural view


## Table of content / Featured blogposts 


1. [What is Apache Spark](https://github.com/tomaztk/Spark-for-data-engineers/blob/main/SparkEngineers/01_what-is-apache-spark.md) ([blogpost](https://tomaztsql.wordpress.com/2021/12/01/advent-of-2021-day-1-what-is-apache-spark/))
1. [Installing Apache Spark]() ([blogpost]())
1. [Getting around CLI and WEB UI in Apache Spark]() ([blogpost]())
1. [Spark Architecture – Local and cluster mode]() ([blogpost]())
1. [Setting up Spark Cluster]() ([blogpost]())
1. [Setting up IDE]() ([blogpost]())
1. [Starting Spark with R and Python]() ([blogpost]())
1. [Creating RDD files]() ([blogpost]())
1. [RDD Operations]() ([blogpost]())
1. [Working with data frames]() ([blogpost]())
1. [Working with packages and spark DataFrames]() ([blogpost]())


 ## Blog

 All posts were originally posted on my [blog](https://tomaztsql.wordpress.com) and made copy here at Github. On Github is extremely simple to clone the code, markdown file and all the materials.

 ## Cloning the repository
 You can follow the steps below to clone the repository.

 ```
sudo git clone -n https://github.com/tomaztk/Spark-for-data-engineers.git
 ```

 ## Contact
 Get in contact if you would like to contribute or simply fork a repository and alter the code.

 ## Contributing
 Do the usual GitHub fork and pull request dance. Add yourself (or I will add you to the contributors section) if you want to. 


 ## Suggestions
 Feel free to suggest any new topics that you would like to be covered.

 ## Github.io
All code is available also at github  [tomaztk.github.io](https://tomaztk.github.io) and in this repository.

Book is created using mdBook (with Rust and Cargo).

 ## License
 [MIT](https://choosealicense.com/licenses/mit/) © Tomaž Kaštrun
