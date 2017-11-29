
<?php
    $categoryName = $_REQUEST['nomeCategoria'];
    $category = $_REQUEST['tipoCategoria'];

    $details = array();
    $errors = array();
    try
    {
        require ("dbAcess.php");
        $db = initConnection();

        $db->query("start transaction;");

        $sql = "INSERT INTO Supermercado.categoria VALUES ('$categoryName');";
        $detail[] = $sql;
        $db->query($sql);

        $sql = "INSERT INTO Supermercado.$category VALUES ('$categoryName');";
        $detail[] = $sql;
        $db->query($sql);

        $db->query("commit;");
        $db = null;

    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        $errors[] = $e->getMessage();
    }
