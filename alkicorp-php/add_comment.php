<?php
session_start();
require "db.php";
$APP_VERSION = 'plain';
if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit;
}

$post_id = $_POST["post_id"] ?? 0;
$comment = $_POST["comment"] ?? "";

$sql = "INSERT INTO comments (post_id, comment_content, version) VALUES ('$post_id', '$comment', '$APP_VERSION')";
$conn->query($sql);

header("Location: view.php?id=$post_id");
exit;
?>
