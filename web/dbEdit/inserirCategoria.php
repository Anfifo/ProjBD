
<?php
    $categoryName = $_REQUEST['nomeCategoria'];
    $category = $_REQUEST['tipoCategoria'];

    $details = array();
    try
    {
        require ("dbAcess.php");
        $db = initConnection();

        $db->query("start transaction;");

        $error = "Categoria '". $categoryName ."' já existe.";
        $sql = "INSERT INTO Supermercado.categoria VALUES ('$categoryName');";
        $detail[] = $sql;
        $db->query($sql);

        $error = "Categoria '".$categoryName ."' já existe.";
        $sql = "INSERT INTO Supermercado.$category VALUES ('$categoryName');";
        $detail[] = $sql;
        $db->query($sql);

        $db->query("commit;");
        $db = null;

        $successMsg = "Categoria '" . $categoryName . "' adicionada com sucesso.";
        header("Location:../output.php?successMsg=$successMsg");
    }
    catch (PDOException $e)
    {
        $sqlError = $e->getMessage();
        $error = "Erro ao adicionar categoria: " . $error;
        exitError($error, $db);
    }
