<?php
session_start();
require "db.php";
$APP_VERSION = 'plain';
if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit;
}

$id = $_GET["id"] ?? 0;
$conn->query("DELETE FROM posts WHERE id=$id AND version='$APP_VERSION'");

header("Location: index.php");
exit;
?>
