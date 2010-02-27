<?php
$username = $_POST["username"];
$email = $_POST["email"];
$password = $_POST["password"];

$to      = $email;
$subject = 'HW University Campus Map';
$message = "Hi " . $username . ", \n\nThanks for signing up to this service. Please find below your unique password for logging in to our system: \n\nEmail:".$email."\n\nPassword: ".$password;
$headers = 'From: Campus Map Admin <admin@rsmacfarlane.com' . "\r\n" .
    'Reply-To: admin@rsmacfarlane.com' . "\r\n" .
    'X-Mailer: PHP/' . phpversion();

mail($to, $subject, $message, $headers);
?>
