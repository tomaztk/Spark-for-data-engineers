# Databricks notebook source
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
