<?php
session_start();
require "db.php";
if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit;
}

$post_id = (int) ($_POST["post_id"] ?? 0);
$comment = $_POST["comment"] ?? "";

$stmt = $conn->prepare("INSERT INTO comments (post_id, comment_content, version) VALUES (?, ?, ?)");
$stmt->bind_param("iss", $post_id, $comment, $APP_VERSION);
$stmt->execute();

header("Location: view.php?id=" . $post_id);
exit;
?>
