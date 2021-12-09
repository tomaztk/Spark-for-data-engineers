install.packages("sparklyr")


library(sparklyr)
spark_install(version = "2.1.0")

devtools::install_github("rstudio/sparklyr")

library(sparklyr)
sc <- spark_connect(master = "local")


# Retrieve the Spark installation directory
spark_home <- spark_home_dir()

# Build paths and classes
spark_path <- file.path(spark_home, "bin", "spark-class")

# Start cluster manager master node
system2(spark_path, "org.apache.spark.deploy.master.Master", wait = FALSE)

# Start worker node, find master URL at http://localhost:8080/
system2(spark_path, c("org.apache.spark.deploy.worker.Worker", "spark://192.168.0.184:7077"), wait = FALSE)

# checking the processes
system("jps")


# connect the load
sc <- spark_connect(master = "spark://192.168.0.184:7077")
sc <- spark_connect(master ="spark://192.168.0.184:7077", spark_home = "/usr/local/spark-2.4.0-bin-hadoop2.7")
sc <- spark_connect(master ="spark://192.168.0.184:7077", spark_home = "/Users/tomazkastrun/spark/spark-2.4.8-bin-hadoop2.7")
sc <- spark_connect(master ="spark://192.168.0.184:7077", spark_home = "/usr/local/spark-2.4.8-bin-hadoop2.7")





cars <- copy_to(sc, mtcars)

# getting RDD created in Spark storage
cars

# opening web interface
spark_web(sc)


# Getting connection to SQL
library(DBI)
dbGetQuery(sc, "SELECT count(*) FROM mtcars")
