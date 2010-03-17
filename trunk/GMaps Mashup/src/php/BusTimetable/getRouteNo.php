<?PHP

include("../functions.php");

$connection = dbConnect();

$markerID = $_POST['markerID'];

$result = mysql_query("select * from marker_timetables where markerID='$markerID'");

echo "<?xml version=\"1.0\" ?><routeNo>";

while($row = mysql_fetch_assoc($result))
{
	echo "<bus_routeNo><id>" . $row["id"] . "</id>";
	echo "<route>" . $row["bus_routeNo"] . "</route>";
	echo "<markerID>" . $row["markerID"] . "</markerID></bus_routeNo>";
}

echo "</routeNo>";

?>