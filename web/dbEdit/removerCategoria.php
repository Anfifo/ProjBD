<?php
    $categoryName = $_REQUEST['nomeCategoria'];
    $details = array();
    try
    {
        require ("dbAcess.php");
        $db = initConnection();

        $db->query("start transaction;");

        $error = "Categoria '" . $categoryName . "' não encontrada.";
        $sql = "DELETE FROM Supermercado.categoria WHERE nome='$categoryName';";
        $details = $sql;
        $db->query($sql);

        $db->query("commit;");

        $db = null;

        $successMsg = "Categoria '" . $categoryName . "' removida com sucesso.";
        header("Location:../output.php?successMsg=$successMsg");
    }
    catch (PDOException $e)
    {
        $sqlError = $e->getMessage();
        $error = "Erro ao remover categoria: " . $error;
        exitError($error, $db);
    }
?>
