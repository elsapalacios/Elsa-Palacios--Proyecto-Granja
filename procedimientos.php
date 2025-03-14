<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "database_granja";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Función para actualizar la ubicación de un animal
function actualizarUbicacionAnimal($conn, $animal_id, $nueva_ubicacion) {
    $stmt = $conn->prepare("CALL ActualizarUbicacionAnimal(?, ?)");
    $stmt->bind_param("is", $animal_id, $nueva_ubicacion);
    $stmt->execute();
    $stmt->close();
    echo "Ubicación del animal actualizada correctamente.<br>";
}

// Función para insertar una nueva especie
function insertarEspecie($conn, $nombre, $descripcion) {
    $stmt = $conn->prepare("CALL InsertarEspecie(?, ?)");
    $stmt->bind_param("ss", $nombre, $descripcion);
    $stmt->execute();
    $stmt->close();
    echo "Especie insertada correctamente.<br>";
}

// Función para obtener un animal
function obtenerAnimal($conn, $animal_id) {
    $stmt = $conn->prepare("CALL ObtenerAnimal(?)");
    $stmt->bind_param("i", $animal_id);
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        echo "Animal: " . json_encode($row) . "<br>";
    }
    $stmt->close();
}

// Función para obtener una especie
function obtenerEspecie($conn, $id_especie) {
    $stmt = $conn->prepare("CALL Obtener_Especie(?)");
    $stmt->bind_param("i", $id_especie);
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        echo "Especie: " . json_encode($row) . "<br>";
    }
    $stmt->close();
}

// Llamadas a las funciones para ejecutar los procedimientos almacenados
actualizarUbicacionAnimal($conn, 1, 'Nueva Ubicación');
insertarEspecie($conn, 'Mamífero', 'Descripción de la especie');
obtenerAnimal($conn, 1);
obtenerEspecie($conn, 1);

$conn->close();
?>
