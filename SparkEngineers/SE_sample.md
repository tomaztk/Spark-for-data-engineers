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

1. Data transformation, data modeling 
1. Using relational and non-relational data
1. Desinging pipelines, ETL and data movement
1. Orchestration and architectural view
