
<?php
    $categoryName = $_REQUEST['nomeCategoria'];
    $category = $_REQUEST['tipoCategoria'];
    $subCategories = $_REQUEST['subCategorias'];

    try
    {
        require ("dbAcess.php");
        $db = initConnection();

        $db->query("start transaction;");

        $error = "Categoria '". $categoryName ."' já existe.";
        $sql = "INSERT INTO Supermercado.categoria VALUES ('$categoryName');";
        $db->query($sql);

        $error = "Categoria '".$categoryName ."' já existe.";
        $sql = "INSERT INTO Supermercado.$category VALUES ('$categoryName');";
        $db->query($sql);

        $successMsg = "Categoria '" . $categoryName . "' adicionada com sucesso, com as sub categorias:";

        foreach($subCategories as $cat){
            $cat = trim($cat); //trims so no white spaces at end or end

            $error = "Categoria '" . $cat. "'' já é subcategoria ou supercategoria directa ou indirectamente de '".$categoryName ."''.";
            $sql = "INSERT INTO Supermercado.constituida VALUES ( '$categoryName', '$cat');";
            $db->query($sql);
            $successMsg = $successMsg. " '" . $cat . "'";
        }
        $successMsg = $successMsg.".";

        $db->query("commit;");
        $db = null;
        
     
        header("Location:../output.php?successMsg=$successMsg");
    }
    catch (PDOException $e)
    {
        $sqlError = $e->getMessage();
        $error = "Erro ao adicionar categoria: " . $error;
        exitError($error, $db);
    }
?>