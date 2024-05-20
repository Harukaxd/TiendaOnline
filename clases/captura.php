<?php

require '../config/config.php';
require '../config/database.php';
$db = new Database();
$con = $db->conectar();

$json = file_get_contents('php://input');
$datos = json_decode($json, true);

echo '<pre>';
print_r($datos);
echo '</pre>';

if(is_array($datos)){
    $id_transaccion = $datos['id'];
    $total = $datos['purchase_units']['amount']['value'];
    $status = $datos['status'];
    $fecha = $datos['update_time'];
    $fecha_nueva = date('Y-m-d H:i:s', strtotime($fecha));
    $email = $datos['payer']['email_address'];
    $id_cliente = $datos['payer']['payer_id'];

    $sql = $con->prepare("INSERT INTO compra (id_transaccion, fecha, status, email, id_cliente, total) VALUES (?,?,?,?,?,?)");
    $sql->execute([$id_transaccion, $fecha_nueva, $status, $email, $id_cliente, $total]);
    $id = $con->lastInsertId();
    
}