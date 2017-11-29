<html>
<head>   <meta charset="UTF-8"></head>

<body>
<?php
    $categoryName = $_REQUEST['nomeCategoria'];
    $category = $_REQUEST['tipoCategoria'];

    try
    {
        require ("dbAcess.php");
        $db = initConnection();

        $db->query("start transaction;");

        $sql = "INSERT INTO Supermercado.categoria VALUES ('$categoryName');";
        echo("<p>$sql</p>");
        $db->query($sql);

        $sql = "INSERT INTO Supermercado.$category VALUES ('$categoryName');";
        echo("<p>$sql</p>");
        $db->query($sql);


        $db->query("commit;");

        $db = null;

        echo("Categoria $categoryName adicionada com Sucesso");
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
</body>
</html>
