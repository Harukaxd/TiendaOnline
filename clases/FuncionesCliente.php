<?php
function esNulo(array $parametros)
{
    foreach ($parametros as $parametro) {
        if (strlen(trim($parametro)) < 1) {
            return true;
        }
    }
    return false;
}

function esEmail($email)
{
    return filter_var($email, FILTER_VALIDATE_EMAIL) !== false;
}

function validaPassword($password, $repassword)
{
    return strcmp($password, $repassword) === 0;
}

function generarToken()
{
    return md5(uniqid(mt_rand(), false));
}

function registraCliente(array $datos, $con)
{
    $sql = $con->prepare("INSERT INTO cliente (Nombre_cliente, Apellido_cliente, Correo_cliente, Tel_cliente, Documento_cliente) VALUES (?,?,?,?,?)");
    if ($sql->execute($datos)) {
        return $con->lastInsertId();
    }
    return 0;
}

function registraUsuario(array $datos, $con)
{
    $password_hash = password_hash($datos[1], PASSWORD_DEFAULT);
    $sql = $con->prepare("INSERT INTO usuario (usuario, password, Token, Id_cliente) VALUES (?,?,?,?)");
    return $sql->execute([$datos[0], $password_hash, $datos[2], $datos[3]]);
}


function usuarioExiste($usuario, $con)
{
    $sql = $con->prepare("SELECT Id_cliente FROM usuario WHERE usuario = ? LIMIT 1");
    $sql->execute([$usuario]);
    return $sql->fetchColumn() > 0;
}

function mailExiste($email, $con)
{
    $sql = $con->prepare("SELECT Cli_cod FROM cliente WHERE Correo_cliente = ? LIMIT 1");
    $sql->execute([$email]);
    return $sql->fetchColumn() > 0;
}

function mostrarMensajes(array $errors)
{
    if (count($errors) > 0) {
        echo '<div class="alert alert-warning alert-dismissible fade show" role="alert"><ul>';
        foreach ($errors as $error) {
            echo '<li>' . $error . '</li>';
        }
        echo '</ul>';
        echo '  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>';
    }
}
function login($usuario, $password, $con)
{
    $sql = $con->prepare("SELECT id, usuario, password FROM usuario WHERE usuario = ? LIMIT 1");
    $sql->execute([$usuario]);
    if ($row = $sql->fetch(PDO::FETCH_ASSOC)) {
        if (esActivo($usuario, $con)) {
            var_dump($password); 
            var_dump($row['password']); 
            if (password_verify($password, $row['password'])) {
                $_SESSION['user_id'] = $row['id'];
                $_SESSION['user_name'] = $row['usuario'];
                header("Location: index.php");
                exit;
            } else {
                return header("Location: index.php");
            }
        } else {
            return 'El usuario no ha sido activado.';
        }
    } else {
        return 'El usuario no existe';
    }
}


function esActivo($usuario, $con)
{
    $sql = $con->prepare("SELECT Activación FROM usuario WHERE usuario = ? LIMIT 1");
    $sql->execute([$usuario]);
    $row = $sql->fetch(PDO::FETCH_ASSOC);
    return $row && $row['Activación'] == 1;
}
?>