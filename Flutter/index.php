<?php
include('koneksi.php');
$method = $_SERVER["REQUEST_METHOD"];

if ($method === "GET") {
    if (isset($_GET['id'])) {
        $id = $_GET['id'];
        $sql = "SELECT * FROM kontak WHERE id = $id";
        
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            $kontak = $result->fetch_assoc();
            echo json_encode($kontak);
        } else {
            echo "Data kontak dengan ID $id tidak ditemukan.";
        }
    } 
    else {
        $sql = "SELECT * FROM kontak";
        $result = $conn->query($sql);
        
        if ($result->num_rows > 0) {
            $kontak = array();
            while ($row = $result->fetch_assoc()) {
                $kontak[] = $row;
            }
            echo json_encode($kontak);
        } else {
            echo "Data kontak kosong.";
        }
    }
}


if ($method === "POST") {
    // Menambahkan data kontak
   $data = json_decode(file_get_contents("php://input"), true);
   $nama = $data["nama"];
   $nomor = $data["nomor"];
   $email = $data["email"];
   $sql = "INSERT INTO kontak (nama, nomor, email) VALUES ('$nama', '$nomor', '$email')";
   if ($conn->query($sql) === TRUE) {
   $data['pesan'] = 'berhasil';
   //echo "Berhasil tambah data";
   } else {
   $data['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
   }
   echo json_encode($data);
   } 

   if ($method === "PUT") {
    // Memperbarui data kontak
        $data = json_decode(file_get_contents("php://input"), true);
        $id = $data["id"];
        $nama = $data["nama"];
        $nomor = $data["nomor"];
        $email = $data["email"];
        $sql = "UPDATE kontak SET nama='$nama', nomor='$nomor', email='$email' WHERE id=$id";
        if ($conn->query($sql) === TRUE) {
            $data['pesan'] = 'berhasil';
        } else {
         $data['pesan'] =  "Error: " . $sql . "<br>" . $conn->error;
        }
        echo json_encode($data);
   } 

   if ($method === "DELETE") {
    // Menghapus data kontak
   $id = $_GET["id"];
   $sql = "DELETE FROM kontak WHERE id=$id";
   if ($conn->query($sql) === TRUE) {
   $data['pesan'] = 'berhasil';
   } else {
   $data['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
   }
   echo json_encode($data);
   }
   $conn->close();
?>