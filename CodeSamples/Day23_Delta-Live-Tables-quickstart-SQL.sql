-- Databricks notebook source
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
