<?php
$index = $ROOT."index.php";
$produtosLink = $ROOT."app/gerirProdutos.php";
$categoriasLink = $ROOT."app/gerirCategorias.php";
echo/** @lang CSS */
("
<style>
.topnav {
  overflow: hidden;
  background-color: #333;
}
.topnav a {
  float: left;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

.topnav a:hover {
  background-color: #ddd;
  color: black;
}

.topnav a.active {
  background-color: #4CAF50;
  color: white;
}</style>
<div class=\"topnav\">
  <a href=\"$index\">Home</a>
  <a href=\"$produtosLink\">Produtos</a>
  <a href=\"$categoriasLink\">Categorias</a>
</div>


");