<?PHP
include("../functions.php");

$connection = dbConnect();

$name = $_POST['name'];
$description = $_POST['description'];
$category = $_POST['category'];

$result = mysql_query("SELECT id FROM route");

echo "<?xml version=\"1.0\" ?><route>";

while($row = mysql_fetch_assoc($result))
{
	echo "<lastRoute><id>" . $row["id"] . "</id></lastRoute>";
	
}

echo "</route>";

?>