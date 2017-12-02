<?php
$ean = $_REQUEST['ean'];
$newName= $_REQUEST['newName'];

$details = array();


try
    {
        require ("dbAcess.php");
        $db = initConnection();


        $db->query("start transaction;");

        $error = "Produto com ean '" . $ean . "' não encontrado.";
        $sql = "UPDATE Supermercado.produto SET design = '$newName' WHERE ean = '$ean';";
        $details = $sql;
        $db->query($sql);

        $db->query("commit;");
        $db = null;

        $successMsg = "Produto '" . $ean . "' renomeado para '" . $newName . "' com sucesso.";
        header("Location:../output.php?successMsg=$successMsg");
    }
    catch (PDOException $e)
    {
        $sqlError = $e->getMessage();
        $error = "Erro ao renomear produto: " . $error;
        exitError($error, $db);
    }

