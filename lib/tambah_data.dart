import 'dart:convert';
import 'dart:io';
import 'package:test_1/list_data.dart';
import 'package:test_1/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  const TambahData({Key? key}) : super(key: key);

  @override
  _TambahDataState createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final namaController = TextEditingController();
  final jenisController = TextEditingController();
  final warnaController = TextEditingController();
  final habitatController = TextEditingController();

  Future postData(String nama, String jenis, String warna, String habitat) async {
    // print(nama);
    String url = Platform.isAndroid
        ? 'https://responsi1a.dalhaqq.xyz/ikan'
        : 'https://responsi1a.dalhaqq.xyz/ikan';

    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"nama": "$nama", "jenis": "$jenis", "warna": "$warna", "habitat": "$habitat"}';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Ikan'),
      ),
      drawer: const SideMenu(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                hintText: 'Nama Ikan',
              ),
            ),
            TextField(
              controller: jenisController,
              decoration: const InputDecoration(
                hintText: 'Jenis Ikan',
              ),
            ),
            TextField(
              controller: warnaController,
              decoration: const InputDecoration(
                hintText: 'Warna Ikan',
              ),
            ),
            TextField(
              controller: habitatController,
              decoration: const InputDecoration(
                hintText: 'Habitat Ikan',
              ),
            ),
            ElevatedButton(
              child: const Text('Tambah Ikan'),
              onPressed: () {
                String nama = namaController.text;
                String jenis = jenisController.text;
                String warna = warnaController.text;
                String habitat = habitatController.text;
                // print(nama);
                postData(nama, jenis, warna, habitat).then((result) {
                  //print(result['pesan']);
                  if (result['status'] == true) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          //var namauser2 = namauser;
                          return AlertDialog(
                            title: const Text('Data berhasil di tambah'),
                            content: const Text('ok'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ListData(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        });
                  }
                  setState(() {});
                });
              },
            ),
          ],
        ),

        //     ],
        //   ),
        // ),
      ),
    );
  }
}
