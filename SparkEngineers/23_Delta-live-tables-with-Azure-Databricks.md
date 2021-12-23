# Delta live tables with Azure Databricks

<!-- wp:paragraph -->
<p>Delta Live Tables is a framework for building reliable, maintainable, and testable data processing pipelines. User defines the transformations to be performed on the datasources and data, and the framework manages all the data engineering tasks: task orchestrations, cluster management, monitoring, data quality, and event error handling.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Delta Live Tables framework helps and manages how data is being transformed with help of target schema and can is a slight different experience with Databricks Tasks (with Apache Spark tasks in the background).</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>As of writting this blogpost, the Delta Live Tables are still in private preview and must be granted access by accessing the <a rel="noreferrer noopener" href="https://databricks.com/p/product-delta-live-tables" target="_blank">link</a>. Once this is approved, you can simply log into Azure Databricks and create a new notebook (with Python or SQL).</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>With Python, you can create a simple notebook and start consuming Delta Live tables (DLT):</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code"># Databricks notebook source
# MAGIC %md # Delta Live Tables quickstart (Python)
# MAGIC 
# MAGIC A notebook that provides an example Delta Live Tables pipeline to:
# MAGIC 
# MAGIC - Read raw JSON clickstream data into a table.
# MAGIC - Read records from the raw data table and use a Delta Live Tables query and expectations to create a new table with cleaned and prepared data.
# MAGIC - Perform an analysis on the prepared data with a Delta Live Tables query.

# COMMAND ----------

# DBTITLE 1,Imports
import dlt
from pyspark.sql.functions import *
from pyspark.sql.types import *

# COMMAND ----------

# DBTITLE 1,Ingest raw clickstream data
json_path = "/databricks-datasets/wikipedia-datasets/data-001/clickstream/raw-uncompressed-json/2015_2_clickstream.json"
@dlt.create_table(
  comment="The raw wikipedia clickstream dataset, ingested from /databricks-datasets."
)
def clickstream_raw():          
  return (
    spark.read.json(json_path)
  )

# COMMAND ----------

# DBTITLE 1,Clean and prepare data
@dlt.table(
  comment="Wikipedia clickstream data cleaned and prepared for analysis."
)
@dlt.expect("valid_current_page_title", "current_page_title IS NOT NULL")
@dlt.expect_or_fail("valid_count", "click_count > 0")
def clickstream_prepared():
  return (
    dlt.read("clickstream_raw")
      .withColumn("click_count", expr("CAST(n AS INT)"))
      .withColumnRenamed("curr_title", "current_page_title")
      .withColumnRenamed("prev_title", "previous_page_title")
      .select("current_page_title", "click_count", "previous_page_title")
  )

# COMMAND ----------

# DBTITLE 1,Top referring pages
@dlt.table(
  comment="A table containing the top pages linking to the Apache Spark page."
)
def top_spark_referrers():
  return (
    dlt.read("clickstream_prepared")
      .filter(expr("current_page_title == 'Apache_Spark'"))
      .withColumnRenamed("previous_page_title", "referrer")
      .sort(desc("click_count"))
      .select("referrer", "click_count")
      .limit(10)
  )
</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And Same can be done with SQL:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"sql"} -->
<pre class="wp-block-syntaxhighlighter-code">-- Databricks notebook source
-- MAGIC %md # Delta Live Tables quickstart (SQL)
-- MAGIC 
-- MAGIC A notebook that provides an example Delta Live Tables pipeline to:
-- MAGIC 
-- MAGIC - Read raw JSON clickstream data into a table.
-- MAGIC - Read records from the raw data table and use a Delta Live Tables query and expectations to create a new table with cleaned and prepared data.
-- MAGIC - Perform an analysis on the prepared data with a Delta Live Tables query.

-- COMMAND ----------

-- DBTITLE 1,Ingest raw clickstream data
CREATE LIVE TABLE clickstream_raw
COMMENT "The raw wikipedia click stream dataset, ingested from /databricks-datasets."
AS SELECT * FROM json.`/databricks-datasets/wikipedia-datasets/data-001/clickstream/raw-uncompressed-json/2015_2_clickstream.json`

-- COMMAND ----------

-- DBTITLE 1,Clean and prepare data
CREATE LIVE TABLE clickstream_clean(
  CONSTRAINT valid_current_page EXPECT (current_page_title IS NOT NULL),
  CONSTRAINT valid_count EXPECT (click_count > 0) ON VIOLATION FAIL UPDATE
)
COMMENT "Wikipedia clickstream data cleaned and prepared for analysis."
AS SELECT
  curr_title AS current_page_title,
  CAST(n AS INT) AS click_count,
  prev_title AS previous_page_title
FROM live.clickstream_raw

-- COMMAND ----------

-- DBTITLE 1,Top referring pages
CREATE LIVE TABLE top_spark_referers
COMMENT "A table containing the top pages linking to the Apache Spark page."
AS SELECT
  previous_page_title as referrer,
  click_count
FROM live.clickstream_clean
WHERE current_page_title = 'Apache_Spark'
ORDER BY click_count DESC
LIMIT 10
</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>With either code will create the pipelines (as visualised below) and the management, orchestration and monitor will be provided with the framework. </p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7988,"width":647,"height":416,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/image-23.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/image-23.png?w=1024" alt="" class="wp-image-7988" width="647" height="416"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Spark API offers also all the data manipulations to work with Python and SQL to create functions, tables, views,...</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>With Python, you can apply the  <code>@view</code> or <code>@table</code> decorator to a function to define a view or table. You can use the function name or the <code>name</code> parameter to assign the table or view name. Pseudo data with Python:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"python"} -->
<pre class="wp-block-syntaxhighlighter-code">@dlt.view
def taxi_raw():
  return spark.read.json("/databricks-datasets/wikipedia-datasets/data-001/clickstream/raw-uncompressed-json/")

# Use the function name as the table name
@dlt.table
def filtered_data():
  return dlt.read("clickstream_raw").where(...)

# Use the name parameter as the table name
@dlt.table(
  name="filtered_data")
def create_filtered_data():
  return dlt.read("clickstream_raw").where(...)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>And same can be accomplished by using SQL:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"sql"} -->
<pre class="wp-block-syntaxhighlighter-code">CREATE LIVE TABLE clickstream_raw
AS SELECT * FROM json.`/databricks-datasets/wikipedia-datasets/data-001/clickstream/raw-uncompressed-json/`

CREATE LIVE TABLE filtered_data
AS SELECT
  ...
FROM LIVE.clickstream_raw</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into Data visualisation with Spark.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->