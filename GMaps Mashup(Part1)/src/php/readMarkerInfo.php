<?PHP

mysql_connect("localhost", "root","");
mysql_select_db("maps");

$result = mysql_query("select name,description from marker");

echo "<?xml version=\"1.0\" ?><markerInfo>";

while($row = mysql_fetch_assoc($result))
{
	echo "<marker><name>" . $row["name"] . "</name>";
	echo "<description>" . $row["description"] . "</description></marker>";
}

echo "</markerInfo>";

?>