<html>
<body>

<?php
    $ROOT = "../";
    include($ROOT."header.php");
    $categoryName = $_REQUEST['nomeCategoria'];
    function show_sub_categories($db, $cat){
        $sql = "SELECT * FROM Supermercado.constituida where super_categoria = '$cat'";
        $result = $db->query($sql);
        foreach ($result as $row) {
            echo("<tr><td>");
            echo($row['categoria']);
            echo("</td></tr>");
            show_sub_categories($db, $row['categoria']);
        }
    }

    try {
        require($ROOT . "dbEdit/dbAcess.php");
        $db = initConnection();



        echo("<h1> SUB CATEGORIAS DE $categoryName</h1>");

        echo("<table border = \"1\">\n");
        show_sub_categories($db, $categoryName);
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
