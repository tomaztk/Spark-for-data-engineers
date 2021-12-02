
# Installing Apache Spark



<!-- wp:paragraph -->
<p>Today, we will look into installing Apache Spark. Spark is cross-platform software and therefore, we will look into installing it on both Windows  and MacOS.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="windows"><strong>Windows</strong></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Installing Apache Spark on Windows computer will require preinstalled Java JDK (Java Development Kit). Java 8 or later version, with current version 17. On <a rel="noreferrer noopener" href="https://www.oracle.com/java/technologies/downloads/" target="_blank">Oracle website,</a> download the Java and install it on your system. Easiest way is to download the x64 MSI Installer. Install the file and follow the instructions. Installer will create a folder like "C:\Program Files\Java\jdk-17.0.1".</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7534,"width":525,"height":310,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/screenshot-2021-12-02-at-19.45.16.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/screenshot-2021-12-02-at-19.45.16.png?w=693" alt="" class="wp-image-7534" width="525" height="310"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>After the installation is completed, proceed with installation of Apache Spark. Download Spark from the  <a rel="noreferrer noopener" href="https://spark.apache.org/downloads.html" target="_blank">Apache Spark website</a>. Select the Spark release 3.2.0 (Oct 13 2021) with package type: Pre-built for Apache Hadoop 3.3 and later.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7538,"width":625,"height":199,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/screenshot-2021-12-02-at-20.02.02.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/screenshot-2021-12-02-at-20.02.02.png?w=700" alt="" class="wp-image-7538" width="625" height="199"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Click on the file <em>"spark-3.2.0-bin-hadoop3.2.tgz"</em> and it will redirect you to download site.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p></p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7540,"width":530,"height":221,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/screenshot-2021-12-02-at-20.06.13.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/screenshot-2021-12-02-at-20.06.13.png?w=667" alt="" class="wp-image-7540" width="530" height="221"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Create a folder -  I am creating <em>C:\SparkApp</em> and unzipping all the content of the tgz file into this folder. The final structure of the folder should be: <em>C:\SparkApp\spark-3.2.0-bin-hadoop3.2</em>.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p></p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7542,"width":528,"height":347,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/2021-12-02-20_19_56-window.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/2021-12-02-20_19_56-window.png?w=685" alt="" class="wp-image-7542" width="528" height="347"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Furthermore, we need to set the environment variables. You will find them in Control Panel -&gt; System -&gt; About -&gt; Advanced System Settings and go to Advanced Tab and click Environment variables. Add three User variables: <code>SPARK_HOME</code>,&nbsp;<code>HADOOP_HOME</code>,&nbsp;<code>JAVA_HOME</code></p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7546,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large"><a href="https://tomaztsql.files.wordpress.com/2021/12/2021-12-02-20_36_11-window.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/2021-12-02-20_36_11-window.png?w=636" alt="" class="wp-image-7546"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>with following values:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><code>SPARK_HOME</code>  <em>C:\SparkApp\spark-3.2.0-bin-hadoop3.2</em>.\bin<br><code>HADOOP_HOME</code>&nbsp;<em>C:\SparkApp\spark-3.2.0-bin-hadoop3.2</em>.\bin<br><code>JAVA_HOME</code> <em>C:\Program Files\Java\jdk-17.0.1\bin</em></p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7547,"width":532,"height":504,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/2021-12-02-20_39_08-window-1.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/2021-12-02-20_39_08-window-1.png?w=621" alt="" class="wp-image-7547" width="532" height="504"/></a><figcaption>And repeat for all three variables.</figcaption></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>The last part is the download of the Winutil.exe file and paste it to the bin folder of your Spark binary; into: C:\SparkApp\spark-3.2.0-bin-hadoop3.2\bin.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Winutil can be found on <a rel="noreferrer noopener" href="https://github.com/steveloughran/winutils/blob/master/hadoop-3.0.0/bin/winutils.exe" target="_blank">Github</a> and I am downloading for Hadoop-3.0.0.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","id":7549,"width":410,"height":181,"sizeSlug":"large","linkDestination":"media"} -->
<div class="wp-block-image"><figure class="aligncenter size-large is-resized"><a href="https://tomaztsql.files.wordpress.com/2021/12/2021-12-02-21_35_07-window.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/2021-12-02-21_35_07-window.png?w=544" alt="" class="wp-image-7549" width="410" height="181"/></a></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>After copying the file, open Command line in your windows machinee. Navigate to C:\SparkApp\spark-3.2.0-bin-hadoop3.2\bin and run command <em>spark-shell</em>. This CLI utlity comes with this distribution of Apache spark. You are ready to start using Spark.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2 id="macos">MacOS</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>With installing Apache Spark on MacOS, most of the installation can be done using CLI.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Presumably, you already have installed BREW. You can always update the brew to latest version:</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>brew upgrade &amp;&amp; brew update </code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>After this is finished, run the java installation </p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">brew install java8
brew install java</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>Installing xcode is the next step:</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>xcode-select --install</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p> After this is finished, install scala:</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>brew install scala</code></pre>
<!-- /wp:code -->

<!-- wp:image {"id":7555,"sizeSlug":"large","linkDestination":"media"} -->
<figure class="wp-block-image size-large"><a href="https://tomaztsql.files.wordpress.com/2021/12/screenshot-2021-12-02-at-22.04.28.png"><img src="https://tomaztsql.files.wordpress.com/2021/12/screenshot-2021-12-02-at-22.04.28.png?w=1024" alt="" class="wp-image-7555"/></a></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p> And the final step is to install Spark by typing the following command in CLI:</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>brew install apache-spark</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>And run:</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>brew link apache-spark</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>Finally, to execute the Spark shell, command is the same in Windows as it is in MacOS. Run the following command to start spark shell:</p>
<!-- /wp:paragraph -->

<!-- wp:code -->
<pre class="wp-block-code"><code>Spark-shell</code></pre>
<!-- /wp:code -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into the Spark CLI and WEB UI and get to know the environment.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->