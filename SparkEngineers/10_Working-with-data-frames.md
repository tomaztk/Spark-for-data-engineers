# Working with data frames

<!-- wp:paragraph -->
<p>We have looked in datasets and seen that a dataset is distributed collection of data. A dataset can be constructer from JVM object and later manipulated with transformation operations (e.g.: filter(), Map(),...). API for these datasets are also available in Scala and in Java. But in both cases of Python and R, you can also access the columns or rows from datasets. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>On the other hand, dataframe is organised dataset with named columns. It offers much better optimizations and computations and still resembles a typical table (as we know it from database world). Dataframes can be constructed from arrays or from matrices from variety of files, SQL tables, and datasets (RDDs). Dataframe API is available in all flavours: Java, Scala, R and Python and hence it's popularity.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="dataframes-with-r">Dataframes with R</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Start a session and get going:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">spark_path &lt;- file.path(spark_home, "bin", "spark-class")

# Start cluster manager master node
system2(spark_path, "org.apache.spark.deploy.master.Master", wait = FALSE)

# Start worker node, find master URL at http://localhost:8080/
system2(spark_path, c("org.apache.spark.deploy.worker.Worker", "spark://192.168.0.184:7077"), wait = FALSE)

sparkR.session(appName = "R Dataframe Session", sparkConfig = list("org.apache.spark.deploy.worker.Worker" = "spark://192.168.0.184:7077"))</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And start working with dataframe by importing a short and simple json file (copy this and store it to people.json file):</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"yaml"} -->
<pre class="wp-block-syntaxhighlighter-code">{"name":"Michael", "age":29, "height":188}
{"name":"Andy", "age":30, "height":201}
{"name":"Justin", "age":19, "height":175}</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">df &lt;- read.json("usr/library/main/resources/people.json")
head(df)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And we can do many several transformations:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">head(select(df, df$name, df$age + 1))

head(where(df, df$age > 21))

# Count people by age
head(count(groupBy(df, "age")))</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And also by adding and combining additional packages (e.g.: dplyr, ggplot):</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">dbplot_histogram(height, age)

# adding ggplot
library(ggplot2)
library(tidyverse)

df_new %>% 
    gather(df, age, height) %>% 
    ggplot(aes(df, age, fill = factor(height))) + 
    geom_boxplot()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>There are many other functions that can be used with Spark Dataframes API with R. Alternatively, we can also do the same with Python.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="dataframes-with-python">Dataframes with Python</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Start a session and get going:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .appName("Python Dataframe Session API") \
    .config("org.apache.spark.deploy.worker.Worker", "spark://192.168.0.184:7077") \
    .getOrCreate()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And we can start with importing data into data frame.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">df &lt;- read.json("examples/src/main/resources/people.json")
head(df)

# or show complete dataset
showDF(df)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And working with filters and subsetting the dataframe - as it would be a normal numpy/pandas dataframe</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">df.select(df['name'], df['age'] + 1).show()

#filtering by age
df.filter(df['age'] > 21).show()

#grouping by age and displaying the count
df.groupBy("age").count().show()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Tomorrow we will look how to  plug the R or Python dataframe with  packages and get more out of the data.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->