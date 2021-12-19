# Time windows for Spark streaming


<!-- wp:paragraph -->
<p>Spark streaming support three types of time windows:<br>- tumbling windows (fixed time window)<br>- sliding windows<br>- session windows.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","width":773,"height":464} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://spark.apache.org/docs/latest/img/structured-streaming-time-window-types.jpg" alt="The types of time windows" width="773" height="464"/><figcaption>Source: <a href="https://spark.apache.org/docs/latest/img/structured-streaming-time-window-types.jpg" target="_blank" rel="noreferrer noopener">Spark streaming programming</a></figcaption></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Tumbling windows are fixed sized and static. They are non-overlapping and are contiguous intervals. Every ingested data can be (must be) bound to a singled window.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Sliding windows are also fixed sized and also static. Windows will overlap when the duration of the slide is smaller than the duration of the window. Ingested data can therefore be bound to two or more windows</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Session windows are dynamic in size of the window length. The size depends on the ingested data. A session starts with an input and expands if the following input expands if the next ingested record has fallen within the gap duration. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>For static window duration, a session window closes when there is no input received within gap duration. Both tumbling and sliding windows session uses <code>session_window</code> function.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Example of using dynamic session window with Python:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">from pyspark.sql import functions as F

events = DataFrame { timestamp: Timestamp, userId: String, Value: Integer }

session_window = session_window(events.timestamp, \
    F.when(events.userId == "user1", "5 seconds") \
    .when(events.userId == "user2", "20 seconds").otherwise("5 minutes"))

# Group the data by session window and userId, and compute the count of each group
sessionizedCounts = events \
    .withWatermark("timestamp", "10 minutes") \
    .groupBy(
        session_window,
        events.userId) \
    .count()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>In case of static window function, the session_window will not be defined. Example with Python:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">sessionizedCounts = events \
    .withWatermark("timestamp", "10 minutes") \
    .groupBy(
        session_window(events.timestamp, "5 minutes"),
        events.userId) \
    .count()</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Time windows functions are mandatory to be defined when there are ingest records with different durations or any kind of instability with ingest itself.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into data manipulation and data engineering for Spark Streaming.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->