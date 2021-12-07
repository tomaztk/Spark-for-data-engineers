#Check for Java
system("java -version")
#Sys.setenv(JAVA_HOME = "/Library/Java/JavaVirtualMachines/jdk-17.0.1.jdk/home/")


# install
#install.packages("sparklyr")

library(sparklyr)
devtools::install_github("rstudio/sparklyr")
#packageVersion("sparklyr")


# install local version
spark_available_versions()
spark_install(version = "2.1")

#check installed version
spark_installed_versions()
#spark_uninstall(version = "2.1.0", hadoop = "2.7")


# Create a local Spark master 
library(sparklyr)

#get java
sparklyr:::get_java()

sc <- spark_connect(master = "local", version = "2.2.0.")



iris_tbl <- copy_to(sc, iris)
iris_tbl

spark_disconnect(sc)


conf <- spark_config()

conf$spark.driver.cores <- 2
conf$spark.driver.memory <- "3G"
conf$spark.executor.cores <- 2
conf$spark.executor.memory <- "3G"
conf$spark.executor.instances <- 5
#conf$sparklyr.log.console <- TRUE
conf$sparklyr.verbose <- TRUE
sc <- spark_connect(
  master = "local",
  version = "2.2.0",
  config = conf,
  #spark_home = "/usr/lib/spark/"
  spark_home = "/Users/tomazkastrun/spark/spark-2.2.0-bin-hadoop2.7"
  
)

