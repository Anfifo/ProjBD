<?php
//these functions are here in order to regularize all messages by the application

//
function elementSuccess($reference, $element, $operation){
    return $reference . " " . $element ." ". $operation ." com sucesso";
}

function elementFail($reference, $element , $operation){
    return "Falha ao " . $operation. " " .  $reference . ": ". $element .".";
}

function produtoAdicionado($eanProd){
    return elementSuccess("Produto", $eanProd, "adicionado");
}

function produtoRemovido($eanProd){
    return elementSuccess("Produto", $eanProd, "removido");
}

function produtoNaoAdicionado($eanProd){
    return elementFail("Produto", $eanProd, "adicionar");
}

function produtoNaoRemovido($eanProd){
    return elementFail("Produto", $eanProd, "remover");
}

function categoriaAdicionada($nome){
    return elementSuccess("Categoria", $nome, "adicionado");
}

function categoriaNaoAdicionada($nome){
    return elementFail("Categoria", $nome, "adicionar");
}

function categoriaRemovida($nome){
    return elementSuccess("Categoria", $nome, "removida");
}

function categoriaNaoRemovida($nome){
    return elementFail("Categoria", $nome, "remover");
}

function produtoRenomeado($ean){
    return elementSuccess("Produto", $ean, "renomeado");
}
