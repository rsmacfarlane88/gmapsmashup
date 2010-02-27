<?PHP

include("../functions.php");

$connection = dbConnect();

$result = mysql_query("select * from markercategory");

echo "<?xml version=\"1.0\" ?><markerCategory>";

while($row = mysql_fetch_assoc($result))
{
	echo "<category><id>" . $row["id"] . "</id>";
	echo "<cat>" . $row["category"] . "</cat></category>";
}

echo "</markerCategory>";

?>