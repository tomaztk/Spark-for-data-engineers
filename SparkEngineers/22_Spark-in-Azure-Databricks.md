# Spark in Azure Databricks

<!-- wp:paragraph -->
<p>Azure Databricks is a platform build on top of  Spark based analytical  engine, that unifies data, data manipulation, analytics and machine learning.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Databricks uses notebooks to tackle all the tasks and is therefore made easy to collaborate. Let's dig in and start using a Python API on top of Spark API.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Sign into Azure Databricks, create new notebook and attach notebook to a cluster. How to do this, check and follow my <a href="https://github.com/tomaztk/Azure-Databricks" target="_blank" rel="noreferrer noopener">Github repository on Advent of Databricks 2020</a>.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Using the new notebook, we will create a dataset and start working with dataset, using all the operations relevant for data engineering.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>A complete sample wrapped in Databricks notebook file. Complete file is also available as IPython notebook and is available <a href="https://github.com/tomaztk/Azure-Databricks" target="_blank" rel="noreferrer noopener">here</a>. </p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code"># Databricks notebook source
# MAGIC %md
# MAGIC # Using Python Dataframes on Spark API for Data engineering tasks

# COMMAND ----------

# MAGIC %md
# MAGIC This notebook will explore basic and intermediate tasks and operators, that engineer should be comfortable to use. This tasks can be written similar in Scala (Spark).

# COMMAND ----------

# MAGIC %md
# MAGIC ## Create Dataframe

# COMMAND ----------

# import pyspark class Row from module sql
from pyspark.sql import *

# Create Example Data - Departments and Employees

# Create the Departments
department1 = Row(id='123456', name='Computer Science')
department2 = Row(id='789012', name='Mechanical Engineering')
department3 = Row(id='345678', name='Theater and Drama')
department4 = Row(id='901234', name='Indoor Recreation')

# Create the Employees
Employee = Row("firstName", "lastName", "email", "salary")
employee1 = Employee('michael', 'armbrust', 'no-reply@berkeley.edu', 100000)
employee2 = Employee('xiangrui', 'meng', 'no-reply@stanford.edu', 120000)
employee3 = Employee('matei', None, 'no-reply@waterloo.edu', 140000)
employee4 = Employee(None, 'wendell', 'no-reply@berkeley.edu', 160000)
employee5 = Employee('michael', 'jackson', 'no-reply@neverla.nd', 80000)

# Create the DepartmentWithEmployees instances from Departments and Employees
departmentWithEmployees1 = Row(department=department1, employees=[employee1, employee2])
departmentWithEmployees2 = Row(department=department2, employees=[employee3, employee4])
departmentWithEmployees3 = Row(department=department3, employees=[employee5, employee4])
departmentWithEmployees4 = Row(department=department4, employees=[employee2, employee3])

print(department1)
print(employee2)
print(departmentWithEmployees1.employees[0].email)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Create dataframes from list of rows

# COMMAND ----------

departmentsWithEmployeesSeq1 = [departmentWithEmployees1, departmentWithEmployees2]
df1 = spark.createDataFrame(departmentsWithEmployeesSeq1)

display(df1)

departmentsWithEmployeesSeq2 = [departmentWithEmployees3, departmentWithEmployees4]
df2 = spark.createDataFrame(departmentsWithEmployeesSeq2)

display(df2)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Union of two dataframes

# COMMAND ----------

unionDF = df1.union(df2)
display(unionDF)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Write the unioned DataFrame to a Parquet file

# COMMAND ----------

# Remove the file if it exists
dbutils.fs.rm("/tmp/databricks-df-example.parquet", True)
unionDF.write.parquet("/tmp/databricks-df-example.parquet")

# COMMAND ----------

# MAGIC %md
# MAGIC ## Read from  a Parquet file

# COMMAND ----------

parquetDF = spark.read.parquet("/tmp/databricks-df-example.parquet")
display(parquetDF)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Explode the employee columns

# COMMAND ----------

from pyspark.sql.functions import explode

explodeDF = unionDF.select(explode("employees").alias("e"))
flattenDF = explodeDF.selectExpr("e.firstName", "e.lastName", "e.email", "e.salary")

flattenDF.show()

# COMMAND ----------

# MAGIC %md
# MAGIC ## Filtering data (rows) to match the predicate

# COMMAND ----------

filterDF = flattenDF.filter(flattenDF.firstName == "xiangrui").sort(flattenDF.lastName)
display(filterDF)
## or

# COMMAND ----------

from pyspark.sql.functions import col, asc

# Use `|` instead of `or`
filterDF = flattenDF.filter((col("firstName") == "xiangrui") | (col("firstName") == "michael")).sort(asc("lastName"))
display(filterDF)
## or

# COMMAND ----------

whereDF = flattenDF.where((col("firstName") == "xiangrui") | (col("firstName") == "michael")).sort(asc("lastName"))
display(whereDF)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Replacing values

# COMMAND ----------

nonNullDF = flattenDF.fillna("--")
display(nonNullDF)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Aggregating data (sum, count, groupby, summary, min, max, ...)

# COMMAND ----------

from pyspark.sql.functions import countDistinct

countDistinctDF = nonNullDF.select("firstName", "lastName")\
  .groupBy("firstName")\
  .agg(countDistinct("lastName").alias("distinct_last_names"))

display(countDistinctDF)

# COMMAND ----------

salarySumDF = nonNullDF.agg({"salary" : "sum"})
display(salarySumDF)

# COMMAND ----------

nonNullDF.describe("salary").show()

# COMMAND ----------

# MAGIC %md
# MAGIC ## Clean up Parquet file

# COMMAND ----------

dbutils.fs.rm("/tmp/databricks-df-example.parquet", True)

# COMMAND ----------

# MAGIC %md
# MAGIC ## Working with functions

# COMMAND ----------

# MAGIC %md
# MAGIC ### Create sample dataset

# COMMAND ----------

from pyspark.sql import functions as F
from pyspark.sql.types import *

# Build an example DataFrame dataset to work with.
dbutils.fs.rm("/tmp/dataframe_sample.csv", True)
dbutils.fs.put("/tmp/dataframe_sample.csv", """id|end_date|start_date|location
1|2015-10-14 00:00:00|2015-09-14 00:00:00|CA-SF
2|2015-10-15 01:00:20|2015-08-14 00:00:00|CA-SD
3|2015-10-16 02:30:00|2015-01-14 00:00:00|NY-NY
4|2015-10-17 03:00:20|2015-02-14 00:00:00|NY-NY
5|2015-10-18 04:30:00|2014-04-14 00:00:00|CA-SD
""", True)

df = spark.read.format("csv").options(header='true', delimiter = '|').load("/tmp/dataframe_sample.csv")
df.printSchema()

# COMMAND ----------

# MAGIC %md
# MAGIC ### Using built-in functions

# COMMAND ----------

# Instead of registering a UDF, call the builtin functions to perform operations on the columns.
# This will provide a performance improvement as the builtins compile and run in the platform's JVM.

# Convert to a Date type
df = df.withColumn('date', F.to_date(df.end_date))

# Parse out the date only
df = df.withColumn('date_only', F.regexp_replace(df.end_date,' (\d+)[:](\d+)[:](\d+).*$', ''))

# Split a string and index a field
df = df.withColumn('city', F.split(df.location, '-')[1])

# Perform a date diff function
df = df.withColumn('date_diff', F.datediff(F.to_date(df.end_date), F.to_date(df.start_date)))

# COMMAND ----------

df.createOrReplaceTempView("sample_df")
display(sql("select * from sample_df"))

# COMMAND ----------

# MAGIC %md
# MAGIC ### Convert to JSON format

# COMMAND ----------

rdd_json = df.toJSON()
rdd_json.take(2)

# COMMAND ----------

# MAGIC %md
# MAGIC ### Create user-defined function (UDF)

# COMMAND ----------

from pyspark.sql import functions as F

add_n = udf(lambda x, y: x + y, IntegerType())

# We register a UDF that adds a column to the DataFrame, and we cast the id column to an Integer type.
df = df.withColumn('id_offset', add_n(F.lit(1000), df.id.cast(IntegerType())))

# COMMAND ----------

# MAGIC %md
# MAGIC ### ... and pass the parameter to UDF

# COMMAND ----------

# any constants used by UDF will automatically pass through to workers
N = 90
last_n_days = udf(lambda x: x &lt; N, BooleanType())

df_filtered = df.filter(last_n_days(df.date_diff))
display(df_filtered)

# COMMAND ----------

#md
### Aggregate over multiple columns

# COMMAND ----------

agg_df = df.groupBy("location").agg(F.min("id"), F.count("id"), F.avg("date_diff"))
display(agg_df)

# COMMAND ----------

# MAGIC %md
# MAGIC ### And store data to Parquet file on file partitiion by time (time - end)

# COMMAND ----------

df = df.withColumn('end_month', F.month('end_date'))
df = df.withColumn('end_year', F.year('end_date'))
df.write.partitionBy("end_year", "end_month").parquet("/tmp/sample_table")
display(dbutils.fs.ls("/tmp/sample_table"))
</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:syntaxhighlighter/code -->
<pre class="wp-block-syntaxhighlighter-code">Using Databricks for data manipulation is easy, fast and efficient. But not only from installation point of view, but also the fact that Databricks unifies all the tasks together in a single notebook, bringing also different departments closer to collaborate.</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into Delta live tables with Azure Databricks.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->