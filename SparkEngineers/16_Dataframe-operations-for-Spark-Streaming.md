# Dataframe operations for Spark streaming

<!-- wp:paragraph -->
<p>When working with Spark Streaming from file based ingestion, user must predefine the schema. This will require not only better performance but consistent data ingest for streaming data. There is always possibility to set the <code>spark.sql.streaming.schemaInference</code> to true to enable Spark to infer schema on read or automatically.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="folder-structure">Folder structure</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Data partitioning is can be optimized for data discovery, especially when storing binary files are done in a key=value manner. This listing will recurse and will also help Spark to read the path of directories. These directories make the partitioning schema and must be static (or available) for the time of query execution</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Folder structure usually follow the index, that can also be optimized based on key=value pair. For example:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">/Sales/masterdata/customer/year=2021/month=12/Day=15</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>or any relevant schema structure that follows organization of data. In example, we have shown date partitioning, but it can also be e.g. geography:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">/Sales/masterdata/customer/region=Osrednja/ZIP=1000/municipality=Bežigrad</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And because the dataframes are not checked at compile time (but checked at runtime), we can improve the directory structure significantly. And normally, we would be aiming to convert the untyped (or semi-structured) streaming DataFrames to typed (structured) streaming Datasets using method to define DataFrame as static.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="working-with-dataframes">Working with Dataframes</h2>
<!-- /wp:heading -->

<!-- wp:heading {"level":3} -->
<h3 id="input-sources"><strong>Input Sources</strong></h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Dataframes for structural streaming can be created using <code>DataStreamReader</code> (with Scala, R, Python and Java).The method SparkSession.readstream() or read.stream() you can create a static Dataframe with additional details on the source. For the source, Spark Streaming can read files formats as TXT, CSV, JSON, ORC, Parquet. Also it can read data from Kafka and data from socket connections.<a href="https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html#input-sources"></a></p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3 id="basic-operations-in-r">Basic operations in R</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Let's set the connection and start working with streaming dataset:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">sparkR.session()
schemaFile &lt;- structType(structField("name", "string"),
                     structField("age", "integer"),
                     structField("device", "integer"),
                     structField("timestamp","Timestamp"))
csvDF &lt;- read.stream("csv", path = "/sample/customer/customer.csv", schema = schemaFile, sep = ";")</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>After loading, we can proceed with operations:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">#Selecting a subset
select(where(csvDF, "age > 10"), "device")

# Running count for each group in column device
count(groupBy(csvDF, "device"))</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>With Streaming data, what we normally want is to get a aggregated statistics over a period or window time. To do so in R, using both  <code>groupBy()</code> and <code>window()</code> function, to expresses aggregated windowed results:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code"># Group the data by window and word and compute the count of each group
windowedCounts &lt;- count(
                    groupBy(
                      csvDF,
                      window(csvDF$timestamp, "10 minutes", "5 minutes"),
                      csvDF$age))</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:heading {"level":3} -->
<h3 id="basic-operations-in-python">Basic operations in Python</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>And let's connect with Python to streaming dataset:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">spark = SparkSession()

# Read all the csv files written atomically in a directory
userSchema = StructType().add("name", "string").add("age", "integer").add("device","integer").add("Timestamp","Timestamp")
csvDF = spark \
    .readStream \
    .option("sep", ";") \
    .schema(userSchema) \
    .csv("/sample/customer/") </pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And repeat same simple functions with Python:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">#Selecting a subset
csvDF.select("device").where("age > 10")

# Running count of the number of updates for each device type
csvDF.groupBy("device").count()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And create analysis over aggregated window functions:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">windowedCounts = csvDF.groupBy(
    window(csvDF.timestamp, "10 minutes", "5 minutes"),
    csvDF.age
).count()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>In both languages - Python and R, datasets should be transformed into streamed structured dataset and then can be plugged to different aggregated and window functions.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into Watermarking and joins.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->
