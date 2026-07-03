<?php
session_start();
?>
<!DOCTYPE html>
<html lang="sk">
<head>
    <meta charset="UTF-8">
    <title>Evidencia techniky</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<header>
    <h1>Evidencia výpočtovej techniky</h1>
    <p class="subtitle">SOŠ Ostrovského Košice</p>

    <div class="admin-panel-header">
        <a href="vizualizacia.php" class="admin-btn">🗺️ Vizualizácia</a>
        
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

<section class="filter-box">
    <form onsubmit="updateIframe(); return false;">
        <div class="form-group">
            <label for="floor">Poschodie:</label>
            <select id="floor">
                <option value="">-- všetky --</option>
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3" selected>3</option>
            </select>
        </div>

        <div class="form-group">
            <label for="room">Učebňa:</label>
            <input type="text" id="room" placeholder="napr. 302">
        </div>

        <div class="form-group">
            <label for="teacher">Učiteľ:</label>
            <input type="text" id="teacher" placeholder="napr. Takáč">
        </div>

        <div class="form-group">
            <label for="device_type">Typ zariadenia:</label>
            <select id="device_type">
                <option value="">-- všetky --</option>
                <option value="Notebook">Notebook</option>
                <option value="PC">PC</option>
                <option value="Monitor">Monitor</option>
                <option value="3D tlačiareň">3D tlačiareň</option>
                <option value="Tlačiareň">Tlačiareň</option>
                <option value="Projektor">Projektor</option>
                <option value="Router">Router</option>
                <option value="Iné">Iné</option>
            </select>
        </div>

        <button type="submit">Zobraziť</button>
    </form>

<form onsubmit="updateIframe(); return false;">




    <p class="login-info">
        Na pridávanie, úpravu a odstránenie zariadení je potrebné sa prihlásiť ako administrátor.
    </p>
</section>

<section class="iframe-container">
    <iframe src="data.php" name="data" class="data-frame" loading="lazy"></iframe>
</section>

<footer>
    <p>© 2025 SOŠ Ostrovského Košice | Autor: Oliver Dlugoš</p>
</footer>

<script>
function updateIframe() {
    const floor = document.getElementById('floor').value;
    const room = document.getElementById('room').value;
    const teacher = document.getElementById('teacher').value;
    const device_type = document.getElementById('device_type').value;

    const url = `data.php?floor=${encodeURIComponent(floor)}&room=${encodeURIComponent(room)}&teacher=${encodeURIComponent(teacher)}&device_type=${encodeURIComponent(device_type)}`;
    document.querySelector('.data-frame').src = url;
}
</script>

<script>
function exportCSV() {
    const floor = document.getElementById('floor').value;
    const room = document.getElementById('room').value;
    const teacher = document.getElementById('teacher').value;
    const device_type = document.getElementById('device_type').value;

    const url = `export_csv.php?floor=${encodeURIComponent(floor)}&room=${encodeURIComponent(room)}&teacher=${encodeURIComponent(teacher)}&device_type=${encodeURIComponent(device_type)}`;
    window.open(url, "_blank");
}
</script>


</body>
</html>