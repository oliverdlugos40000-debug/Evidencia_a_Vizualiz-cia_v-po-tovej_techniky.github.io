<?php
session_start();

// Databázové pripojenie
$host = "localhost";
$user = "root";
$pass = "";
$db   = "3poschodie";

$conn = new mysqli($host, $user, $pass, $db);  
if ($conn->connect_error) {
    die("Chyba pripojenia: " . $conn->connect_error);
}
$conn->set_charset("utf8");

// Získanie aktuálneho poschodia z URL, predvolené je 3
$current_floor = isset($_GET['floor']) ? intval($_GET['floor']) : 3;
?>

<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <title>Vizualizácia výpočtovej techniky na škole</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* ŠTÝLY PRE VIZUALIZÁCIU */
        .vizualizacia-container {
            display: flex;
            justify-content: center;
            gap: 40px;
            margin: 30px;
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
        }

        .map-panel, .detail-panel {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 45%;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .floor-nav {
            text-align: center;
            margin: 20px 0;
        }
        .floor-link {
            display: inline-block;
            padding: 10px 20px;
            margin: 0 5px;
            background-color: #f0f0f0;
            border: 2px solid #ccc;
            border-radius: 5px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        .floor-link.active {
            background-color: #0072ce;
            color: white;
            border-color: #005fa3;
        }

        .wing {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        .room {
            background: #ffffff;
            border: 2px solid #000;
            padding: 15px;
            border-radius: 6px;
            cursor: pointer;
            text-align: center;
            font-weight: bold;
            transition: background-color 0.3s ease;
            min-width: 80px;
        }

        .room:hover {
            background-color: #007bff;
            color: white;
        }

        .detail-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        .detail-table th, .detail-table td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        .detail-table th {
            background-color: #f0f0f0;
        }
        
        .back-link {
            display: inline-block;
            margin: 10px 0;
            background-color: #0072ce;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
        }
    </style>
</head>
<body>
<header>
    <h1> Vizualizácia výpočtovej techniky</h1>
    <p class="subtitle">Interaktívna mapa učební - <?= $current_floor ?>. poschodie</p>

    <div class="admin-panel-header">
        <a href="index.php" class="admin-btn">← Späť na evidenciu</a>
        
        <?php if (isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true): ?>
            <span class="logged-info">🔐 Prihlásený ako: 
                <strong><?= htmlspecialchars($_SESSION['username']) ?></strong>
            </span>
            <a href="logout.php" class="admin-btn">🚪 Odhlásiť sa</a>
        <?php else: ?>
            <a href="login.php" class="admin-btn">🔐 Prihlásiť sa</a>
        <?php endif; ?>
    </div>
</header>

<div class="floor-nav">
    <a href="?floor=0" class="floor-link <?= $current_floor == 0 ? 'active' : '' ?>">Prízemie</a>
    <a href="?floor=1" class="floor-link <?= $current_floor == 1 ? 'active' : '' ?>">1. poschodie</a>
    <a href="?floor=2" class="floor-link <?= $current_floor == 2 ? 'active' : '' ?>">2. poschodie</a>
    <a href="?floor=3" class="floor-link <?= $current_floor == 3 ? 'active' : '' ?>">3. poschodie</a>
</div>

<div class="vizualizacia-container">
    <div class="map-panel">
        
        <?php if ($current_floor == 0): ?>
            <h2>Ľavá časť</h2>
            <div class="wing">
                <?php foreach (['006', '011', '012', '013'] as $r): ?>
                    <div class="room" onclick="loadRoom('<?= $r ?>', 0)"><?= $r ?></div>
                <?php endforeach; ?>
            </div>
            <h2>Pravá časť</h2>
            <div class="wing">
                <?php foreach (['015', '016', '017', '021', '023'] as $r): ?>
                    <div class="room" onclick="loadRoom('<?= $r ?>', 0)"><?= $r ?></div>
                <?php endforeach; ?>
            </div>

        <?php elseif ($current_floor == 1): ?>
            <h2>Ľavé krídlo</h2>
            <div class="wing">
                <?php foreach (['102', '104', '106'] as $r): ?>
                    <div class="room" onclick="loadRoom('<?= $r ?>', 1)"><?= $r ?></div>
                <?php endforeach; ?>
            </div>
            <h2>Stred a Pravé krídlo</h2>
            <div class="wing">
                <?php foreach (['107', '108', '109', '114', '124'] as $r): ?>
                    <div class="room" onclick="loadRoom('<?= $r ?>', 1)"><?= $r ?></div>
                <?php endforeach; ?>
            </div>

        <?php elseif ($current_floor == 2): ?>
            <h2>Ľavé krídlo</h2>
            <div class="wing">
                <?php foreach (['202', '203', '206', '208', '210'] as $r): ?>
                    <div class="room" onclick="loadRoom('<?= $r ?>', 2)"><?= $r ?></div>
                <?php endforeach; ?>
            </div>

            <h2>Stred</h2>
            <div class="wing">
                <?php foreach (['211', '212'] as $r): ?>
                    <div class="room" onclick="loadRoom('<?= $r ?>', 2)"><?= $r ?></div>
                <?php endforeach; ?>
            </div>

            <h2>Pravé krídlo</h2>
            <div class="wing">
                <?php foreach (['214', '215', '216', '218', '220'] as $r): ?>
                    <div class="room" onclick="loadRoom('<?= $r ?>', 2)"><?= $r ?></div>
                <?php endforeach; ?>
            </div>

        <?php elseif ($current_floor == 3): ?>
            <h2>Ľavé krídlo</h2>
            <div class="wing">
                <?php foreach ([302,303,305,306,309,310] as $r): ?>
                    <div class="room" onclick="loadRoom('<?= $r ?>', 3)"><?= $r ?></div>
                <?php endforeach; ?>
            </div>

            <h2>Stred</h2>
            <div class="wing">
                <div class="room" onclick="loadRoom('311', 3)">311</div>
                <div class="room" onclick="loadRoom('317', 3)">317</div>
            </div>

            <h2>Pravé krídlo</h2>
            <div class="wing">
                <?php foreach ([313,314,315,316] as $r): ?>
                    <div class="room" onclick="loadRoom('<?= $r ?>', 3)"><?= $r ?></div>
                <?php endforeach; ?>
            </div>

        <?php else: ?>
            <h2>Miestnosti na poschodí</h2>
            <div class="wing">
                <?php 
                $res = $conn->query("SELECT room_number FROM rooms_floor3 WHERE floor = $current_floor ORDER BY room_number ASC");
                while ($row = $res->fetch_assoc()): ?>
                    <div class="room" onclick="loadRoom('<?= $row['room_number'] ?>', <?= $current_floor ?>)"><?= $row['room_number'] ?></div>
                <?php endwhile; ?>
            </div>
        <?php endif; ?>
        
    </div>

    <div class="detail-panel">
        <h2>Detail učebne</h2>
        <div id="room-output">Klikni na učebňu...</div>
    </div>
</div>

<footer>
    <p>© 2025 SOŠ Ostrovského Košice | Autor: Oliver Dlugoš</p>
</footer>

<script>
function loadRoom(room, floor) {
    // Pridali sme parameter floor, aby room_detail.php vedel presne o ktorú miestnosť ide
    fetch("room_detail.php?room=" + room + "&floor=" + floor)
        .then(res => res.text())
        .then(html => {
            document.getElementById("room-output").innerHTML = html;
        });
}
</script>

</body>
</html>