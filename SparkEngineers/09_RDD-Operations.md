# RDD Operations

<!-- wp:paragraph -->
<p>Two types of operations are available with RDD; transformations and actions. Transformations are lazy operations, meaning that they prepare the new RDD with every new operation but now show or return anything. We can say, that transformations are lazy because of updating existing RDD, these operations create another RDD. Actions on the other hand trigger the computations on RDD and show (return) the result of transformations.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="transformations">Transformations</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Transformations can be narrow or wide. As the name suggest, the difference is, where the data resides and type of transformation.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>In <strong>narrow transformation </strong> all the elements that are required to compute the records in single partition live in the single partition of parent RDD. A limited subset of partition is used to calculate the result. These transformation are &nbsp;<em>map(), filter(), sample(), union(), MapPartition()</em>, FlatMap().</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>With <strong>wide transformation</strong> elements that are required to compute the records in the single partition may live in many partitions of parent RDD. The partition may live in many partitions of parent RDD.&nbsp;When using functions&nbsp;<em>groupbyKey(</em>),&nbsp;<em>reducebyKey(), join(), cartesian(), repartition(), coalesce(), intersection(), distinct()</em> we say that the RDD has undergone the wide transformation.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Nice presentation of these operations:</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","width":648,"height":414} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://www.researchgate.net/profile/Tathagata-Das-3/publication/262233351/figure/fig3/AS:669466224513041@1536624594827/Examples-of-narrow-and-wide-dependencies-Each-box-is-an-RDD-with-partitions-shown-as.png" alt="Examples of narrow and wide dependencies. Each box is an RDD, with... |  Download Scientific Diagram" width="648" height="414"/><figcaption><a href="https://www.researchgate.net/figure/Examples-of-narrow-and-wide-dependencies-Each-box-is-an-RDD-with-partitions-shown-as_fig3_262233351" target="_blank" rel="noreferrer noopener">Source</a></figcaption></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>A simple example using R would be:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">library(sparklyr)

sdf_len(sc, 10) %>%
  spark_apply(~nrow(.x)) %>%
  sdf_repartition(1) %>%
  spark_apply(~sum(.x))</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Or applying function to more nodes: </p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">sdf_len(sc, 4) %>%
  spark_apply(
    function(data, context) context * data,
    context = 100
  )</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:image {"align":"center","width":480,"height":175} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://therinspark.com/the-r-in-spark_files/figure-html/distributed-times-context-1.png" alt="Map operation when multiplying with context" width="480" height="175"/></figure></div>
<!-- /wp:image -->

<!-- wp:heading -->
<h2 id="actions">Actions</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Actions are what triggers the transformation. Values of action are stored to drivers or to external storage. And we can say that Actions nudges spark's laziness into motion. It sents data from executer to the driver. Executors are agens that are responsible for executing a task.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>These tasks are (listing just the most frequent ones)  <em>count(), collect(), take(), top(), reduce(), aggregate(), foreach()</em>.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">library(sparklyr)
iris %>%
  spark_apply(
    function(e) summary(lm(Petal_Length ~ Petal_Width, e))$r.squared,
    names = "r.squared",
    group_by = "Species")</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Actions occur in last step, just before the result (value) is returned.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center"} -->
<div class="wp-block-image"><figure class="aligncenter"><img src="http://tomaztsql.files.wordpress.com/2021/12/148ff-1rtyvhjinshf_5yhf8c0z0q.png" alt="Beneath RDD(Resilient Distributed Dataset) in Apache Spark | by Gangadhar  Kadam | Medium"/></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Tomorrow we will look start working with data frames.🙂</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->