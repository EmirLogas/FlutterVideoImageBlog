import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoResim extends StatelessWidget {
  const VideoResim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ButonEkrani(),
    );
  }
}

class ButonEkrani extends StatefulWidget {
  const ButonEkrani({Key? key}) : super(key: key);

  @override
  _ButonEkraniState createState() => _ButonEkraniState();
}

class _ButonEkraniState extends State<ButonEkrani> {
  late File yuklenecekDosya;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? indirmeBaglantisi;

  kameradanVideoYukle() async {
    var alinanDosya = await ImagePicker().pickVideo(source: ImageSource.camera);
    setState(() {
      yuklenecekDosya = File(alinanDosya!.path);
    });

    Reference referansYol =
        FirebaseStorage.instance.ref().child("videolar").child("video.mp4");

    UploadTask yuklemeGorevi = referansYol.putFile(yuklenecekDosya);
    String imageUrl = await (await yuklemeGorevi).ref.getDownloadURL();
    setState(() {
      indirmeBaglantisi = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: kameradanVideoYukle, child: Text("Video Yükle"))
        ],
      ),
    );
  }
}
