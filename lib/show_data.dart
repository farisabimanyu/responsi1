import 'package:flutter/material.dart';
import 'package:test_1/side_menu.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class DetailIkan extends StatefulWidget {
  final dynamic id;
  const DetailIkan({super.key, this.id});

  @override
  State<DetailIkan> createState() => DetailIkanState();
}

class DetailIkanState extends State<DetailIkan> {
  Map<String, dynamic> dataikan = {};
  String url = Platform.isAndroid
      ? 'https://responsi1a.dalhaqq.xyz/ikan'
      : 'https://responsi1a.dalhaqq.xyz/ikan';

  Future<dynamic> getData(dynamic id) async {
    final response = await http.get(Uri.parse("$url/$id"));
    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> data = json.decode(response.body)['data'];
      setState(() {
        dataikan = {"nama": data['nama'], "jenis": data['jenis'], "warna": data['warna'], "habitat": data['habitat']};
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
        title: Text("Detail Data Ikan"),
      ),
      body: Column(
        children: [
          Text("nama : ${dataikan['nama']} "),
          Text("jenis : ${dataikan['jenis']}"),
          Text("warna : ${dataikan['warna']}"), 
          Text("habitat : ${dataikan['habitat']}")
        ],
      ),
    );
  }
}
