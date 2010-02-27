<?PHP

include("functions.php");

$connection = dbConnect();

$result = mysql_query("select * from marker");

echo "<?xml version=\"1.0\" ?><map>";

while($row = mysql_fetch_assoc($result))
{
	echo "<loc><id>" . $row["id"] . "</id>";
	echo "<name>". $row["name"]. "</name>";
	echo "<lon>" . $row["lon"] . "</lon>";
	echo "<lat>" . $row["lat"] . "</lat>";
	echo "<description>" . $row["description"] . "</description>";
	echo "<category>" . $row["category"] . "</category></loc>";
}

echo "</map>";

?>