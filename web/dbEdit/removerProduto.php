<html>
<head>   <meta charset="UTF-8"></head>

<body>
<?php
$ean = $_REQUEST['ean'];

try
{
    require ("dbAcess.php");
    $db = initConnection();

    $db->query("start transaction;");

    $sql = "DELETE FROM Supermercado.produto WHERE ean='$ean';";
    echo("<p>$sql</p>");
    $db->query($sql);

    $db->query("commit;");

    $db = null;

    echo("Produto $ean removido com Sucesso");
}
catch (PDOException $e)
{
    $db->query("rollback;");
    echo("<p>ERROR: {$e->getMessage()}</p>");
}
?>
</body>
</html>
