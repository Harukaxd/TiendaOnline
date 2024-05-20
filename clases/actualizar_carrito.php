<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require '../config/config.php';
require '../config/database.php';

// Establecer el encabezado de la respuesta como JSON
header('Content-Type: application/json');

$datos = array(); // Inicializa el array de datos para la respuesta

if (isset($_POST['action'])) {
    $action = $_POST['action'];
    $id = isset($_POST['Pro_cod']) ? $_POST['Pro_cod'] : 0;

    if ($action == 'agregar') {
        $cantidad = isset($_POST['cantidad']) ? $_POST['cantidad'] : 0;
        $respuesta = agregar($id, $cantidad);
        if ($respuesta > 0) {
            $datos['ok'] = true;
        } else {
            $datos['ok'] = false;
        }
        $datos['sub'] = MONEDA . number_format($respuesta, 2, '.', ',');
    } else if ($action == 'eliminar') {
        $datos['ok'] = elimina($id);
    } else {
        $datos['ok'] = false;
    }
} else {
    $datos['ok'] = false;
}

echo json_encode($datos);

function agregar($id, $cantidad)
{
    $res = 0;
    if ($id > 0 && $cantidad > 0 && is_numeric($cantidad)) {
        if (isset($_SESSION['carrito']['productos'][$id])) {
            $_SESSION['carrito']['productos'][$id] = $cantidad;

            $db = new Database();
            $con = $db->conectar();
            $sql = $con->prepare("SELECT Precio_prod FROM producto WHERE Pro_cod=? LIMIT 1");
            $sql->execute([$id]);
            $row = $sql->fetch(PDO::FETCH_ASSOC);
            if ($row) {
                $precio = $row["Precio_prod"];
                $res = $cantidad * $precio;
            }
        }
    }
    return $res;
}
function elimina($id)
{
    if (isset($_SESSION['carrito']['productos']) && $id > 0) {
        // La variable de sesión existe y el ID es válido
        if (isset($_SESSION['carrito']['productos'][$id])) {
            // El producto está en el carrito, procedemos a eliminarlo
            unset($_SESSION['carrito']['productos'][$id]);
            return true;
        } else {
            // El producto no está en el carrito
            return false;
        }
    } else {
        // La variable de sesión no está definida o el ID no es válido
        return false;
    }

}

?>