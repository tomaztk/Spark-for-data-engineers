# Spark SQL query hints and executions


<!-- wp:paragraph -->
<p>Caching data in most cases will improve your query performance and execution. Most commonly used command for caching table in Spark SQL is by using in-memory columnar format with <code>dataFrame.cache()</code>. This will tell Spark SQL to scan only required columns and will automatically tune compression to minimize memory usage.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>To remove table from cache, you can call the <code>dataFrame.unpersist()</code> function.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Configuring the in-memory caching using the <code>setConf</code> method on <code>SparkSession</code> or by running <code>SET key=value</code> commands using SQL. Some of the optimisation can be done by tuning the parameters with key and value of couple of selected:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><code>spark.sql.inMemoryColumnarStorage.compressed<br>spark.sql.inMemoryColumnarStorage.batchSize<br>spark.sql.files.minPartitionNum<br>spark.sql.shuffle.partitions<br>spark.sql.sources.parallelPartitionDiscovery.parallelism</code></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Spark SQL can also be optimized with couple of JOIN hints. These are:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><code>BROADCAST</code><br><code>MERGE</code> <br><code>SHUFFLE_HASH</code> and <br><code>SHUFFLE_REPLICATE_NL</code></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>And all can be used with different languages; Scala, R, Python, SQL and Java.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><strong>R</strong> will look like:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">Data1 &lt;- sql("SELECT * FROM table1")
Data2 &lt;- sql("SELECT * FROM table2")
head(join(Data1, hint(Data2, "broadcast"), Data1$key == Data2$key))</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p><strong>Python</strong> will look like:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">spark.table("Data1").join(spark.table("Data2").hint("broadcast"), "key").show()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p><strong>SQL</strong> will look like:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"sql"} -->
<pre class="wp-block-syntaxhighlighter-code">SELECT  BROADCAST(r),* FROM Data1 AS d JOIN Data2 AS s ON r.key = s.key
-- OR with Broadcastjoin
SELECT BROADCASTJOIN (r) FROM Data1 AS d JOIN Data2 AS s ON r.key = s.key</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>This hint instructs Spark to use the hinted strategy on specified relation when joining tables together. When <code>BROADCASTJOIN</code> hint is used on <code>Data1</code> table with <code>Data2</code> table and overrides the suggested setting of statistics from configuration <code>spark.sql.autoBroadcastJoinThreshold</code>.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Spark also prioritise the join strategy, and also when different JOIN strategies are used, Spark SQL will always prioritise them.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Repartitioning Spark SQL hints are good for performance tuning and reducing the number of outputed results (or files).</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The “COALESCE” hint only has a partition number as a parameter.<br>The “REPARTITION” hint has a partition number, columns, or both/neither of them as parameters.<br>The “REPARTITION_BY_RANGE” hint must have column names and a partition number is optional.<br></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>These hints are only available in Spark SQL language. The syntax is as following</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">SELECT  COALESCE(3) * FROM Data1;
SELECT  REPARTITION(3) * FROM Data1;
SELECT REBALANCE * FROM Data1;</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>There are also some features worth looking at to handle better optimisation.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tomorrow we will make a gentle introduction into Spark Streaming.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->