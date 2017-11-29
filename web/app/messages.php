<?php

function produtoSucesso($eanProd, $operation){
    return "Produto " . $eanProd ." ". $operation ." com sucesso";

}

function produtoAdicionado($eanProd){
    return produtoSucesso($eanProd, "adicionado");
}


function produtoRemovido($eanProd){
    return produtoSucesso($eanProd, "removido");
}

function produtoNaoAdicionado($eanProduto){
    return "Erro ao adicionar produto " . $eanProduto . ".";
}

function produto