<?php
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    $token = $_GET["token"];
    
    // Verificar si el token existe y es válido en la base de datos o en cualquier otra fuente de datos

    if ($token == "token_valido") {
        // Mostrar un formulario para que el usuario ingrese una nueva contraseña
        echo "<h3>Restablecer Contraseña</h3>";
        echo "<form action='update_password.php' method='post'>";
        echo "<input type='hidden' name='token' value='$token'>";
        echo "<div class='form-group'>";
        echo "<label for='password'>Nueva Contraseña:</label>";
        echo "<input type='password' class='form-control' id='password' name='password' required>";
        echo "</div>";
        echo "<button type='submit' class='btn btn-primary'>Guardar Contraseña</button>";
        echo "</form>";
    } else {
        echo "El token es inválido.";
    }
}
?>
