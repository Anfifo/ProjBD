<?php
    $ean = $_REQUEST['ean'];
    $design = $_REQUEST['design'];
    $categoria = $_REQUEST['categoria'];
    $forn_primario = $_REQUEST['forn_primario'];
    $data = $_REQUEST['data'];
    $secundarios = $_REQUEST['forn_secundario'];

    $data = date('d-m-Y', strtotime($data));
    $error = "Erro ao adicionar produto: ";

try
    {
        require ("dbAcess.php");
        $db = initConnection();

        //Verifications
        //verify if  fornecedor primario existe
        $sql = "SELECT nif FROM Supermercado.fornecedor WHERE nif = '$forn_primario' LIMIT 1;"; //verify if fornecedor exists
        $test = $db->query($sql);
        if ($test->rowCount() == 0){
            exitError($error." Fornecedor " . $ean . "não encontrado.", $db);
        }

        //verify if categoria existe
       if(!empty($categoria)){
           $sql = "SELECT nome FROM Supermercado.categoria WHERE nome = '$categoria' LIMIT 1;"; //verify if fornecedor exists
           $test = $db->query($sql);
           if ($test->rowCount() == 0){
               exitError($error." Categoria " . $categoria . "não encontrada.", $db);
           }
       }

       //verify ean is a positive number and exactly 13 digits
        if( (int)$ean < 0 || strlen($ean) != 13){
           $testerino = "nope";
           exitError($error . " O ean " . $ean. " tem de ser um número inteiro com 13 digitos.", $db);
        }

        if($data > date('d-m-Y')){
            exitError($error." Data " . $date. " superior à atual: " . date('d-m-Y') .".", $db);
        }


        $db->query("start transaction;");

        if(empty($categoria)){
            $sql = "INSERT INTO Supermercado.produto (ean, design, forn_primario, data) VALUES ( '$ean', '$design', $forn_primario, to_date('$data', 'DD MM YYYY'));";
        }else{
            $sql = "INSERT INTO Supermercado.produto (ean, design,categoria, forn_primario, data) VALUES ( '$ean', '$design', '$categoria', $forn_primario, to_date('$data', 'DD MM YYYY'));";
        }
        $db->query($sql);



        //fornecedores secundarios
        foreach($secundarios as $forn){
            $forn = trim($forn); //trims so no white spaces at start or end

            $sql = "SELECT nif FROM Supermercado.fornecedor WHERE nif = '$forn' LIMIT 1;"; //verify if fornecedor exists
            $test = $db->query($sql);
            if ($test->rowCount() == 0){
                exitError($error." Fornecedor " . $forn . "não existe.", $db); //verify if fornecedor exists
            }

            //fornecedor primario = secundario?
            if($forn == $forn_primario){
                exitError($error." Fornecedor " .$forn ." não pode ser primario e secundario do mesmo produto.", $db);
            }

            $sql = "INSERT INTO Supermercado.fornece_sec (nif, ean) VALUES ( '$forn', '$ean');";
            $db->query($sql);
        }


        $db->query("commit;");
        $db = null;
        $successMsg = "Produto '" . $ean . "' adicionada com sucesso.";
        header("Location:../output.php?successMsg=$successMsg");
    }



    catch (PDOException $e)
    {
        $sqlError = $e->getMessage();
        $sqlCode = $e->getCode();

        switch ($sqlCode) {
            case "23505":
                $error = "Produto com ean: " . $ean . " já existe.";
                break;
            case "23503":
                $error = "Categoria: " . $categoria . " não encontrada.";
                break;
            case "22P02";
                $error = "Sintaxe inválida para um dos campos.";
                break;
            case "P0001";
                $error = substr($sqlError, 42);
                break;
            default:
                $error = "Erro desconhecido, verifique se os valores que introduziu estão correctos. Se o problema persistir contacte o administrador.";
        }

        exitError($error, $db);
    }
