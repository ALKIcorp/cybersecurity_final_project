<?php
session_start();
require "db.php";
if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit;
}
$stmt = $conn->prepare("SELECT * FROM posts WHERE version=? ORDER BY id DESC");
$stmt->bind_param("s", $APP_VERSION);
$stmt->execute();
$result = $stmt->get_result();
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Alki Corp Blog</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <div class="container">
      <h1>Alki Corp Blog</h1>
      <p class="muted">
        Welcome, <?php echo htmlspecialchars($_SESSION["username"], ENT_QUOTES, "UTF-8"); ?> |
        <a href="logout.php">Logout</a>
      </p>
      <p><a href="new_post.php">Create Post</a></p>
      <?php while ($row = $result->fetch_assoc()) { ?>
        <div class="card">
          <h2><?php echo htmlspecialchars($row["title"], ENT_QUOTES, "UTF-8"); ?></h2>
          <p><?php echo htmlspecialchars($row["content"], ENT_QUOTES, "UTF-8"); ?></p>
          <p>
            <a href="view.php?id=<?php echo htmlspecialchars((string)$row["id"], ENT_QUOTES, "UTF-8"); ?>">View</a>
            |
            <a href="delete.php?id=<?php echo htmlspecialchars((string)$row["id"], ENT_QUOTES, "UTF-8"); ?>">Delete</a>
          </p>
        </div>
      <?php } ?>
    </div>
  </body>
</html>
