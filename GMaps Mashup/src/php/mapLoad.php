<?PHP

mysql_connect("localhost", "root","");
mysql_select_db("maps");

$result = mysql_query("select * from marker");

echo "<?xml version=\"1.0\" ?><map>";

while($row = mysql_fetch_assoc($result))
{
	echo "<loc><name>" . $row["name"] . "</name>";
	echo "<lon>" . $row["lon"] . "</lon>";
	echo "<lat>" . $row["lat"] . "</lat>";
	echo "<description>" . $row["description"] . "</description>";
	echo "<category>" . $row["category"] . "</category></loc>";
}

echo "</map>";

?>