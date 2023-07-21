<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $token = $_POST["token"];
    $new_password = $_POST["password"];
    
    // Actualizar la contraseña asociada al token en la base de datos o en cualquier otra fuente de datos

    // Mostrar un mensaje de éxito al usuario
    echo "Su contraseña se ha restablecido con éxito.";
}
?>
