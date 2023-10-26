import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:test_1/side_menu.dart';
import 'package:test_1/tambah_data.dart';
import 'package:test_1/edit_data.dart';
import 'package:test_1/show_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Map<String, String>> daftartemanDory = [];
  String url = Platform.isAndroid
      ? 'https://responsi1a.dalhaqq.xyz/ikan'
      : 'https://responsi1a.dalhaqq.xyz/ikan';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        daftartemanDory = List<Map<String, String>>.from(data.map((item) {
          return {
            'nama': item['nama'] as String,
            'jenis': item['jenis'] as String,
            'warna': item['warna'] as String,
            'habitat': item['habitat'] as String,
            'id': item['id'] as String,
          };
        }));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future deleteData(int id) async {
    final response = await http.delete(Uri.parse('$url/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Ikan Teman Dory'),
      ),
      drawer: const SideMenu(),
      body: Column(children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TambahData(),
              ),
            );
          },
          child: const Text('Tambah Teman'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: daftartemanDory.length,
            itemBuilder: (context, index) {
              var id = daftartemanDory[index]['id'];
              return ListTile(
                title: Text(daftartemanDory[index]['nama']!),
                subtitle: Text('jenis: ${daftartemanDory[index]['jenis']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailIkan(id: daftartemanDory[index]['id'])));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditData(
                                  id: daftartemanDory[index]['id'],
                                )));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteData(int.parse(id!)).then((result) {
                          if (result['status'] == true) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Data berhasil di hapus'),
                                    content: const Text('ok'),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListData(),
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
              );
            },
          ),
        )
      ]),
    );
  }
}
