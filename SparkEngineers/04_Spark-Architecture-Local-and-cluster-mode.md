# Spark Architecture - Local and cluster mode

<!-- wp:paragraph -->
<p>Before diving into IDE, let's see what kind of architecture is available in Apache Spark.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="architecture">Architecture</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Finding the best way to write Spark will be dependent of the language flavour. As we have mentioned, Spark runs both on Windows and Mac OS or Linux (both UNIX-like systems). And you will need Java installed to run the clusters. Spark runs on Java 8/11, Scala 2.12, Python 2.7+/3.4+ and R 3.1+. And the language flavour can also determine which IDE will be used.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Spark comes with several sample scripts available and you can run them simply by heading to CLI and calling for example the following commands for R or Python:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>R:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">sparkR --master local[2]
spark-submit examples/src/main/r/dataframe.R</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And for Python:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">pyspark --master local[2]
spark-submit examples/src/main/python/pi.py 10</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>But each time, we need to initialize and run the cluster in order to have commands up and running.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="running-in-local-mode-and-running-in-a-cluster">Running in local mode and running in a cluster</h2>
<!-- /wp:heading -->

<!-- wp:heading {"level":3} -->
<h3 id="local-mode">Local mode</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>The Spark cluster mode is available immediately upon running the shell. Simply run <code>sc </code>and you will get the context information:</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7605,"width":732,"height":109,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-7.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-7.png?w=1024" alt="" class="wp-image-7605" width="732" height="109"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>In addition, you can run also:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">sc.local
sc.master</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And you will receive the information about the context and execution mode.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":7609,"sizeSlug":"large","linkDestination":"media"} -->
<figure class="wp-block-image size-large"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-8.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-8.png?w=1024" alt="" class="wp-image-7609"/></a></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Local mode is the default mode  and does not require any resource management. When you start spark-shell command, it is already up and running. Local mode are also good for testing purposes, quick setup scenarios and have number of partitions equals to number of CPU on local machine. You can start in local mode with any of the following commands:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">spark-shell
spark-shell --master local
spark-shell -- master local[*]
spark-shell -- master local[3]</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>By the default the<code> spark-shell </code>will execute in local mode, and you can specify the master argument with local attribute with how many threads you want Spark application to be running; remember, Spark is optimised for parallel computation. Spark in local mode will run with single thread. With passing the number of CPU to local attribute, you can execute in multi-threaded computation.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7614,"width":409,"height":233,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-9.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-9.png?w=1024" alt="" class="wp-image-7614" width="409" height="233"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:heading {"level":3} -->
<h3 id="cluster-mode">Cluster Mode</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>When it comes to cluster mode, consider the following components:</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","width":596,"height":286} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://spark.apache.org/docs/3.0.0-preview/img/cluster-overview.png" alt="Spark cluster components" width="596" height="286"/><figcaption>(source: https://spark.apache.org/)</figcaption></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>When running Spark in cluster mode, we can refer to as running spark application in set of processes on a cluster(s), that are coordinated by driver. The driver program is using the SparkContext object to connect to different types of cluster managers. These managers can be:<br>- Standalone cluster manager (Spark's own manager that is deployed on private cluster)<br>- Apache Mesos cluster manager<br>- Hadoop YARN cluster manager<br>- Kubernetes cluster manager.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Cluster manager is responsible to allocate the resources across the Spark Application. This architecture has several advantages. Each application run is isolated from other application run, because each gets its own executor process. Driver schedules its own tasks and executes it in different application run on different JVM. Downside is, that data can not be shared across different Spark applications, without being written (RDD) to a storage system, that is outside of this particular application</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Running  Spark in cluster mode, we will need to run with <code>spark-submit </code>command and not <code>spark-shell </code>command. The general code is:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"bash"} -->
<pre class="wp-block-syntaxhighlighter-code">spark-submit \
  --class &lt;main-class> \
  --master &lt;master-url> \
  --deploy-mode &lt;deploy-mode> \
  --conf &lt;key>=&lt;value> \
  ... # other options
  &lt;application-jar> \
  [application-arguments]</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And commonly used are:<br><code>--class</code>: The entry point for your application<br><code>--master</code>: The master URL for the cluster <br><code>--deploy-mode</code>: Whether to deploy your driver on the worker nodes (<code>cluster</code>) or locally as an external client (<code>client</code>) (default:&nbsp;<code>client</code>)&nbsp;</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Simple <code>spark-submit --help </code>will get you additional information:</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7624,"width":670,"height":341,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-10.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-10.png?w=1024" alt="" class="wp-image-7624" width="670" height="341"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into the Spark-submit and cluster installation.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->