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