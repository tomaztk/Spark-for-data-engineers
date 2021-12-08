# Creating RDD files

<!-- wp:paragraph -->
<p>Spark is created around the concept of resilient distributed datasets (RDD). RDD is a fault-tolerant collection of files that can be used in parallel. RDDs can be created in two ways:<br>- parallelising an existing data collection in driver program<br>- referencing a datasets in external storage (HDFS, blob storage, shared filesystem, Hadoop InputFormat,...)</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>In a simple way, Spark RDD has two opeartions:<br>- transformations - creating a new RDD dataset on top of already existing one with the last transformation<br>- actions - to the action, and return a value to the driver program after running a computation on the dataset.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Map and reduce is where a <code>map</code> is a transformation that uses a function on each dataset and returns a new RDD file that holds the result. <code>Reduce</code> is a action that aggregates all the elements of RDD using a function and returns the result from last created RDD to driver program.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>By default, each transformed of the RDD can be recomputed each time you run an action on it.  But you can also <code>persist</code> RDD in the memory, and makes faster access to data, because it is cached.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","width":622,"height":390} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://miro.medium.com/max/1090/1*2uwvLC1HsWpOsmRw4ZOp2w.png" alt="Spark RDD (Low Level API) Basics using Pyspark | by Sercan Karagoz |  Analytics Vidhya | Medium" width="622" height="390"/></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Using Python, we can run the cluster and start tinkering with a simple file (using my <a rel="noreferrer noopener" href="https://adventofcode.com/2021/day/7" target="_blank">Advent of Code input data puzzle for day 7</a> , because :-) ) </p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">from pyspark.sql import SparkSession

spark:SparkSession = SparkSession.builder()
      .master("local[1]")
      .appName("UsingAoCData")
      .getOrCreate() </pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And we prepare for parallelisation of the RDD:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">data = [1,2,3,4,5,6,7,8,9,10,11,12]
rdd=spark.sparkContext.parallelize(data)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>These files can be created on many different platforms (HDFS, local file,...) and will still have the same characteristics.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Furthermore, you can also create an empty RDD file and later populate it, you can partition the RDD files, create the whole text files and many other options.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>When you use the methods &nbsp;<code>parallelize()</code>, &nbsp;<code> textFile()</code>&nbsp; or&nbsp;<code>wholeTextFiles() </code>&nbsp; methods to store data into  RDD, these will be automatically split into partitions (with limitations of resources available). Number of partitions - as we have already discussed - will be based upon the number of cores available in the system.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into RDD operations (transformations and actions) 🙂</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->