<?php

function initConnection(){

    $host = "db.ist.utl.pt";
    $user = "ist425998";
    $password = "04091991";
    $dbname = $user;

    $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    return $db;
}

function closeConnection(&$db){
    $db = null;

}

function outputSQLTable(){

}