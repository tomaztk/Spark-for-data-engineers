# Watermarking and joins for Spark streaming


<!-- wp:paragraph -->
<p>Streaming data is considered as continuously ingested data with particular frequency and latency. It is considered "big data" and data that has no discrete beginning nor end. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The primary goal of any real-time stream processing system is to process the streaming data within a window frame (or considered this as frequency).  Usually this frequency is "as soon as it arrives". On the other hand, latency in streaming processing model  is considered to have the means to work or deal with all the possible latencies (one second or one minute) and provides an end-to-end low latency system. If frequency of data analysing is on user's side (destination), latency is considered on the device's side (source).</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Aggregation over time-sliding window is simple and straightforward with Spark Streaming. It is based on windows-based aggregations, aggregate values are maintained for each window the time-sliding events fall into.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Aggregations over a sliding event-time window are straightforward with Structured Streaming and are very similar to grouped aggregations. In a grouped aggregation, aggregate values (e.g. counts) are maintained for each unique value in the user-specified grouping column. In case of window-based aggregations, aggregate values are maintained for each window the event-time of a row falls into. Let’s understand this with an illustration.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","width":729,"height":374} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://spark.apache.org/docs/latest/img/structured-streaming-window.png" alt="Window Operations" width="729" height="374"/><figcaption>Source: <a href="https://spark.apache.org/docs/latest/img/structured-streaming-window.png">Spark streaming programming</a>.</figcaption></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>The example above gives you a sense of how window grouped aggregation are created. So we are running these counts() within 10 minute windows and updating the results every 5 minutes. Counts on  received records between 10 minute windows 12:00 - 12:10, 12:05 - 12:15, 12:10 - 12:20, etc. Note that 12:00 - 12:10 means data that arrived after 12:00 but before 12:10 will be aggregated in this batch. If a record  receives at 12:07, this record should increment the counts corresponding to two windows 12:00 - 12:10 and 12:05 - 12:15. Counts will be indexed by the grouping key and the window.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>For R:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">Devices # is a stream dataframe
windowedCounts &lt;- count(
                    groupBy(
                      device,
                      window(Devices$timestamp, "10 minutes", "5 minutes"),
                      Devices$device))</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And for Python:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">Devices # is a stream dataframe
windowedCounts = Devices.groupBy(
    window(devices.timestamp, "10 minutes", "5 minutes"),
    devices.word
).count()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>When running ingest for a longer period of time, you will need to define the boundaries for the system. For how long do you want your ingested streamed data to stay static in memory. In other words, the system needs to know when an old aggregate can be purged from the in-memory state, because the application is not going to receive late data for that aggregate any longer.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>With Spark Streaming 2.1 (or above), you have available watermarking. Watermarking lets the Spark enginge automatically track the current data ingested time and clean up old state of aggregation. Specifying watermark of a query is done by specifying the event time column and the threshold on how late the data is expected to the in the time-span. Late data within the treshold will be aggregated, but data later than the threshold will start with process of deletion. Watermarking is defined using function <code>withWatermark()</code>.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>For R:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"r"} -->
<pre class="wp-block-syntaxhighlighter-code">Devices &lt;- withWatermark(Devices, "timestamp", "10 minutes")
windowedCounts &lt;- count(
                    groupBy(
                      device,
                      window(Devices$timestamp, "10 minutes", "5 minutes"),
                      Devices$device))</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And for Python:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">Devices # is a stream dataframe
windowedCounts = Devices \
    .withWatermark("timestamp", "10 minutes") \
    .groupBy(
      window(devices.timestamp, "10 minutes", "5 minutes"),
      devices.word
).count()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p> And if query is running  in Update output mode, the engine will keep updating counts of a window in the Result Table until the window is older than the watermark, which lags behind the current event time in column “timestamp” by 10 minutes. </p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","width":774,"height":535} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://spark.apache.org/docs/latest/img/structured-streaming-watermark-update-mode.png" alt="Watermarking in Update Mode" width="774" height="535"/><figcaption>Source: <a href="https://spark.apache.org/docs/latest/img/structured-streaming-watermark-update-mode.png">Spark Streaming programming</a></figcaption></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>The blue dashed line presents maximum event time tracked and the read line is the beginning of every triggered watermark. If the engine gets the data at 12:14, it triggers the watermark for the next 12:04. This watermark allows the additional 10 minutes of time for data to be late and yet still added to same aggregation.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p> If the data at 12:09 is out of order and late it falls in two windows 12:00-12:10 and 12:05-12:15. because the watermark at 12:04 is triggered, the engine still maintains the aggregations and correctly updates the results for the related window, otherwise if it would be late and considered for the subsequent data. After every trigger the updated counts are written to the outputted results.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into types of windows time for understanding watermarking and sharding.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->