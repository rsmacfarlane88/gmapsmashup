<?PHP

include("../functions.php");

$connection = dbConnect();

$result = mysql_query("select * from flickr_photos");

echo "<?xml version=\"1.0\" ?><photos>";

while($row = mysql_fetch_assoc($result))
{
	echo "<photo><id>" . $row["id"] . "</id>";
	echo "<url>". $row["url"]. "</url>";
	echo "<markerID>" . $row["markerID"] . "</markerID></photo>";
}

echo "</photos>";

?>