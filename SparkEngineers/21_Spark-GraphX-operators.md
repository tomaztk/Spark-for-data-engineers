# Spark GraphX operators

<!-- wp:paragraph -->
<p>Property graphs have collection of operators, that can take user-defined function and produce new graphs with transformed properties and structure. Core operators are defined in Graph and compositions of core operators are defined as GraphOps, and are automatically available as members of Graph. Each graph representation must provide implementations of the core operations and reuse many of the useful operations that are defined in GraphOps.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The list of all operators:</p>
<!-- /wp:paragraph -->
<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">/** Summary of the functionality in the property graph */
class Graph[VD, ED] {
  // Information about the Graph ===================================================================
  val numEdges: Long
  val numVertices: Long
  val inDegrees: VertexRDD[Int]
  val outDegrees: VertexRDD[Int]
  val degrees: VertexRDD[Int]
  // Views of the graph as collections =============================================================
  val vertices: VertexRDD[VD]
  val edges: EdgeRDD[ED]
  val triplets: RDD[EdgeTriplet[VD, ED]]
  // Functions for caching graphs ==================================================================
  def persist(newLevel: StorageLevel = StorageLevel.MEMORY_ONLY): Graph[VD, ED]
  def cache(): Graph[VD, ED]
  def unpersistVertices(blocking: Boolean = false): Graph[VD, ED]
  // Change the partitioning heuristic  ============================================================
  def partitionBy(partitionStrategy: PartitionStrategy): Graph[VD, ED]
  // Transform vertex and edge attributes ==========================================================
  def mapVertices[VD2](map: (VertexId, VD) => VD2): Graph[VD2, ED]
  def mapEdges[ED2](map: Edge[ED] => ED2): Graph[VD, ED2]
  def mapEdges[ED2](map: (PartitionID, Iterator[Edge[ED]]) => Iterator[ED2]): Graph[VD, ED2]
  def mapTriplets[ED2](map: EdgeTriplet[VD, ED] => ED2): Graph[VD, ED2]
  def mapTriplets[ED2](map: (PartitionID, Iterator[EdgeTriplet[VD, ED]]) => Iterator[ED2])
    : Graph[VD, ED2]
  // Modify the graph structure ====================================================================
  def reverse: Graph[VD, ED]
  def subgraph(
      epred: EdgeTriplet[VD,ED] => Boolean = (x => true),
      vpred: (VertexId, VD) => Boolean = ((v, d) => true))
    : Graph[VD, ED]
  def mask[VD2, ED2](other: Graph[VD2, ED2]): Graph[VD, ED]
  def groupEdges(merge: (ED, ED) => ED): Graph[VD, ED]
  // Join RDDs with the graph ======================================================================
  def joinVertices[U](table: RDD[(VertexId, U)])(mapFunc: (VertexId, VD, U) => VD): Graph[VD, ED]
  def outerJoinVertices[U, VD2](other: RDD[(VertexId, U)])
      (mapFunc: (VertexId, VD, Option[U]) => VD2)
    : Graph[VD2, ED]
  // Aggregate information about adjacent triplets =================================================
  def collectNeighborIds(edgeDirection: EdgeDirection): VertexRDD[Array[VertexId]]
  def collectNeighbors(edgeDirection: EdgeDirection): VertexRDD[Array[(VertexId, VD)]]
  def aggregateMessages[Msg: ClassTag](
      sendMsg: EdgeContext[VD, ED, Msg] => Unit,
      mergeMsg: (Msg, Msg) => Msg,
      tripletFields: TripletFields = TripletFields.All)
    : VertexRDD[A]
  // Iterative graph-parallel computation ==========================================================
  def pregel[A](initialMsg: A, maxIterations: Int, activeDirection: EdgeDirection)(
      vprog: (VertexId, VD, A) => VD,
      sendMsg: EdgeTriplet[VD, ED] => Iterator[(VertexId, A)],
      mergeMsg: (A, A) => A)
    : Graph[VD, ED]
  // Basic graph algorithms ========================================================================
  def pageRank(tol: Double, resetProb: Double = 0.15): Graph[Double, Double]
  def connectedComponents(): Graph[VertexId, ED]
  def triangleCount(): Graph[Int, ED]
  def stronglyConnectedComponents(numIter: Int): Graph[VertexId, ED]
}</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>There are (i) Property Operators, (ii), Structural Operators, (iii) Join Operators,  and (iv) Neighbourhood Operators.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The <strong>property operators</strong> yields a new graph with the vertex or edge properties modified by the user defined <code>ma</code>p function. These operators are:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">class Graph[VD, ED] {
  def mapVertices[VD2](map: (VertexId, VD) => VD2): Graph[VD2, ED]
  def mapEdges[ED2](map: Edge[ED] => ED2): Graph[VD, ED2]
  def mapTriplets[ED2](map: EdgeTriplet[VD, ED] => ED2): Graph[VD, ED2]
}</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p><strong>Structural operators</strong> are  <code>reverse</code>, <code>mask</code> and <code>subgraph operators</code>. Reverse operator returns a new graph with all the edge directions reversed. Subgraph operator takes vertex and edge predicates and returns the graph containing only the vertices that satisfy the vertex predicate. And mask operator constructs a subgraph by returning a graph that contains the vertices and edges that are also found in the input graph. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Example of mask operator:</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">// Run Connected Components
val ccGraph = graph.connectedComponents() // No longer contains missing field
// Remove missing vertices as well as the edges to connected to them
val validGraph = graph.subgraph(vpred = (id, attr) => attr._2 != "Missing")
// Restrict the answer to the valid subgraph
val validCCGraph = ccGraph.mask(validGraph)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p><strong>Join operators </strong>are <code>joinVertices</code> and <code>OuterJoinVertices</code> operators. Join Vertices operator joins the vertices with the input RDD and returns a new graph with the vertex properties obtained by applying the user defined <code>map</code> function to the result of the joined vertices. And <code>OuterJoinVertices</code> works similar to <code>joinVertices</code> except that the user defined <code>map</code> function is applied to all vertices and can change the vertex property type</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">class Graph[VD, ED] {
  def joinVertices[U](table: RDD[(VertexId, U)])(map: (VertexId, VD, U) => VD)
    : Graph[VD, ED]
  def outerJoinVertices[U, VD2](table: RDD[(VertexId, U)])(map: (VertexId, VD, Option[U]) => VD2)
    : Graph[VD2, ED]
}</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p>The <strong>Neighbourhood  operator</strong> are Aggregate Messages, Compute Degree OInformation,  andCollection neighbours.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Aggregate messages applies a user defined <code>sendMsg</code> function to each <em>edge triplet</em> in the graph and then uses the <code>mergeMsg</code> function to aggregate those messages at their destination vertex.</p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">class Graph[VD, ED] {
  def aggregateMessages[Msg: ClassTag](
      sendMsg: EdgeContext[VD, ED, Msg] => Unit,
      mergeMsg: (Msg, Msg) => Msg,
      tripletFields: TripletFields = TripletFields.All)
    : VertexRDD[Msg]
}</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p><code>Computing degree information</code> is a common aggregation task that computes the degree of each vertex: the number of edges adjacent to each vertex. In the context of directed graphs it is often necessary to know the in-degree, out-degree, and the total degree of each vertex. </p>
<!-- /wp:paragraph -->

<!-- wp:syntaxhighlighter/code {"language":"scala"} -->
<pre class="wp-block-syntaxhighlighter-code">// Define a reduce operation to compute the highest degree vertex
def max(a: (VertexId, Int), b: (VertexId, Int)): (VertexId, Int) = {
  if (a._2 > b._2) a else b
}
// Compute the max degrees
val maxInDegree: (VertexId, Int)  = graph.inDegrees.reduce(max)
val maxOutDegree: (VertexId, Int) = graph.outDegrees.reduce(max)
val maxDegrees: (VertexId, Int)   = graph.degrees.reduce(max)</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:paragraph -->
<p></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tomorrow we will look into Spark in Databricks.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Compete set of code, documents, notebooks, and all of the materials will be available at the Github repository:&nbsp;<a rel="noreferrer noopener" href="https://github.com/tomaztk/Spark-for-data-engineers" target="_blank">https://github.com/tomaztk/Spark-for-data-engineers</a></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy Spark Advent of 2021! 🙂</p>
<!-- /wp:paragraph -->