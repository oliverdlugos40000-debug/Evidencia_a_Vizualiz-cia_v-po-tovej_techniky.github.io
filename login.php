<?php
session_start();

$conn = new mysqli("localhost", "root", "", "3poschodie");
if ($conn->connect_error) {
    die("Chyba pripojenia: " . $conn->connect_error);
}

$error = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $username = $conn->real_escape_string($_POST['username']);
    $password = md5($_POST['password']);

    $sql = "SELECT * FROM users WHERE username='$username' AND password='$password'";
    $result = $conn->query($sql);

    if ($result && $result->num_rows === 1) {
        $user = $result->fetch_assoc();
        $_SESSION['logged_in'] = true;
        $_SESSION['username'] = $user['username'];
        $_SESSION['role'] = $user['role']; // 💡 toto je dôležité!

        // ✅ Presmeruj na hlavnú stránku s rámom a filtrami
        header("Location: index.php");
        exit;
    } else {
        $error = " Nesprávne meno alebo heslo.";
    }
}
?>

<!DOCTYPE html>
<html lang="sk">
<head>
<meta charset="UTF-8">
<title>Prihlásenie</title>
<link rel="stylesheet" href="style.css">
</head>
<body class="login-page">
<div class="login-box">
    <h2> Prihlásenie</h2>
    <?php if (!empty($error)) echo "<p class='error'>$error</p>"; ?>
    <form method="post">
        <input type="text" name="username" placeholder="Používateľské meno" required>
        <input type="password" name="password" placeholder="Heslo" required>
        <button type="submit">Prihlásiť sa</button>
    </form>
    <a href="index.php" style="display:block;margin-top:10px;">← Späť na hlavnú stránku</a>
</div>
</body>
</html>
