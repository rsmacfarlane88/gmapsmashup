<?PHP

include("../functions.php");

$connection = dbConnect();

$result = mysql_query("select * from routecategory");

echo "<?xml version=\"1.0\" ?><routeCategory>";

while($row = mysql_fetch_assoc($result))
{
	echo "<category><id>" . $row["id"] . "</id>";
	echo "<cat>" . $row["category"] . "</cat></category>";
}

echo "</routeCategory>";

?>