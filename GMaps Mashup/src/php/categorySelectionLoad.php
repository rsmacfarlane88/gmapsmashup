<?PHP

mysql_connect("localhost", "root","");
mysql_select_db("maps");

$result = mysql_query("select * from markercategory");

echo "<?xml version=\"1.0\" ?><markerCategory>";

while($row = mysql_fetch_assoc($result))
{
	echo "<category><id>" . $row["id"] . "</id>";
	echo "<cat>" . $row["category"] . "</cat></category>";
}

echo "</markerCategory>";

?>