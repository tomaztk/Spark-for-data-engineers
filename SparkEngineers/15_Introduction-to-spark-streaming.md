# Introduction to Spark Streaming

<!-- wp:paragraph -->
<p>Spark Streaming or Structured Streaming is a scalable and fault-tolerant, end-to-end stream processing engine. it is built on the Spark SQL engine. Spark SQL engine will is responsible for running results sets for streaming data, regardless of static or continuously in coming stream data.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Spark stream can use Dataframe (or Datasets) API in Scala, Python, R or Java to work on handling data ingest, creating streaming analytics and do all the computations. All these requests and workloads are done against Spark SQL engine.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Spark SQL engine for the structured streaming queries have undergo some changes with Spark 2.3 and now uses low-latency processing mode called continuous processing. This mode is capable of achieving end-to-end low latency times (as low as 1 millisecond per changes or query operations on dataframe/dataset)</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="quick-setup-using-r">Quick setup using R</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Assuming that you have all the installation completed, and we start with starting the master cluster. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Before starting, we will need to run Netcat (nc) server and we can start the localhost. Netcat is s a command-line utility that reads and writes data across network connections, using the TCP or UDP protocols. And this will generate and mimic the streaming data. To run the Netcat server, run the following CLI commnand (server: localhost; port: 9999):</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"bash"} -->
<pre class="wp-block-syntaxhighlighter-code">nc -lk 9999</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Using R we will connect to master and create a session.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">library(SparkR)
sparkR.session(appName = "StructuredStreamApp")</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And we will define a dataframe, where we want to store the streaming data</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code"># Create DataFrame representing the stream of input lines from connection to localhost:9999
lines &lt;- read.stream("socket", host = "localhost", port = 9999)

# Split the lines into words
words &lt;- selectExpr(lines, "explode(split(value, ' ')) as word")

# Generate running word count
wordCounts &lt;- count(group_by(words, "word"))</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Copy paste this script in R file (name it: Stream-word-count.R):</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">library(SparkR)
sparkR.session(appName = "StructuredStreamApp")

hostname &lt;- args[[1]]
port &lt;- as.integer(args[[2]])
lines &lt;- read.stream("socket", host = hostname, port = port)

words &lt;- selectExpr(lines, "explode(split(value, ' ')) as word")

wordCounts &lt;- count(groupBy(words, "word"))

query &lt;- write.stream(wordCounts, "console", outputMode = "complete")
awaitTermination(query)
sparkR.session.stop()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And run this script from CLI using spark-submit bash and push it to localhost on port 9999, that you have already started using nc:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"bash"} -->
<pre class="wp-block-syntaxhighlighter-code">/bin/spark-submit /Rsample/Stream-word-count.R localhost 9999</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:heading -->
<h2 id="quick-setup-using-python">Quick setup using Python</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Similar to R, you can do this with Python (or Scala) as well. So assuming that you already have Spark SQL engine installed and nc is up and running on localhost with port 9999.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Create a Python file (Stream-word-count.py) and copy the content:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">import sys

from pyspark.sql import SparkSession
from pyspark.sql.functions import explode
from pyspark.sql.functions import split

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: Stream-word-count.py &lt;hostname> &lt;port>", file=sys.stderr)
        sys.exit(-1)

    host = sys.argv[1]
    port = int(sys.argv[2])

    spark = SparkSession\
        .builder\
        .appName("StructuredStreamApp")\
        .getOrCreate()

    lines = spark\
        .readStream\
        .format('socket')\
        .option('host', host)\
        .option('port', port)\
        .load()

    # Split the lines into words
    words = lines.select(
        # explode turns each item in an array into a separate row
        explode(
            split(lines.value, ' ')
        ).alias('word')
    )

    wordCounts = words.groupBy('word').count()

    query = wordCounts\
        .writeStream\
        .outputMode('complete')\
        .format('console')\
        .start()

    query.awaitTermination()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And run the following file from CLI:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"bash"} -->
<pre class="wp-block-syntaxhighlighter-code">/bin/spark-submit /Pysample/Stream-word-count.py localhost 9999</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>In both cases, you should be getting the results back in dataset/dataframe that is ready to be analysed.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tomorrow we will make dataframe operations for Spark streaming.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->