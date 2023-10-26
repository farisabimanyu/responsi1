import 'dart:convert';
import 'dart:io';

import 'package:test_1/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Data Ikan Teman Dory',
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController jenisController = TextEditingController();
  TextEditingController warnaController = TextEditingController();
  TextEditingController habitatController = TextEditingController();
  
  get http => null;


  Future postData(String nama, String jenis, String warna, String habitat) async {
    String url = Platform.isAndroid
        ? 'https://responsi1a.dalhaqq.xyz/ikan'
        : 'https://responsi1a.dalhaqq.xyz/ikan';

    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"nama": "$nama", "jenis": "$jenis", "warna": "$warna, "habitat": "$habitat}';
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

  Future updateData(int id, String nama, String jenis, String warna, String habitat) async {
    final response = await http.put(
      Uri.parse('http://localhost/api_flutter/index.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'id': id, 'nama': nama, 'jenis': jenis, 'warna': warna, 'habitat': habitat}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
