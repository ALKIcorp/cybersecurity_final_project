<?php
session_start();
require "db.php";
if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit;
}

$id = (int) ($_GET["id"] ?? 0);
$stmt = $conn->prepare("SELECT * FROM posts WHERE id=? AND version=?");
$stmt->bind_param("is", $id, $APP_VERSION);
$stmt->execute();
$post = $stmt->get_result()->fetch_assoc();
if (!$post) {
    header("Location: index.php");
    exit;
}
$stmt = $conn->prepare("SELECT * FROM comments WHERE post_id=? AND version=? ORDER BY id DESC");
$stmt->bind_param("is", $id, $APP_VERSION);
$stmt->execute();
$comments = $stmt->get_result();
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>View Post - Alki Corp</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <div class="container">
      <div class="card">
        <h1><?php echo htmlspecialchars($post["title"], ENT_QUOTES, "UTF-8"); ?></h1>
        <p><?php echo htmlspecialchars($post["content"], ENT_QUOTES, "UTF-8"); ?></p>
        <p class="muted"><a href="index.php">Back to posts</a></p>
      </div>

      <div class="card">
        <h3>Comments</h3>
        <?php while ($row = $comments->fetch_assoc()) { ?>
          <div class="card"><?php echo htmlspecialchars($row["comment_content"], ENT_QUOTES, "UTF-8"); ?></div>
        <?php } ?>
      </div>

      <div class="card">
        <h3>Add Comment</h3>
        <form method="POST" action="add_comment.php">
          <input type="hidden" name="post_id" value="<?php echo htmlspecialchars((string)$id, ENT_QUOTES, "UTF-8"); ?>">
          <textarea name="comment" required></textarea>
          <button type="submit">Add Comment</button>
        </form>
      </div>
    </div>
  </body>
</html>
