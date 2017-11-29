<html>
<head>   <meta charset="UTF-8"></head>
<body>

<?php
try{
    require("../dbEdit/dbAcess.php");
    $db = initConnection();


    $sql = "SELECT * FROM Supermercado.evento_reposicao";
    $result = $db->query($sql);

    echo("<h1> Eventos de Repoisição</h1>");

    echo("<table border = \"1\">\n");
    foreach($result as $row){
        echo("<tr><td>");
        echo($row['operador']);
        echo("</td><td>");
        echo($row['instante']);
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



