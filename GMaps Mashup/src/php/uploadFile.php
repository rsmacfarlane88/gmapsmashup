<?php
$myVar = $_GET['myVar'];
$tempFile = $_FILES['Filedata']['tmp_name'];
$fileName = $_FILES['Filedata']['name'];
$fileSize = $_FILES['Filedata']['size'];

move_uploaded_file($tempFile, "./" .$myVar.$fileName);

?>