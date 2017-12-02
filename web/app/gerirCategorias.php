<html>
<head>   <meta charset="UTF-8"></head>
<body>


<?php
try{
    $ROOT = "../";
    $addCategoriaLink = $ROOT . "dbEdit/inserirCategoria.php";
    $rmCategoriaLink = $ROOT . "dbEdit/removerCategoria.php";
    $addSuperCategoriaLink = $ROOT . "dbEdit/inserirSuperCategoria.php";
    include($ROOT."header.php");
    require($ROOT."dbEdit/dbAcess.php");
    $db = initConnection();


    $sql = "SELECT nome FROM Supermercado.categoria";
    $result = $db->query($sql);
    $selectCategorias = "";


    echo("<h1>CATEGORIAS</h1>");

    echo("<table border = \"1\">\n");
    foreach($result as $row){
        echo("<tr><td>");
        echo($row['nome']);
        echo("</td><td>");
        $linkR = $rmCategoriaLink . "?nomeCategoria={$row['nome']}";
        echo("<a href=\"$linkR\">remover</a>");
        echo("</td></tr>");
        $cat = $row['nome'];
        $selectCategorias = $selectCategorias . "<option value= '$cat'>$cat</option>";
    }
    echo("</table>\n");



    $sql = "SELECT nome FROM Supermercado.categoria_simples";
    $result = $db->query($sql);

    echo("<h1>CATEGORIAS SIMPLES</h1>");

    echo("<form action=\"$addCategoriaLink\" method=\"post\">\n
        <input type=\"hidden\" name=\"tipoCategoria\" value=\"categoria_simples\"/>\n
        <p>Inserir nova categoria simples:</p><p></p>\n
        <input type=\"text\" name='nomeCategoria' value=\"nome categoria\"/>\n
        <input type=\"submit\" value=\"Submeter\"/></p>\n
    </form>\n
    ");

    echo("<table border = \"1\">\n");
    foreach($result as $row){
        echo("<tr><td>");
        echo($row['nome']);
        echo("</td><td>");
        $linkR = $rmCategoriaLink . "?nomeCategoria={$row['nome']}";
        echo("<a href=\"../dbEdit/removerCategoria.php?nomeCategoria={$row['nome']}\">remover</a>");
        echo("</td></tr>");
    }
    echo("</table>\n");



    $sql = "SELECT nome FROM Supermercado.super_categoria";
    $result = $db->query($sql);

    echo("<h1> SUPER CATEGORIAS</h1>");

    echo("<form action=\"$addSuperCategoriaLink\" method=\"post\">\n
        <input type=\"hidden\" name=\"tipoCategoria\" value=\"super_categoria\"/>\n
        <p>Inserir nova super categoria:</p><p></p>\n
        <input type=\"text\" name='nomeCategoria' value=\"nome categoria\"/>\n
        <p>Respetivas sub categorias (ctrl para seleccionar várias):</p>\n
        <p><select name='subCategorias[]'  size = \"6\" required multiple />$selectCategorias</select>\n</p>
        <input type=\"submit\" value=\"Submeter\"/></p>\n
    </form>\n
    ");

    echo("<table border = \"1\">\n");
    foreach($result as $row){
        echo("<tr><td>");
        echo($row['nome']);
        echo("</td><td>");
        echo("<a href=\"../dbEdit/removerCategoria.php?nomeCategoria={$row['nome']}\">remover</a>");
        echo("</td><td>");
        echo("<a href=\"listarSubCategorias.php?nomeCategoria={$row['nome']}\">listar sub categorias</a>");
        echo("</td></tr>");
    }
    echo("</table>\n");



    $db = null;

}catch(PDOException $e){
    echo("<p>ERROR:{$e->getMessage()} </p>");
}

?>
</body>
</html>



