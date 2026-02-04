<?php
// Force HTTPS redirect for Bcrypt version
if (empty($_SERVER['HTTPS']) || $_SERVER['HTTPS'] === 'off') {
    $https_url = 'https://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
    header("Location: $https_url", true, 301);
    exit;
}

// Now load config and DB
require_once __DIR__ . '/config.php';

$host = "localhost";
$user = "root";
$pass = "";
$db   = "alkicorp";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("DB connection failed: " . $conn->connect_error);
}
?>
