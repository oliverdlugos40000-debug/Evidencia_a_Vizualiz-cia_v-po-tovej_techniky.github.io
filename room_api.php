<?php
header('Content-Type: application/json');

$conn = new mysqli("localhost", "root", "", "3poschodie");
if($conn->connect_error){
    echo json_encode([]);
    exit;
}

$room = $conn->real_escape_string($_GET['room']);

$sql = "
    SELECT device_type, model, cpu, ram, count 
    FROM devices_floor3 d
    JOIN rooms_floor3 r ON d.room_id = r.id
    WHERE r.room_number = '$room'
";

$res = $conn->query($sql);
$data = [];

while($row = $res->fetch_assoc()){
    $data[] = $row;
}

echo json_encode($data);
