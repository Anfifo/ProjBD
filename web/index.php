<html>
<head>   <meta charset="UTF-8"></head>
<style>
    .menu{
        border: 1px solid black;
        padding: 5px 15px;
        font-size: 17px;
    }
    .menu a:hover {
        background-color: #ddd;
        color: black;
    }

</style>
<body>
<?php
    $ROOT = "./";
    include("header.php");
?>

    <div class = "menu"><a href="app/gerirCategorias.php"> Inserir e remover categorias </a></div>
    <div class = "menu"><a href="app/gerirProdutos.php"> Inserir e remover produtos </a></div>
    <div class = "menu"><a href="app/gerirProdutos.php"> Alterar designação de um produto </a></div>
    <div class = "menu"><a href="app/listarEventosReposicao.php"> Listar eventos de reposição </a></div>
    <div class = "menu"><a href="app/gerirCategorias.php"> Listar sub-categorias de uma super-categoria </a></div>

</body>
</html>



