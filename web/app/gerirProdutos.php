<html>
<head>
    <meta charset="UTF-8">
    <script type="text/javascript">
        function requestRename(link, currName){
            var newName = prompt("Por favor insira o novo nome para o produto: " + currName);
            console.log(link);
            if(newName!= null){
                window.location.href = (link + newName);
            }
        }
    </script>
</head>
<body>


<?php
try{
    $ROOT = "../";
    $addProdutoLink = $ROOT . "dbEdit/inserirProduto.php";
    $rmProdutoLink = $ROOT . "dbEdit/removerProduto.php";
    $renomearProdutoLink = $ROOT . "dbEdit/renomearProduto.php";
    include($ROOT."header.php");
    require($ROOT."dbEdit/dbAcess.php");
    $db = initConnection();

    $sql = "SELECT * FROM Supermercado.fornecedor";
    $fornecedores = $db->query($sql);
    $selectForn = "";
    forEach($fornecedores as $fornecedor){
        $fornNif = $fornecedor['nif'];
        $fornNome = $fornecedor['nome'];
        $selectForn = $selectForn . "<option value= '$fornNif'>$fornNif - $fornNome</option>";
    }


    $sql = "SELECT * FROM Supermercado.produto";
    $result = $db->query($sql);
    $date = date('Y-m-d');

    echo("<h1>Produtos</h1>");

    echo("<form action=\"$addProdutoLink\" method=\"post\">\n
        <p><h3>Inserir novo Porduto:</h3></p><p></p>\n
        <p>Ean: <input type=\"text\" name='ean' value=\"1234567890123\"/ required>\n</p>
        <p>Desginação: <input type=\"text\" name='design'/>\n</p>
        <p>Categoria:<input type=\"text\" name='categoria'/>\n</p>
        <p>Fornecedor primário:</p><p><select name='forn_primario' required/>$selectForn</select>\n</p>
        <p>Fornecedores secundários(ctrl para seleccionar varios):\n</p>
        <p><select name='forn_secundario[]'  size = \"6\" required multiple />$selectForn</select>\n</p>
        <p>Data: <input type=\"date\" name='data' value=\"$date\" required/>\n</p>
        <p><input type=\"submit\" value=\"Submeter\"/></p>\n
    </form>\n");


    echo("<h3>Produtos Existentes</h3>");
    echo("<table border = \"1\">\n");
    echo ("<tr><td>ean</td><td>design</td><td>categoria</td><td>fornecedor Primario</td><td>data</td></tr>\n");
    foreach($result as $row){
        echo("<tr><td>");
        echo($row['ean']);
        echo("</td><td>");
        echo($row['design']);
        echo("</td><td>");
        echo($row['categoria']);
        echo("</td><td>");
        echo($row['forn_primario']);
        echo("</td><td>");
        echo($row['data']);
        echo("</td><td>");
        $ean = $row['ean'];
        $nameToRename = $row['design'];
        $linkToRename = $renomearProdutoLink . "?ean=".$ean."&newName=";
        echo("<a href=\"#\" onclick=\"requestRename('$linkToRename', '$nameToRename')\">renomear</a>");
        echo("</td><td>");
        $linkR = $rmProdutoLink."?ean=".$ean;
        echo("<a href=\"$linkR\">remover</a>");
        echo("</td></tr>");
    }
    echo("</table>\n");



    closeConnection($db);
}catch(PDOException $e){
    echo("<p>ERROR:{$e->getMessage()} </p>");
}

?>
</body>
</html>



