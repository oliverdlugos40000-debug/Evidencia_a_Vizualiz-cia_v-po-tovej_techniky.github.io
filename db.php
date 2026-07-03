<?php
// db.php - pripojenie k databáze
$host = "localhost";
$user = "root";
$pass = "";
$dbname = "3poschodie";  // ← POUŽI TVOJU DATABÁZU
$dbname = "2poschodie";
$conn = new mysqli($host, $user, $pass, $dbname);

if ($conn->connect_error) {
    die("Chyba pripojenia k databáze: " . $conn->connect_error);
}

$conn->set_charset("utf8");
?>