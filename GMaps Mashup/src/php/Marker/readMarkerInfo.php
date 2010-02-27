<?PHP

include("../functions.php");

$connection = dbConnect();

$result = mysql_query("select name,description from marker");

echo "<?xml version=\"1.0\" ?><markerInfo>";

while($row = mysql_fetch_assoc($result))
{
	echo "<marker><name>" . $row["name"] . "</name>";
	echo "<description>" . $row["description"] . "</description></marker>";
}

echo "</markerInfo>";

?>