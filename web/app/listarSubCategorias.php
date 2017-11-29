<html>
<body>

<?php
    $ROOT = "../";
    include($ROOT."header.php");
    $categoryName = $_REQUEST['nomeCategoria'];

    try {
        require($ROOT . "dbEdit/dbAcess.php");
        $db = initConnection();

        $sql = "SELECT * FROM Supermercado.listar_sub_categorias('$categoryName')";
        $result = $db->query($sql);

        echo("<h1> SUB CATEGORIAS DE $categoryName</h1>");

        echo("<table border = \"1\">\n");
        foreach ($result as $row) {
            echo("<tr><td>");
            echo($row['sub_categoria']);
            echo("</td></tr>");
        }
        echo("</table>");
        $db = null;
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
</body>
</html>
