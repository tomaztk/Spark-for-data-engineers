# Setting up Spark IDE

<!-- wp:paragraph -->
<p>Let's look into the IDE that can be used to run Spark. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Remember that Spark can be used with languages: Scala, Java, R, Python and each give you different IDE and different installations.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="jupyter-notebooks">Jupyter Notebooks</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Start Jupyter Notebooks and create a new notebook and you can connect to Local Spark installation.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":7668,"sizeSlug":"large","linkDestination":"media"} -->
<figure class="wp-block-image size-large"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-19.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-19.png?w=1024" alt="" class="wp-image-7668"/></a></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>For the testing purposes you can add code like:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">spark = SparkSession.builder.set_master("spark://tomazs-MacBook-Air.local:7077")</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And start working with the Spark code.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="python">Python</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>In Python, you can open a PyCharm or Spyder and start working with python code:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">import findspark
findspark.init("/opt/spark")
from pyspark import SparkContext

sc = SparkContext(appName="SampleLambda")
x = sc.parallelize([1, 2, 3, 4])
res = x.filter(lambda x: (x % 2 == 0))
print(res.collect())
sc.stop()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:heading -->
<h2 id="r">R</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Open RStudio and install sparkly package, create a context and run a simple R script:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code"># install
devtools::install_github("rstudio/sparklyr")
spark_disconnect(sc)

# install local version
spark_install(version = "2.2.0")

# Create a local Spark master 
sc &lt;- spark_connec(master = "local")

iris_tbl &lt;- copy_to(sc, iris)
iris_tbl

spark_disconnect(sc)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>There you go. This part was fairly short but crucial for coding. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tomorrow we will start exploring spark code. :-)</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->