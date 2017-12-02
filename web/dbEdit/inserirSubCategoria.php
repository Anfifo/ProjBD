
<?php
    $categoryName = $_REQUEST['nomeSuperCategoria'];
    $subCategories = $_REQUEST['subCategorias'];

    try
    {
        require ("dbAcess.php");
        $db = initConnection();


        $db->query("start transaction;");

        $successMsg = "Sub categorias de '" . $categoryName . "':";

        foreach($subCategories as $cat){
            $cat = trim($cat); //trims so no white spaces at end or end

            if($cat == $categoryName){
                exitError("Uma super categoria não pode ser constituida por ela própria.", $db);
            }

            $error = "Categoria '" . $cat. "'' já é subcategoria ou supercategoria directa ou indirectamente de '".$categoryName ."''.";
            $sql = "INSERT INTO Supermercado.constituida (super_categoria, categoria)VALUES ( '$categoryName', '$cat');";
            $db->query($sql);
            $successMsg = $successMsg. " '" . $cat . "' ";
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