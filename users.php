<?php
session_start();

// ✅ Iba admin má prístup
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true || $_SESSION['role'] !== 'admin') {
    die("❌ Prístup zamietnutý. <a href='login.php'>Prihlásiť sa</a>");
}

// 🔗 Pripojenie k databáze
$conn = new mysqli("localhost", "root", "", "3poschodie");
if ($conn->connect_error) die("Chyba DB: " . $conn->connect_error);

// 🗑️ Mazanie používateľa
if (isset($_GET['delete'])) {
    $id = (int)$_GET['delete'];
    $conn->query("DELETE FROM users WHERE id=$id");
    header("Location: users.php");
    exit;
}

// 📝 Zmena role
if (isset($_POST['change_role'])) {
    $id = (int)$_POST['user_id'];
    $role = $_POST['role'];
    $conn->query("UPDATE users SET role='$role' WHERE id=$id");
    header("Location: users.php");
    exit;
}

// ➕ Pridanie nového používateľa
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['add_user'])) {
    $username = $conn->real_escape_string($_POST['username']);
    $password = md5($_POST['password']);
    $role = $_POST['role'];

    $check = $conn->query("SELECT id FROM users WHERE username='$username'");
    if ($check->num_rows > 0) {
        $msg = "⚠️ Používateľ už existuje!";
    } else {
        $sql = "INSERT INTO users (username, password, role) VALUES ('$username', '$password', '$role')";
        $msg = $conn->query($sql) ? "✅ Používateľ úspešne pridaný!" : "❌ Chyba: " . $conn->error;
    }
}

// 📋 Zoznam používateľov
$result = $conn->query("SELECT * FROM users ORDER BY id ASC");
?>
<!DOCTYPE html>
<html lang="sk">
<head>
<meta charset="UTF-8">
<title>Správa používateľov</title>
<link rel="stylesheet" href="style.css">
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(to right, #eaf4ff, #f4f6f8);
    margin: 0;
    padding: 0;
    color: #333;
}

header {
    background-color: #0055a5;
    color: white;
    padding: 20px;
    text-align: center;
    position: relative;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}

header a {
    position: absolute;
    right: 20px;
    top: 20px;
    background: #0072ce;
    color: white;
    text-decoration: none;
    padding: 8px 15px;
    border-radius: 6px;
}
header a:hover {
    background: #004f91;
}

.container {
    max-width: 900px;
    margin: 40px auto;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    padding: 25px;
}

h2 {
    text-align: center;
    margin-bottom: 15px;
}

form.add-user {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 20px;
}

form.add-user input,
form.add-user select {
    padding: 8px 12px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
}

form.add-user button {
    background-color: #0072ce;
    color: white;
    border: none;
    border-radius: 6px;
    padding: 8px 14px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}
form.add-user button:hover {
    background-color: #0055a5;
}

.msg {
    text-align: center;
    margin-bottom: 15px;
    font-weight: bold;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}
th, td {
    border: 1px solid #ccc;
    padding: 8px;
    text-align: left;
}
th {
    background-color: #e0e0e0;
}
tr:nth-child(even) {
    background-color: #f5f5f5;
}

.delete-btn {
    color: white;
    background-color: #d9534f;
    padding: 5px 10px;
    border-radius: 6px;
    text-decoration: none;
}
.delete-btn:hover {
    background-color: #c9302c;
}

.change-role-btn {
    background-color: #0072ce;
    color: white;
    border: none;
    border-radius: 6px;
    padding: 5px 10px;
    cursor: pointer;
}
.change-role-btn:hover {
    background-color: #0055a5;
}

footer {
    text-align: center;
    font-size: 13px;
    color: #777;
    padding: 15px;
    margin-top: 30px;
    background-color: #f0f2f5;
    border-top: 1px solid #ddd;
}
</style>
</head>
<body>
<header>
    <h1>Správa používateľov</h1>
    <a href="index.php">← Späť na evidenciu</a>
</header>

<div class="container">
    <?php if (!empty($msg)) echo "<p class='msg'>$msg</p>"; ?>

    <h2>➕ Pridať nového používateľa</h2>
    <form method="post" class="add-user">
        <input type="text" name="username" placeholder="Používateľské meno" required>
        <input type="password" name="password" placeholder="Heslo" required>
        <select name="role">
            <option value="user">Používateľ</option>
            <option value="admin">Admin</option>
        </select>
        <button type="submit" name="add_user">Pridať</button>
    </form>

    <h2>📋 Existujúci používatelia</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Používateľ</th>
            <th>Rola</th>
            <th>Akcie</th>
        </tr>
        <?php while($row = $result->fetch_assoc()): ?>
        <tr>
            <td><?= $row['id'] ?></td>
            <td><?= htmlspecialchars($row['username']) ?></td>
            <td>
                <form method="post" style="display:flex; gap:5px; align-items:center;">
                    <input type="hidden" name="user_id" value="<?= $row['id'] ?>">
                    <select name="role">
                        <option value="user" <?= $row['role'] === 'user' ? 'selected' : '' ?>>Používateľ</option>
                        <option value="admin" <?= $row['role'] === 'admin' ? 'selected' : '' ?>>Admin</option>
                    </select>
                    <button type="submit" name="change_role" class="change-role-btn">Zmeniť</button>
                </form>
            </td>
            <td>
                <?php if ($row['username'] !== 'admin'): ?>
                    <a href="?delete=<?= $row['id'] ?>" class="delete-btn" onclick="return confirm('Naozaj odstrániť používateľa?');">🗑️ Zmazať</a>
                <?php else: ?>
                    <span style="color:gray;">—</span>
                <?php endif; ?>
            </td>
        </tr>
        <?php endwhile; ?>
    </table>
</div>

<footer>
    <p>© 2025 SOŠ Ostrovského Košice | Autor: Oliver Dlugoš</p>
</footer>
</body>
</html>
