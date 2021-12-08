#Check for Java
system("java -version")
#Sys.setenv(JAVA_HOME = "/Library/Java/JavaVirtualMachines/jdk-17.0.1.jdk/home/")
getwd()

# install
#install.packages("sparklyr")

# Find all Java
# sudo find / -name java

library(sparklyr)
#devtools::install_github("rstudio/sparklyr")
#packageVersion("sparklyr")


# install local version
spark_available_versions()
#spark_install(version = "2.1")
#spark_install(version = "1.6")


#check installed version
spark_installed_versions()
#spark_uninstall(version = "2.1.0", hadoop = "2.7")


# Create a local Spark master 
library(sparklyr)

#get java
#sparklyr:::get_java()

sc <- spark_connect(master = "local", version = "1.6.3")
sc <- spark_connect(master = "local", version = "2.1.0")
sc <- spark_connect(master = "local", version = "2.2.0")
sc <- spark_connect(master = "local", version = "2.2.1")
sc <- spark_connect(master = "local", version = "2.4.8")



sc <- spark_connect(master = "local", spark_home = "/Users/tomazkastrun/spark/spark-1.6.3-bin-hadoop2.6")



iris_tbl <- copy_to(sc, iris)
iris_tbl <- iris

plot(iris_tbl$Petal.Length, iris_tbl$Petal.Width, pch=c(23,24,25), bg=c("red","green3","blue")[unclass(iris_tbl$Species)], main="Plotting Iris")

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

