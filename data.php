<?php
session_start();

$servername = "localhost";
$username = "root"; 
$password = "";
$dbname = "3poschodie";

// 🔗 Pripojenie k databáze
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Chyba pripojenia: " . $conn->connect_error);
}

// 🔍 Filtrovanie podľa parametrov z URL
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
?>

<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <title>Dáta – Evidencia</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 10px;
            background-color: #f9f9f9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
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
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .logout-link {
            text-decoration: none;
            color: white;
            background-color: #d9534f;
            padding: 6px 12px;
            border-radius: 5px;
        }
        .logout-link:hover {
            background-color: #c9302c;
        }
        .add-btn {
            text-decoration: none;
            background-color: #0072ce;
            color: white;
            padding: 6px 12px;
            border-radius: 5px;
        }
        .add-btn:hover {
            background-color: #0055a5;
        }
        .action-links a {
            text-decoration: none;
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="top-bar">
        <h2>📋 Výsledky filtrovania</h2>
        <?php if (isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true): ?>
            <div>
                <a href="add.php" class="add-btn">➕ Pridať zariadenie</a>

                <?php if (isset($_SESSION['role']) && $_SESSION['role'] === 'admin'): ?>
                    <a href="users.php" target="_top" class="add-btn">👥 Správa používateľov</a>
                <?php endif; ?>

                <button onclick="exportCSV()" class="add-btn">📥 Export CSV</button>

                <a href="logout.php" class="logout-link">Odhlásiť sa</a>
            </div>
        <?php endif; ?>
    </div>

    <?php
    if ($result && $result->num_rows > 0) {
        echo "<table>";
        echo "<tr>
                <th>ID</th>
                <th>Učebňa</th>
                <th>Učiteľ</th>
                <th>Typ zariadenia</th>
                <th>Model</th>
                <th>CPU</th>
                <th>RAM</th>
                <th>Úložisko</th>
                <th>GPU</th>
                <th>OS</th>
                <th>Počet</th>
                <th>Stav</th>
                <th>Poznámka</th>";

        // 👑 Dátum a kto upravil len pre admina
        if (isset($_SESSION['role']) && $_SESSION['role'] === 'admin') {
            echo "<th>Dátum pridania</th>
                  <th>Naposledy upravil</th>";
        }

        // Akcie pre prihlásených
        if (isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true) {
            echo "<th>Akcia</th>";
        }

        echo "</tr>";

        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['id']}</td>
                    <td>{$row['room_number']}</td>
                    <td>{$row['teacher_name']}</td>
                    <td>{$row['device_type']}</td>
                    <td>{$row['model']}</td>
                    <td>{$row['cpu']}</td>
                    <td>{$row['ram']}</td>
                    <td>{$row['storage']}</td>
                    <td>{$row['gpu']}</td>
                    <td>{$row['os']}</td>
                    <td>{$row['count']}</td>
                    <td>{$row['status']}</td>
                    <td>{$row['note']}</td>";

            // 👑 Len admin vidí tieto údaje
            if (isset($_SESSION['role']) && $_SESSION['role'] === 'admin') {
                echo "<td>{$row['created_at']}</td>
                      <td>{$row['updated_by']}</td>";
            }

            // Akcie pre prihlásených
            if (isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true) {
                echo "<td class='action-links'>
                        <a href='edit.php?id={$row['id']}'>✏️ Upraviť</a>
                        <a href='delete.php?id={$row['id']}' onclick=\"return confirm('Naozaj zmazať toto zariadenie?');\">🗑️ Zmazať</a>
                      </td>";
            }

            echo "</tr>";
        }

        echo "</table>";
    } else {
        echo "<p>⚠️ Žiadne záznamy nevyhovujú zadaným filtrom.</p>";
    }

    $conn->close();
    ?>
<script>
function exportCSV() {
    // Získaj aktuálne filtre z URL
    const urlParams = new URLSearchParams(window.location.search);
    const floor = urlParams.get('floor') || '';
    const room = urlParams.get('room') || '';
    const teacher = urlParams.get('teacher') || '';
    const device_type = urlParams.get('device_type') || '';
    
    // Presmeruj na export script s filtrami
    window.location.href = `export_csv.php?floor=${encodeURIComponent(floor)}&room=${encodeURIComponent(room)}&teacher=${encodeURIComponent(teacher)}&device_type=${encodeURIComponent(device_type)}`;
}
</script>


</body>
</html>
