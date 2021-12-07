#Check for Java
system("java -version")
Sys.setenv(JAVA_HOME = "/Library/Java/JavaVirtualMachines/jdk-17.0.1.jdk/home/")


# install
library(sparklyr)
devtools::install_github("rstudio/sparklyr")
#packageVersion("sparklyr")


# install local version
spark_available_versions()
spark_install(version = "2.2.0")

#check installed version
spark_installed_versions()
#spark_uninstall(version = "2.1.0", hadoop = "2.7")


# Create a local Spark master 
library(sparklyr)

sc <- spark_connect(master = "local", version = "2.2")



iris_tbl <- copy_to(sc, iris)
iris_tbl

spark_disconnect(sc)


