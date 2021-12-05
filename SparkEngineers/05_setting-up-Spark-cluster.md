<!-- wp:paragraph -->
<p>We have explore the Spark architecture and look into the differences between local and cluster mode.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>So, if you navigate to your local installation of Apache-Spark (/usr/local/Cellar/apache-spark/3.2.0/bin) you can run Spark in R, Python, Scala with following commands. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>For Scala</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">spark-shell --master local</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Python</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">pyspark --master local</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>and R</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">sparkR --master local</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>and your WEB UI will change the application language accordingly.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7640,"width":840,"height":140,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-14.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-14.png?w=1024" alt="" class="wp-image-7640" width="840" height="140"/></a><figcaption>SparkR application UI</figcaption></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Spark can run both by itself, or over several existing cluster managers. It currently provides several options for deployment. If you decide to use Hadoop and YARN, there is usually the installation needed to install everything on nodes. Installing Java, JavaJDK, Hadoop and setting all the needed configuration. This installation is preferred when installing several nodes. A good example and explanation is available <a rel="noreferrer noopener" href="https://techblost.com/how-to-install-hadoop-on-mac-with-homebrew/" target="_blank">here</a>. you will also be installing HDFS that comes with Hadoop.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="spark-standalone-mode">Spark Standalone Mode</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Besides running Hadoop YARN, Kubernetes or Mesos, this  is the simplest way to deploy Spark application on private cluster.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>In local mode, WEB UI would be available at: http://localhost:4040, the standalone mode is available at http://localhost:8080.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Installing Spark Standalone mode is made simple. You copy the complied version of Spark on each node on the cluster. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Starting a cluster manually, navigate to folder: /usr/local/Cellar/apache-spark/3.2.0/libexec/sbin and run</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"bash"} -->
<pre class="wp-block-syntaxhighlighter-code">start-master.sh 
bash start-master.sh</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:image {"align":"center","id":7649,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-16.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-16.png?w=575" alt="" class="wp-image-7649"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Once started, go to  URL on a master's web UI: http://localhost:8080.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7645,"width":688,"height":396,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-15.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-15.png?w=1024" alt="" class="wp-image-7645" width="688" height="396"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>We can add now a worker by calling this command:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"bash"} -->
<pre class="wp-block-syntaxhighlighter-code">start-worker.sh spark://tomazs-MacBook-Air.local:7077</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>and the message in CLI will return:</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7651,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-17.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-17.png?w=571" alt="" class="wp-image-7651"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Refresh the Spark master's Web UI and check the worker node:</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7653,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-18.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-18.png?w=1024" alt="" class="wp-image-7653"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:heading -->
<h2 id="connecting-and-running-application">Connecting and running application</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>To run the application on Spark cluster, use the spark://tomazs-MacBook-Air.local:7077 URL of the master with <code>SparkContext</code> constructor.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Or simply run the following command (in the folder: /usr/local/Cellar/apache-spark/3.2.0/bin) and run</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"bash"} -->
<pre class="wp-block-syntaxhighlighter-code">spark-shell --master spark://tomazs-MacBook-Air.local:7077</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>With <code>spark-submit</code> command we can run the application with Spark Standard cluster with cluster deploy mode. Navigate to /usr/local/Cellar/apache-spark/3.2.0/bin and execute:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"bash"} -->
<pre class="wp-block-syntaxhighlighter-code">spark-submit \
  --class org.apache.spark.examples.SparkPi \
  --master spark://tomazs-MacBook-Air.local:7077\
  --executor-memory 20G \
  --total-executor-cores 100 \
python1hello.py </pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>With Python script as simple as: </p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">x = 1
if x == 1:
    print("Hello, x = 1.")</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into IDE and start working with the code.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->