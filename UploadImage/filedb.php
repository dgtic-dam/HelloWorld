<?php
date_default_timezone_set('America/Mexico_City');
header("Content-Type: text/html;charset=utf-8");
$archivo = $_FILES['fileToUpload']['tmp_name'];
if (!file_exists($archivo)) {
	die("Archivo no encontrado.");
}
$idUser = $_POST["uid"];
$nombreArchivo = $_FILES['fileToUpload']['name'];
$pathImg    	= "images/".$idUser."/".$nombreArchivo;
if (!file_exists("images/".$idUser)) {
	try {
		mkdir("images/".$idUser, 0777, true);
	} catch(ErrorException $ex) {
		echo json_encode(array("error" => "Error con funci—n mkdir: " . $ex->getMessage()));
		exit;
	}
}
if(!move_uploaded_file($archivo, $pathImg)) {
    echo json_encode(array("error" => 'Archivo no subido, informaci¨®n del archivo: '.print_r($_FILES)));
    exit;
} 
else {
    echo json_encode(array("message" => "Success!.", "code" => "200"));
}
?>
