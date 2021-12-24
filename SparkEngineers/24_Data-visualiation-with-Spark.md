# Data visualisation with Spark

<!-- wp:paragraph -->
<p>In previous posts, we have seen that Spark Dataframes (datasets) are compatible with other classes, functions. Regarding the preferred language (Scala, R, Python, Java).</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3 id="using-python"><strong>Using Python</strong></h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>You can use any of the popular Python packages to do the visualisation; Plotly, Dash,  Seaborn, Matplotlib, Bokeh, Leather, Glam, to name the couple and many others. Once the data is persisted in dataframe, you can use any of the packages. With the use of PySpark, plugin the Matplotlib. Here is an example</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">from pyspark.sql import SparkSession
import matplotlib.pyplot as plt

spark = SparkSession.builder.master("local[*]").getOrCreate()
df = spark.read.format("csv").option("header", "true").load("sampleData.csv")
sampled_data = df.select('x','y').sample(False, 0.8).toPandas()

# and at the end lets use our beautiful matplotlib
plt.scatter(sampled_data.x,sampled_data.y)
plt.xlabel('x')
plt.ylabel('y')
plt.title('relation of y and x')
plt.show()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:heading {"level":3} -->
<h3 id="using-r">Using R</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>With help of </p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">library(sparklyr)
library(ggplot2)
library(dplyr)

#connect
sc &lt;- spark_connect(master = "local")

# data wrangling
flights_tbl &lt;- copy_to(sc, nycflights13::flights, "flights")
delay &lt;- flights_tbl %>%
  group_by(tailnum) %>%
  summarise(count = n(), dist = mean(distance), delay = mean(arr_delay)) %>%
  filter(count > 20, dist &lt; 2000, !is.na(delay)) %>%
  collect

# plot delays
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area(max_size = 2)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:heading {"level":3} -->
<h3 id="using-scala">Using Scala</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>The best way to use the visualisation with Scala is to use the notebooks. It can be a Databricks notebook, the Binder notebook, Zeppelin notebook. Store the results in dataframe and you can visualise the results fast, easy and practically with no coding.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">val ds = spark.read.json("/databricks-datasets/iot/iot_devices.json").as[DeviceIoTData]
display(ds)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:image {"align":"center","id":8004,"width":643,"height":423,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-24.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-24.png?w=1024" alt="" class="wp-image-8004" width="643" height="423"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>And now we can create graphs, that are available to the bottom left side as buttons on Azure Databricks notebooks. Besides the graphs, you can also do data profiling out-of-the-box.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":8007,"width":669,"height":388,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-25.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-25.png?w=1024" alt="" class="wp-image-8007" width="669" height="388"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:image {"align":"center","id":8008,"width":676,"height":488,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-26.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-26.png?w=1024" alt="" class="wp-image-8008" width="676" height="488"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into Spark Literature and where to go for next steps.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->