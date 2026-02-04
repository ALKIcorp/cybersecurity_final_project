<?php
session_start();
require "db.php";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $username = $_POST["username"] ?? "";
    $password_input = $_POST["password"] ?? "";

    // Get user from DB (with version filter)
    $stmt = $conn->prepare("SELECT * FROM users WHERE username=? AND version=?");
    $stmt->bind_param("ss", $username, $APP_VERSION);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result && $result->num_rows > 0) {
        $user = $result->fetch_assoc();
        // Verify password using password_verify (Bcrypt)
        if (verify_password($password_input, $user["password"])) {
            $_SESSION["user_id"] = $user["id"];
            $_SESSION["username"] = $user["username"];
            header("Location: index.php");
            exit;
        } else {
            $error = "Login failed.";
        }
    } else {
        $error = "Login failed.";
    }
}
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Login - Alki Corp</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <div class="container">
      <div class="card">
        <h2>Login</h2>
        <?php if (!empty($error)) { ?>
          <p class="muted"><?php echo htmlspecialchars($error, ENT_QUOTES, "UTF-8"); ?></p>
        <?php } ?>
        <form method="POST">
          <input name="username" placeholder="Username" required>
          <input name="password" placeholder="Password" required type="password">
          <button type="submit">Login</button>
        </form>
        <p class="muted">No account yet? <a href="register.php">Register</a></p>
      </div>
    </div>
  </body>
</html>
