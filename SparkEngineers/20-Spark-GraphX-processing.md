# Spark GraphX Processing

<!-- wp:paragraph -->
<p>GraphX is Spark's API component for graph and graph-parallel computations. GraphX uses Spark RDD and builds a graph abstraction on top of RDD. Graph abstraction is a directed multigraph with properties of edges and vertices.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"center","width":269,"height":202} -->
<div class="wp-block-image"><figure class="aligncenter is-resized"><img src="https://i.ytimg.com/vi/M-zqlhJdvXI/hqdefault.jpg" alt="Introduction to Apache Spark GraphX - YouTube" width="269" height="202"/></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>GraphX supports computations, and exposes set of fundamental operators (subgraph, joinVertices, aggregateMessages), as well it includes a growing collection of graph algorithms for simpler ETL and analytical tasks.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Spark GraphX enables following features:<br>- Flexibility: giving the same RDD data both graphs and collections, transform and join graphs with RDDs efficiently and write custom iterative graph algorithms using the Google's Pregel API,<br>- Computational speed: almost the  fastest specialised graph processing systems with not only retaining flexibility, but also fault-tolerance<br>- Graph algorithms: gives  popular algorithms to solve popular business cases. These algorithms are page rank, connected components, label propagation, SVD++, strongly connected components, and triangle count.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>To get started, use the following Scala commands:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">import org.apache.spark._
import org.apache.spark.graphx._
// To make some of the examples work we will also need RDD
import org.apache.spark.rdd.RDD
import org.apache.spark.util.IntParam 
import org.apache.spark.graphx.util.GraphGenerators </pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:heading -->
<h2 id="property-graph">Property graph</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Property graph is directed multigraph with defined objects attached to vertices and edges. A directed multigraph is a directed graph with multiple parallel edges sharing the same source and destination vertex.Supporting parallel edges simplifies modelling scenarios where there can be multiple relationships (e.g., co-worker and friend) between the same vertices. Each vertex is keyed by a <em>unique</em> 64-bit long identifier (<code>VertexId</code>). GraphX does not impose any ordering constraints on the vertex identifiers.</p>
<!-- /wp:paragraph -->

<!-- wp:image {"align":"left","width":978,"height":276} -->
<div class="wp-block-image"><figure class="alignleft is-resized"><img src="https://d1jnx9ba8s6j9r.cloudfront.net/blog/wp-content/uploads/2017/05/GraphX-Example-Spark-GraphX-Tutorial-Edureka.png" alt="GraphX Example - Spark GraphX Tutorial - Edureka" width="978" height="276"/></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>The property graph is parameterized over the vertex (<code>VD</code>) and edge (<code>ED</code>) types. Defining a property graph:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">class VertexProperty()
case class UserProperty(val name: String) extends VertexProperty
case class ProductProperty(val name: String, val price: Double) extends VertexProperty
// The graph might then have the type:
var graph: Graph[VertexProperty, String] = null</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Since graph is based on RDD, which are immutable and fault-tolerant, graph can behave the sam way as RDD. The example of property graph can be constructed as following:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">val userGraph: Graph[(String, String), String]</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Establishing the connection and Spark engine:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">// Assume the SparkContext has already been constructed
val sc: SparkContext
// Create an RDD for the vertices
val users: RDD[(VertexId, (String, String))] =
  sc.parallelize(Seq((3L, ("rxin", "student")), (7L, ("jgonzal", "postdoc")),
                       (5L, ("franklin", "prof")), (2L, ("istoica", "prof"))))
// Create an RDD for edges
val relationships: RDD[Edge[String]] =
  sc.parallelize(Seq(Edge(3L, 7L, "collab"),    Edge(5L, 3L, "advisor"),
                       Edge(2L, 5L, "colleague"), Edge(5L, 7L, "pi")))
// Define a default user in case there are relationship with missing user
val defaultUser = ("John Doe", "Missing")
// Build the initial Graph
val graph = Graph(users, relationships, defaultUser)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">val graph: Graph[(String, String), String] // Constructed from above
// Count all users which are postdocs
graph.vertices.filter { case (id, (name, pos)) => pos == "postdoc" }.count
// Count all the edges where src > dst
graph.edges.filter(e => e.srcId > e.dstId).count
//Case class constructor to count edges
graph.edges.filter { case Edge(src, dst, prop) => src > dst }.count</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>We can also use the SQL script to create a triplet view - join the vertex and edge property using <code>RDD[EdgeTriplet[VD,ED]]</code>. This join property can be expressed with SQL query:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"sql"} -->
<pre class="wp-block-syntaxhighlighter-code">SELECT src.id, dst.id, src.attr, e.attr, dst.attr
FROM edges AS e LEFT JOIN vertices AS src, vertices AS dst
ON e.srcId = src.Id AND e.dstId = dst.Id</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into couple of graphX operators.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->