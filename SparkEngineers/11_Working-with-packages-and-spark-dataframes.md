# Working with packages and spark dataFrames

<!-- wp:paragraph -->
<p>When you install Spark, the extension of not only languages but also other packages, systems is huge. For example with R, not only that you can harvest the capabilities of distributed and parallel computations, you can also extend the use of R language.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="r">R</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Variety of extensions are available from CRAN repository or from Github. Spark with flint, spark with Avro, Spark with EMR and many more. For data analysis and machine learning, you can take for example: <code>sparktf</code> (with Tensor flow), <code>xgboost</code> (compatible for Spark), geospark for working with geospatial data, spark for R on Google Cloud, and many omre. A simple way to start is to install extensions:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">library(sparkextension)
library(sparklyr)

sc &lt;- spark_connect(master = "spark://192.168.0.184:7077")</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>and set it to master and I can have all additional packages installed on Spark master. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Futhermore,  <code>rsparkling</code> extension, gives you even more capabilities and enables you to use H2O in Spark with R.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Downloading from the cloud and installing the <code>H2O</code> and <code>rsparkling</code>.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">install.packages("h2o", type = "source",
  repos = "http://h2o-release.s3.amazonaws.com/h2o/rel-yates/5/R")
install.packages("rsparkling", type = "source",
  repos = "http://h2o-release.s3.amazonaws.com/sparkling-water/rel-2.3/31/R")</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And working with H2O is besides defining the:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">library(rsparkling)
library(sparklyr)
library(h2o)

sc &lt;- spark_connect(master = "local", version = "2.3", config = list(sparklyr.connect.timeout = 120))

#getting data
iris_spark &lt;- copy_to(sc, iris)

#converting to h2o on spark dataframe
iris_spark_h2o &lt;- as_h2o_frame(sc, iris_spark)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:heading -->
<h2 id="python">Python</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>With Python, the extensibility is also rich as with R, and There are even more packages available. Python also has the extenstion called pySparkling with H2O Python packages.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">pip install h2o_pysparkling_2.2
pip install requests
pip install tabulate
pip install future</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And running a cluster:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">from pysparkling import *

import h2o
hc = H2OContext.getOrCreate()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And passing the spark dataframe to H2O </p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">import h2o
frame = h2o.import_file("https://raw.githubusercontent.com/h2oai/sparkling-water/master/examples/smalldata/prostate/prostate.csv")
sparkDF = hc.asSparkFrame(frame)
sparkDF = sparkDF.withColumn("CAPSULE", sparkDF.CAPSULE.cast("string"))
[trainingDF, testingDF] = sparkDF.randomSplit([0.8, 0.2])</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And you can start working with anything relating to dataframes, machine learning and more.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">from pysparkling.ml import H2OAutoML
automl = H2OAutoML(labelCol="CAPSULE", ignoredCols=["ID"])</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Tomorrow we will look Spark SQL and how to get on-board.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->