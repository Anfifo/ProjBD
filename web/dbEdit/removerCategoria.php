<html>
<head>   <meta charset="UTF-8"></head>

<body>
<?php
    $categoryName = $_REQUEST['nomeCategoria'];

    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist425998";
        $password = "04091991";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

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
