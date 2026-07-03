<?php
// room_detail.php - OPRAVENÁ VERZIA
session_start();

// 🔗 Pripojenie k databáze
$conn = new mysqli("localhost", "root", "", "3poschodie");
if ($conn->connect_error) {
    die("Chyba pripojenia: " . $conn->connect_error);
}

$room = $_GET["room"] ?? '';

if (!$room) {
    echo "<p>Neplatná učebňa.</p>";
    exit;
}

// 🛠️ OPRAVA: Použi správne názvy tabuliek a stĺpcov
$sql = "
    SELECT 
        d.device_type, 
        d.model, 
        d.cpu, 
        d.ram, 
        d.count 
    FROM devices_floor3 d
    JOIN rooms_floor3 r ON d.room_id = r.id
    WHERE r.room_number = ?
";

$stmt = $conn->prepare($sql);
if (!$stmt) {
    echo "<p>Chyba v dotaze: " . $conn->error . "</p>";
    exit;
}

$stmt->bind_param("s", $room);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    echo "<p><em>V učebni $room nie sú evidované žiadne zariadenia.</em></p>";
    exit;
}

echo "<table class='detail-table'>
<tr>
    <th>Typ</th>
    <th>Model</th>
    <th>CPU</th>
    <th>RAM</th>
    <th>Počet</th>
</tr>";

while ($row = $result->fetch_assoc()) {
    echo "<tr>
        <td>" . htmlspecialchars($row['device_type']) . "</td>
        <td>" . htmlspecialchars($row['model']) . "</td>
        <td>" . htmlspecialchars($row['cpu']) . "</td>
        <td>" . htmlspecialchars($row['ram']) . "</td>
        <td>" . htmlspecialchars($row['count']) . "</td>
    </tr>";
}

echo "</table>";

$stmt->close();
$conn->close();
?>