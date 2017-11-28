<html>
<head>   <meta charset="UTF-8"></head>

<body>

<?php
    $ean = $_REQUEST['ean'];
    $design = $_REQUEST['design'];

    $categoria = $_REQUEST['categoria'];
    $categoria = !empty($categoria) ? $categoria : NULL;

    $forn_primario = $_REQUEST['forn_primario'];
    $data = $_REQUEST['data'];
    $forn_secundario = $_REQUEST['forn_secundario'];
    $secundarios = explode (",", $forn_secundario);
    $data = date('d-m-Y', strtotime($data));


try
    {
        $host = "db.ist.utl.pt";
        $user ="ist425998";
        $password = "04091991";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->query("start transaction;");

        //add fornecedor primario
        $sql = "SELECT nif FROM Supermercado.fornecedor WHERE nif = '$forn_primario';"; //verify if fornecedor exists

        echo("<p>$sql</p>");
        $db->query($sql);


        $sql = "INSERT INTO Supermercado.produto (ean, design,categoria, forn_primario, data) VALUES ( '$ean', '$design', '$categoria', $forn_primario, to_date('$data', 'DD MM YYYY'));";
        echo("<p>$sql</p>");
        $db->query($sql);



        //fornecedores secundarios
        foreach($secundarios as $forn){
            $forn = trim($forn); //trims so no white spaces at end or end
            $sql = "SELECT nif FROM Supermercado.fornecedor WHERE nif = '$forn';"; //verify if fornecedor exists
            echo("<p>$sql</p>");
            $db->query($sql);
            $sql = "INSERT INTO Supermercado.fornece_sec (nif, ean) VALUES ( '$forn', '$ean');";
            echo("<p>$sql</p>");
            $db->query($sql);
        }


        $db->query("commit;");

        $db = null;
        echo("Produto $ean adicionado com Sucesso");
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
</body>
</html>
