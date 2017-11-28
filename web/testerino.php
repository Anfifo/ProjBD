<html>
<body>


    <?php

    try{
        $host = "db.ist.utl.pt";
        $user = "ist425998";
        $password = "04091991";
        $dbname = $user;

        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "SELECT * FROM Supermercado.produto";

        $result = $db->query($sql);

        echo("<table border = \"1\">\n");
        echo ("<tr><td>ean</td><td>design</td><td>categoria</td><td>fornPrimario</td><td>data</td></tr>\n");

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
