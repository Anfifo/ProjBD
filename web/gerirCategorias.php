<html>
<head>   <meta charset="UTF-8"></head>
<body>
    Listar todas as categorias com botão de remover a frente
    colocar opção de adicionar categoria nova

<?php
try{
    $host = "db.ist.utl.pt";
    $user = "ist425998";
    $password = "04091991";
    $dbname = $user;

    $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


    $sql = "SELECT nome FROM Supermercado.categoria";
    $result = $db->query($sql);

    echo("<h1>CATEGORIAS</h1>");

    echo("<table border = \"1\">\n");
    foreach($result as $row){
        echo("<tr><td>");
        echo($row['nome']);
        echo("</td><td>");
        echo("<a href=\"dbEdit/removerCategoria.php?nomeCategoria={$row['nome']}\">remover</a>");
        echo("</td></tr>");
    }
    echo("</table>\n");



    $sql = "SELECT nome FROM Supermercado.categoria_simples";
    $result = $db->query($sql);

    echo("<h1>CATEGORIAS SIMPLES</h1>");

    echo("<form action=\"dbEdit/inserirCategoria.php\" method=\"post\">\n
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
        echo("<a href=\"dbEdit/removerCategoria.php?nomeCategoria={$row['nome']}\">remover</a>");
        echo("</td></tr>");
    }
    echo("</table>\n");



    $sql = "SELECT nome FROM Supermercado.super_categoria";
    $result = $db->query($sql);

    echo("<h1> SUPER CATEGORIAS</h1>");

    echo("<form action=\"dbEdit/inserirCategoria.php\" method=\"post\">\n
        <input type=\"hidden\" name=\"tipoCategoria\" value=\"super_categoria\"/>\n
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
        echo("<a href=\"dbEdit/removerCategoria.php?nomeCategoria={$row['nome']}\">remover</a>");
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



