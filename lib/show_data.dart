import 'package:flutter/material.dart';
import 'package:test_1/side_menu.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class DetailKontak extends StatefulWidget {
  final dynamic id;
  const DetailKontak({super.key, this.id});

  @override
  State<DetailKontak> createState() => DetailKontakState();
}

class DetailKontakState extends State<DetailKontak> {
  Map<String, dynamic> datakontak = {};
  String url = Platform.isAndroid
      ? 'http://10.0.2.2/Flutter/index.php'
      : 'http://localhost/Flutter/index.php';

  Future<dynamic> getData(dynamic id) async {
    final response = await http.get(Uri.parse("$url?id=$id"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        datakontak = {"nama": data['nama'], "nomor": data['nomor'], "email": data['email']};
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
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Detail Data Kontak"),
      ),
      body: Column(
        children: [
          Text("nama : ${datakontak['nama']} "),
          Text("nomor : ${datakontak['nomor']}"),
          Text("email : ${datakontak['email']}")
        ],
      ),
    );
  }
}
