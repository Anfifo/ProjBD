<?php
    $categoryName = $_REQUEST['nomeSuperCategoria'];
    $subCategoryName = $_REQUEST['nomeSubCategoria'];
    try
    {
        require ("dbAcess.php");
        $db = initConnection();

        $db->query("start transaction;");

        $error = "Categoria '" . $categoryName . "' não encontrada.";
        $sql = "DELETE FROM Supermercado.constituida WHERE super_categoria='$categoryName' and categoria = '$subCategoryName';";
        echo($sql);
        $db->query($sql);

        $db->query("commit;");

        $db = null;

        $successMsg = "Sub categoria '" . $subCategoryName . "' da categoria '" . $categoryName . "' removida com sucesso.";
        header("Location:../output.php?successMsg=$successMsg");
    }
    catch (PDOException $e)
    {
        $sqlError = $e->getMessage();
        $error = "Erro ao remover sub categoria: " . $error;
        exitError($error, $db);
    }
?>
