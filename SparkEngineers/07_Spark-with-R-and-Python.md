# Starting Spark with  R and Python

<!-- wp:paragraph -->
<p>Let’s look into the local use of Spark. For R language, <code>sparklyr</code> package is availble and for Python <code>pyspark</code> is availble.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="starting-spark-with-r">Starting Spark with R</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Starting RStudio and install the local Spark for R. And Java 8/11 must also be available in order to run Spark for R.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Install the needed packages and install the desired Spark version:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">install.packages("sparklyr")
spark_install(version = "2.1")

library(sparklyr)
sc &lt;- spark_connect(master = "local", version = "2.1.0")</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Once the Spark_connect is created, we can start using  the connector for data transformation and data analysis. A simple call for Iris dataset and plotting the data:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">iris_tbl &lt;- copy_to(sc, iris)
plot(iris_tbl$Petal.Length, iris_tbl$Petal.Width, pch=c(23,24,25), bg=c("red","green3","blue")[unclass(iris_tbl$Species)], main="Plotting Iris")</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:image {"align":"center","id":7679,"width":557,"height":438,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-20.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-20.png?w=1024" alt="" class="wp-image-7679" width="557" height="438"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>And at the end, close the connection:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">spark_disconnect(sc)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>When using sparklyr, there are no limitation to which cluster and server you can connect. Connecting to local or to cluster mode, both are acceptable. There should only be Java and Spark installed.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="starting-spark-with-python">Starting Spark with Python</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Start your favourite Python IDE. In my case PCharm and in this case, I will use already installed Spark engine and connect to it using Python. </p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">import findspark
findspark.init("/opt/spark")
from pyspark import SparkContext</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>With using pyspark, we will connect to standalone local mode, that can be execute by using (in folder:  /usr/local/Cellar/apache-spark/3.2.0/libexec/sbin):</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">start-master.sh --master local</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And the context can now be used with: <code>spark://tomazs-MacBook-Air.local:7077</code></p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">sc = SparkContext('spark://tomazs-MacBook-Air.local:7077', 'MyFirstSparkApp')</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And we can import some csv data, create a spark session and start working with the dataset.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">data=spark.read.format("csv") \
    .option("header","true") \
    .option("mode","DROPMALFORMED") \
    .load('/users/tomazkastrun/desktop/iris.csv')</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And simply create a plot:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">import seaborn as sns
sns.set_style("whitegrid")
sns.FacetGrid(data, hue ="species",height = 6).map(plt.scatter,'sepal_length', 'petal_length').add_legend()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And get the result:</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7687,"width":-171,"height":-139,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-21.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-21.png?w=1024" alt="" class="wp-image-7687" width="-171" height="-139"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>And again, close the spark context connection:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">sc.stop()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Tomorrow we will start working with dataframes. 🙂</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->