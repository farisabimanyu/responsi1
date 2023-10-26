// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:test_1/list_data.dart';
import 'package:test_1/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final dynamic id;
  const EditData({Key? key, required this.id}) : super(key: key);

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final namaController = TextEditingController();
  final jenisController = TextEditingController();
  final warnaController = TextEditingController();
  final habitatController = TextEditingController();

  String url = Platform.isAndroid
      ? 'https://responsi1a.dalhaqq.xyz/ikan'
      : 'https://responsi1a.dalhaqq.xyz/ikan';
      

  Future<dynamic> updateData(String id, String nama, String jenis, String warna, String habitat) async {
    // print("updating");
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"id":$id,"nama": "$nama", "jenis": "$jenis", "warna": "$warna",  "habitat": "$habitat"}';
    var response = await http.put(Uri.parse("$url/$id"),
        headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }

  Future<dynamic> getData(dynamic id) async {
    final response = await http.get(Uri.parse("$url/$id"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['data'];
      setState(() {
        namaController.text = data['nama'];
        jenisController.text = data['jenis'];
        warnaController.text = data['warna'];
        habitatController.text = data['habitat'];
      });
    } else {
      return null;
    }
  }

  @override
  void initState() {
    getData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Ikan'),
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
              child: const Text('Edit Ikan'),
              onPressed: () {
                String nama = namaController.text;
                String jenis = jenisController.text;
                String warna = warnaController.text;
                String habitat = habitatController.text;
                // updateData(widget.id,nama, jenis, warna, habitat);

                updateData(widget.id, nama, jenis, warna, habitat).then((result) {
                  print(result);
                  if (result['status'] == true) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Data berhasil di ubah'),
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
