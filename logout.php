<?php
session_start();

// Vymaž všetky premenné v session
$_SESSION = [];

// Vymaž aj session cookie
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Znič session úplne
session_destroy();

// Presmeruj na index.php (nie index.html!)
echo "<script>
    if (window.top !== window.self) {
        window.top.location.href = 'index.php';
    } else {
        window.location.href = 'index.php';
    }
</script>";
exit;
?>
