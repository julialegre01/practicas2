<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST["email"];
    
    // Verificar si el correo electrónico existe en la base de datos o en cualquier otra fuente de datos
    
    // Generar un token único para el restablecimiento de contraseña
    $token = uniqid();

    // Guardar el token en la base de datos o en cualquier otra fuente de datos asociada al correo electrónico

    // Enviar un correo electrónico al usuario con un enlace que contiene el token
    $reset_link = "http://tudominio.com/reset_password.php?token=" . $token;
    $message = "Haga clic en el siguiente enlace para restablecer su contraseña: <a href='$reset_link'>$reset_link</a>";
    $subject = "Recuperación de Contraseña";
    $headers = "From: noreply@tudominio.com\r\n";
    $headers .= "Content-Type: text/html; charset=UTF-8\r\n";
    mail($email, $subject, $message, $headers);

    // Mostrar un mensaje de éxito al usuario
    echo "Se ha enviado un correo electrónico con instrucciones para restablecer su contraseña.";
}
?>
