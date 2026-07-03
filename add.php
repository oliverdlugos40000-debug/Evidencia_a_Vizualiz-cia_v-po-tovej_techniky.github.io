<?php
session_start();
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    die(" Neoprávnený prístup. <a href='login.php'>Prihlásiť sa</a>");
}

$conn = new mysqli("localhost", "root", "", "3poschodie");
if ($conn->connect_error) {
    die("Chyba pripojenia: " . $conn->connect_error);
}

// Načítanie zoznamu učební a učiteľov
$rooms_result = $conn->query("
    SELECT r.id AS room_id, r.room_number, t.full_name AS teacher_name
    FROM rooms_floor3 r
    JOIN teachers t ON r.teacher_id = t.id
    ORDER BY r.room_number ASC
");

// Ak bol formulár odoslaný
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $room_id = intval($_POST['room_id']);
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
    $user = $_SESSION['username']; // používateľ, ktorý je prihlásený

    $sql = "INSERT INTO devices_floor3 
            (room_id, device_type, model, cpu, ram, storage, gpu, os, count, status, note, updated_by)
            VALUES ($room_id, '$device_type', '$model', '$cpu', '$ram', '$storage', '$gpu', '$os', $count, '$status', '$note', '$user')";

    if ($conn->query($sql)) {
        header("Location: data.php");
        exit;
    } else {
        $errorMsg = " Chyba pri ukladaní: " . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html lang="sk">
<head>
<meta charset="UTF-8">
<title>Pridať zariadenie</title>
<link rel="stylesheet" href="style.css">
</head>
<body class="login-page">
<div class="login-box" style="width:460px; margin: 40px auto;">
    <h2>➕ Pridať nové zariadenie</h2>
    <a href="data.php" class="back-link">← Späť na prehľad</a>

    <?php if (!empty($errorMsg)) echo "<p style='color:red;'>$errorMsg</p>"; ?>

    <form method="post" class="add-form">
        <label for="room_id">Učebňa (učiteľ):</label>
        <select name="room_id" id="room_id" required>
            <option value="">-- Vyber učebňu --</option>
            <?php
            if ($rooms_result && $rooms_result->num_rows > 0) {
                while ($room = $rooms_result->fetch_assoc()) {
                    echo '<option value="' . intval($room['room_id']) . '">'
                         . htmlspecialchars($room['room_number'] . ' – ' . $room['teacher_name']) .
                         '</option>';
                }
            } else {
                echo '<option value="">Žiadne učebne v DB</option>';
            }
            ?>
        </select>

        <input type="text" name="device_type" placeholder="Typ zariadenia (napr. PC, projektor)" required>
        <input type="text" name="model" placeholder="Model">
        <input type="text" name="cpu" placeholder="CPU">
        <input type="text" name="ram" placeholder="RAM">
        <input type="text" name="storage" placeholder="Úložisko">
        <input type="text" name="gpu" placeholder="GPU">
        <input type="text" name="os" placeholder="Operačný systém">
        <input type="number" name="count" placeholder="Počet" value="1" min="1">
        <input type="text" name="status" placeholder="Stav" value="funkčné">
        <textarea name="note" placeholder="Poznámka"></textarea>

        <button type="submit">Uložiť zariadenie</button>
    </form>
</div>
</body>
</html>

<?php
if (isset($rooms_result) && $rooms_result instanceof mysqli_result) {
    $rooms_result->free();
}
$conn->close();
?>
