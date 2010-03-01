<?PHP
include("../functions.php");

$connection = dbConnect();

$result = mysql_query("SELECT id FROM route WHERE name='$name',description='$desc' AND category='$cat'");

echo "<?xml version=\"1.0\" ?><route>";

while($row = mysql_fetch_assoc($result))
{
	echo "<lastRoute><id>" . $row["id"] . "</id></lastRoute>";
	
}

echo "</route>";

?>