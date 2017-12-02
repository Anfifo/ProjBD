<html>
<body>

<?php
    $ROOT = "../";
    $addSubCategoriaLink = $ROOT . "dbEdit/inserirSubCategoria.php";
    include($ROOT."header.php");
    $categoryName = $_REQUEST['nomeCategoria'];

    function show_sub_categories($db, $cat, $categoryName, $firstLevel){
        $sql = "SELECT * FROM Supermercado.constituida where super_categoria = '$cat'";
        $result = $db->query($sql);
        foreach ($result as $row) {
            echo("<tr><td>");
            echo($row['categoria']);
            echo("</td><td>");
            if($firstLevel){
                echo("<a href=\"../dbEdit/removerSubCategoria.php?nomeSubCategoria={$row['categoria']}&nomeCategoria='$categoryName'\">remover sub categoria</a>");
            }
            echo("</td></tr>");
            show_sub_categories($db, $row['categoria'], $categoryName, false);
        }
    }

    try {
        require($ROOT . "dbEdit/dbAcess.php");
        $db = initConnection();

        $selectCategorias = "";
        $sql = "SELECT nome FROM Supermercado.categoria";
        $result = $db->query($sql);
        foreach($result as $row){
            $cat = $row['nome'];
            $selectCategorias = $selectCategorias . "<option value= '$cat'>$cat</option>";
        }

        echo("<h1> Sub Categorias de $categoryName</h1>");

        echo("<form action=\"$addSubCategoriaLink\" method=\"post\">\n
            <input type=\"hidden\" name=\"nomeSuperCategoria\" value=\"$categoryName\"/>\n
            <p>Inserir nova sub categoria (ctrl para seleccionar várias):</p><p></p>\n
            <p><select name='subCategorias[]'  size = \"6\" required multiple />$selectCategorias</select>\n</p>
            <input type=\"submit\" value=\"Submeter\"/></p>\n
        </form>\n
        ");

        echo("<table border = \"1\">\n");
        show_sub_categories($db, $categoryName, $categoryName, true);
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
