<?php
    $ean = $_REQUEST['ean'];
    $newName= $_REQUEST['newName'];

    try
    {
        require ("dbAcess.php");
        $db = initConnection();


        $db->query("start transaction;");

        $sql = "UPDATE Supermercado.produto SET design = '$newName' WHERE ean = '$ean';";
        echo("<p>$sql</p>");
        $db->query($sql);

        $db->query("commit;");


        $db = null;

        echo("Produto $ean renomeado para $newName com Sucesso");
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }