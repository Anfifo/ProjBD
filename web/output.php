<html>
<head>   <meta charset="UTF-8"></head>
<body>
<?php
    $ROOT = "./";
    include($ROOT . "header.php");

    $error = $_REQUEST['errorMsg'];
    echo("<p>$error</p>");
    $success = $_REQUEST['successMsg'];
    echo("<p>$success</p>");


?>
</body>
</html>


