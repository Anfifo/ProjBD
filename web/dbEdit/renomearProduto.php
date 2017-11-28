<html>
<head>   <meta charset="UTF-8"></head>

<body>
<?php
    $ean = $_REQUEST['ean'];
    $newName= $_REQUEST['newName'];

    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist425998";
        $password = "04091991";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


        $db->query("start transaction;");

        $sql = "UPDATE Supermercado.produto SET design = '$newName' WHERE ean = '$ean';";
        echo("<p>$sql</p>");
        $db->query($sql);

        $db->query("commit;");


        $db = null;

        echo("Produto $ean renomeado para $newName com Sucesso");
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
</body>
</html>
