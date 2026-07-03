<?php
session_start();
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    die("❌ Neoprávnený prístup. <a href='login.php'>Prihlásiť sa</a>");
}

$conn = new mysqli("localhost", "root", "", "3poschodie");
if ($conn->connect_error) {
    die("Chyba pripojenia: " . $conn->connect_error);
}

$id = isset($_GET['id']) ? intval($_GET['id']) : 0;

// Načítaj zariadenie
$result = $conn->query("SELECT * FROM devices_floor3 WHERE id = $id");
if (!$result || $result->num_rows === 0) {
    die("Zariadenie neexistuje.");
}
$data = $result->fetch_assoc();

// Uloženie úprav
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $device_type = $conn->real_escape_string($_POST['device_type']);
    $model = $conn->real_escape_string($_POST['model']);
    $cpu = $conn->real_escape_string($_POST['cpu']);
    $ram = $conn->real_escape_string($_POST['ram']);
    $storage = $conn->real_escape_string($_POST['storage']);
    $gpu = $conn->real_escape_string($_POST['gpu']);
    $os = $conn->real_escape_string($_POST['os']);
    $count = intval($_POST['count']);
    $status = $conn->real_escape_string($_POST['status']);
    $note = $conn->real_escape_string($_POST['note']);
    $user = $_SESSION['username']; // kto vykonal úpravu

    $sql = "UPDATE devices_floor3 SET
            device_type='$device_type',
            model='$model',
            cpu='$cpu',
            ram='$ram',
            storage='$storage',
            gpu='$gpu',
            os='$os',
            count=$count,
            status='$status',
            note='$note',
            updated_by='$user'
            WHERE id=$id";

    if ($conn->query($sql)) {
        header("Location: data.php");
        exit;
    } else {
        $errorMsg = "❌ Chyba pri úprave: " . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html lang="sk">
<head>
<meta charset="UTF-8">
<title>Upraviť zariadenie</title>
<link rel="stylesheet" href="style.css">
</head>
<body class="login-page">
<div class="login-box" style="width:460px; margin: 40px auto;">
    <h2>✏️ Upraviť zariadenie</h2>
    <a href="data.php" class="back-link">← Späť na prehľad</a>

    <?php if (!empty($errorMsg)) echo "<p style='color:red;'>$errorMsg</p>"; ?>

    <form method="post" class="add-form">
        <input type="text" name="device_type" value="<?= htmlspecialchars($data['device_type']) ?>" placeholder="Typ zariadenia" required>
        <input type="text" name="model" value="<?= htmlspecialchars($data['model']) ?>" placeholder="Model">
        <input type="text" name="cpu" value="<?= htmlspecialchars($data['cpu']) ?>" placeholder="CPU">
        <input type="text" name="ram" value="<?= htmlspecialchars($data['ram']) ?>" placeholder="RAM">
        <input type="text" name="storage" value="<?= htmlspecialchars($data['storage']) ?>" placeholder="Úložisko">
        <input type="text" name="gpu" value="<?= htmlspecialchars($data['gpu']) ?>" placeholder="GPU">
        <input type="text" name="os" value="<?= htmlspecialchars($data['os']) ?>" placeholder="Operačný systém">
        <input type="number" name="count" value="<?= htmlspecialchars($data['count']) ?>" placeholder="Počet" min="1">
        <input type="text" name="status" value="<?= htmlspecialchars($data['status']) ?>" placeholder="Stav">
        <textarea name="note" placeholder="Poznámka"><?= htmlspecialchars($data['note']) ?></textarea>
        <button type="submit">Uložiť zmeny</button>
    </form>
</div>
</body>
</html>

<?php
$conn->close();
?>
