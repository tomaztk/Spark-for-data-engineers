# What is Apache Spark?

<!-- wp:paragraph -->
<p>Apache Spark is an open-source unified analytics engine for large-scale data processing. It provides an interface for programming entire clusters with implicit data parallelism and fault tolerance. Originally it was developed at the Berkeley's AMPLab, and later donated to the Apache Software Foundation, which has maintained it since.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7520,"width":505,"height":262,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/spark_logo.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/spark_logo.png?w=1024" alt="" class="wp-image-7520" width="505" height="262"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Spark is used at a wide range of organizations to process large datasets.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p></p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="spark-features"><a href="https://github.com/tomaztk/Spark-for-data-engineers/blob/main/SparkEngineers/01_what-is-apache-spark.md#spark-features"></a>Spark Features</h2>
<!-- /wp:heading -->

<!-- wp:list {"ordered":true} -->
<ol><li>Fast Processing - Resilient Distributed Dataset (RDD) is immutable distributed collections of objects. Each dataset in RDD is divided into logical partitions, which may be computed on different nodes of the cluster.</li><li>In-memory computing - Data can be stored in RAM (Cached) and hence making it fast for data analysis.</li><li>Flexibility - Spark supports multiple languages, from Scala, Python, R and Java for application development and data analysis.</li><li>Fault tolerance - RDD Files enables reliability over data making Apache Spark fault tolerant.</li><li>Analytics - Advanced Analytics, Machine Learning and deep learning all come built-in with MLlib Spark with huge capability to add additional ML packages.</li></ol>
<!-- /wp:list -->

<!-- wp:heading -->
<h2 id="spark-architecture"><strong>Spark architecture</strong></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Apache Spark application consists of two main components: a driver, which converts the user's code into multiple tasks and later jobs that can be distributed across multiple worker nodes, and executors, which run on those nodes and execute the tasks assigned to them. Cluster manager is necessary to orchestrate &nbsp;between the two.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><br>Spark can run in a standalone cluster mode that simply requires the Apache Spark framework and a JVM on each machine in your cluster, but more likely it is, that you would want more robust resource or cluster management system to take care of allocating workers on demand for you. In the enterprise, this will normally mean running on Hadoop YARN (this is how the Cloudera and Hortonworks distributions run Spark jobs), but Apache Spark can also run on Apache Mesos, Kubernetes, and Docker Swarm.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><br>If you seek a managed solution, then Apache Spark can be found as part of Amazon EMR, Google Cloud Dataproc, and Microsoft Azure HDInsight. Databricks, the company that employs the founders of Apache Spark, also offers the Databricks Unified Analytics Platform, which is a comprehensive managed service that offers Apache Spark clusters, streaming support, integrated web-based notebook development, and optimized cloud I/O performance over a standard Apache Spark distribution.<br></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Apache Spark builds the user’s data processing commands into a Directed Acyclic Graph, or DAG. The DAG is Apache Spark’s scheduling layer; it determines what tasks are executed on what nodes and in what sequence.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="learning-spark-for-data-engineers"><strong>Learning Spark for Data Engineers</strong></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Data engineers position is slightly different of analytical positions. Instead of mathematics, statistics and advanced analytics skills, learning Spark for data engineers will be focused on topics:<br><br>1. Installation and setting up the Spark environment<br>2. Getting to know the environment, UI, Spark Web<br>2. Data executions and Spark API<br>2. Data transformation, data modelling and diving into DataFrames<br>3. Using relational and non-relational data with Spark SQL<br>4. Designing pipelines, ETL, data movement  and orchestration using Azure solutions and Databricks<br>5. Connection to other services, Spark applications, Azure, On-prem solutions, SQL Server and Big Data Clusters</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>This year, the Advent of 2021 will bring you blog posts on Spark mostly for a role of  data engineers. But also the series will be targeting: </p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>Beginners and everyone aspiring to become a data engineer,</li><li>Data Analysts, Data scientists, Data Operations and Machine Learning who want to deepen the knowledge on Spark</li><li>SQL developers, R developers, Python developers who wants to dive into data engineering.</li></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository: <a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into the process of installation. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! :-) </p>
<!-- /wp:paragraph -->