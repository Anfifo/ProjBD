<?php
    $ean = $_REQUEST['ean'];
    $details = array();

    try
    {
        require ("dbAcess.php");
        $db = initConnection();

        $db->query("start transaction;");

        $error = "Produto com ean '" . $ean ."' nao encontrado";
        print("$ean");
        $sql = "DELETE FROM Supermercado.produto WHERE ean='$ean';";
        $details = $sql;
        $db->query($sql);

        $db->query("commit;");
        $db = null;

        $successMsg = "Produto '" . $ean . "' removido com sucesso.";
        header("Location:../output.php?successMsg=$successMsg");
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        $sqlError = $e->getMessage();
        $error = "Erro ao remover produto: " . $error . "\n" . $sqlError;
        exitError($error, $db);
    }