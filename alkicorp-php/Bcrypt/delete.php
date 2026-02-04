<?php
session_start();
require "db.php";
if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit;
}

$id = (int) ($_GET["id"] ?? 0);
$stmt = $conn->prepare("DELETE FROM posts WHERE id=? AND version=?");
$stmt->bind_param("is", $id, $APP_VERSION);
$stmt->execute();

header("Location: index.php");
exit;
?>
