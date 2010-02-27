<?PHP
header("Content-type: text/xml");

include ("../functions.php");

$connection = dbConnect();

$name=$_REQUEST['name'];
$lat=$_REQUEST['lat'];
$lng=$_REQUEST['lng'];
$desc=$_REQUEST['description'];
$category=$_REQUEST['category'];

$insert = "INSERT INTO marker(name,lat,lon,description,category) VALUES ('$name','$lat','$lng','$desc','$category');";
$resultID = mysql_query($insert, $linkID) or die("Data not found in 'marker' table.");


$query = "SELECT name FROM marker ORDER BY name DESC";
$resultID = mysql_query($query, $linkID) or die("Data not found in 'scores' table.");

$xml_output = "<?xml version=\"1.0\"?>\n";
$xml_output .= "<markerTable>\n";

while ($row = mysql_fetch_assoc($resultID)) {
    $xml_output .= "\t<marker>\n";
	$xml_output .= "\t\t<name>" . $row['name'] . "</name>\n";
	$xml_output .= "\t\t<lat>" . $row['lat'] . "</lat>\n";
	$xml_output .= "\t\t<lng>" . $row['lng'] . "</lng>\n";
	$xml_output .= "\t\t<description>" . $row['description'] . "</description>\n";
	$xml_output .= "\t\t<category>" . $row['category'] . "</category>\n";
    $xml_output .= "\t</marker>\n";
}

$xml_output .= "</markerTable>";


echo $xml_output;
?>

