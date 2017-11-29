<html>
<head>   <meta charset="UTF-8"></head>

<body>
<?php
    $categoryName = $_REQUEST['nomeCategoria'];

    try
    {
        require ("dbAcess.php");
        $db = initConnection();

        $sql = "SELECT * FROM Supermercado.listar_sub_categorias('$categoryName')";
        $result = $db->query($sql);

        echo("<h1> SUB CATEGORIAS</h1>");

        echo("<table border = \"1\">\n");
    foreach($result as $row){
        echo("<tr><td>");
        echo($row['nome']);
        echo("</td></tr>");
    }
    
    $db = null;

    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
</body>
</html>
