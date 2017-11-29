<html>
<head>   <meta charset="UTF-8"></head>

<body>
<?php
    $categoryName = $_REQUEST['nomeCategoria'];

    try
    {
        require ("dbAcess.php");
        $db = initConnection();

        $db->query("start transaction;");

        $sql = "DELETE FROM Supermercado.categoria WHERE nome='$categoryName';";
        echo("<p>$sql</p>");
        $db->query($sql);

        $db->query("commit;");

        $db = null;

        echo("Categoria $categoryName removida com Sucesso");
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
</body>
</html>
