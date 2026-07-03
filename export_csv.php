<?php
session_start();

$servername = "localhost";
$username = "root"; 
$password = "";
$dbname = "3poschodie";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Chyba pripojenia: " . $conn->connect_error);
}

// 🔍 Filtrovanie podľa parametrov
$floor = isset($_GET['floor']) ? $_GET['floor'] : '';
$room = isset($_GET['room']) ? $_GET['room'] : '';
$teacher = isset($_GET['teacher']) ? $_GET['teacher'] : '';
$device_type = isset($_GET['device_type']) ? $_GET['device_type'] : '';

// 🧩 SQL dotaz
$sql = "
    SELECT 
        d.id,
        r.room_number,
        t.full_name AS teacher_name,
        d.device_type,
        d.model,
        d.cpu,
        d.ram,
        d.storage,
        d.gpu,
        d.os,
        d.count,
        d.status,
        d.note,
        d.created_at,
        d.updated_by
    FROM devices_floor3 d
    JOIN rooms_floor3 r ON d.room_id = r.id
    JOIN teachers t ON r.teacher_id = t.id
    WHERE 1
";

// ➕ Aplikovanie filtrov
if (!empty($floor)) {
    $sql .= " AND r.floor = " . intval($floor);
}
if (!empty($room)) {
    $sql .= " AND r.room_number LIKE '%" . $conn->real_escape_string($room) . "%'";
}
if (!empty($teacher)) {
    $sql .= " AND t.full_name LIKE '%" . $conn->real_escape_string($teacher) . "%'";
}
if (!empty($device_type)) {
    $sql .= " AND d.device_type LIKE '%" . $conn->real_escape_string($device_type) . "%'";
}

$sql .= " ORDER BY r.room_number ASC, d.device_type ASC";

$result = $conn->query($sql);

// 📥 CSV hlavička
header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename=technika_export_' . date('Y-m-d_H-i') . '.csv');

// 📝 Vytvor CSV výstup
$output = fopen('php://output', 'w');

// ✨ OPRAVA PRE EXCEL: Pridanie UTF-8 BOM
fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF));

// Zapíš hlavičku
fputcsv($output, array(
    'ID', 'Učebňa', 'Učiteľ', 'Typ zariadenia', 'Model', 'CPU', 
    'RAM', 'Úložisko', 'GPU', 'OS', 'Počet', 'Stav', 'Poznámka', 
    'Dátum pridania', 'Naposledy upravil'
), ';');

// Zapíš dáta
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        fputcsv($output, array(
            $row['id'],
            $row['room_number'],
            $row['teacher_name'],
            $row['device_type'],
            $row['model'],
            $row['cpu'],
            $row['ram'],
            $row['storage'],
            $row['gpu'],
            $row['os'],
            $row['count'],
            $row['status'],
            $row['note'],
            $row['created_at'],
            $row['updated_by']
        ), ';');
    }
}

fclose($output);
$conn->close();
exit;
?>