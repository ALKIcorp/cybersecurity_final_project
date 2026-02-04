<?php
session_start();
require "db.php";

$APP_VERSION = 'plain';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $username = $_POST["username"] ?? "";
    $password = $_POST["password"] ?? "";

    $sql = "INSERT INTO users (username, password, version) VALUES ('$username', '$password', '$APP_VERSION')";
    $conn->query($sql);

    echo "Registered. <a href='login.php'>Login</a>";
    exit;
}
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Register - Alki Corp</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <div class="container">
      <div class="card">
        <h2>Register</h2>
        <form method="POST">
          <input name="username" placeholder="Username" required>
          <input name="password" placeholder="Password" required type="password">
          <button type="submit">Register</button>
        </form>
        <p class="muted">Already have an account? <a href="login.php">Login</a></p>
      </div>
    </div>
  </body>
</html>
