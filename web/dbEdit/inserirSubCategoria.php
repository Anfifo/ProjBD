
<?php
    $categoryName = $_REQUEST['nomeCategoria'];
    $subCategories = $_REQUEST['subCategorias'];

    $details = array();
    $errors = array();
    try
    {
        require ("dbAcess.php");
        $db = initConnection();

        $db->query("start transaction;");

        $successMsg = "Sub categorias de '" . $categoryName . "':";

        foreach($subCategories as $cat){
            $error = "'".$cat ."'";
            $cat = trim($cat); //trims so no white spaces at end or end
            $sql = "INSERT INTO Supermercado.constituida VALUES ( '$categoryName', '$cat');";
            $detail[] = $sql;
            $db->query($sql);
            $successMsg = $successMsg. " '" . $cat . "'";
        }
        $successMsg = $successMsg."adicionadas com sucesso.";

        $db->query("commit;");
        $db = null;
        
     
        header("Location:../output.php?successMsg=$successMsg");
    }
    catch (PDOException $e)
    {
        $sqlError = $e->getMessage();
        echo($sqlError);
        $error = "Erro ao adicionar sub categoria: " . $error;
        exitError($error, $db);
    }
?>