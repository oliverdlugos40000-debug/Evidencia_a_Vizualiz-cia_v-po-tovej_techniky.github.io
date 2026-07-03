<?php
session_start();
if (!isset($_SESSION['logged_in'])) {
    die("Neoprávnený prístup.");
}
$conn = new mysqli("localhost", "root", "", "3poschodie");
$id = intval($_GET['id']);
$conn->query("DELETE FROM devices_floor3 WHERE id=$id");
$conn->close();
header("Location: data.php");
exit;
?>
