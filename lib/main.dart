import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:typed_data';

void main() {
  runApp(FileTransferApp());
}

class FileTransferApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FileTransferScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FileTransferScreen extends StatefulWidget {
  @override
  _FileTransferScreenState createState() => _FileTransferScreenState();
}

class _FileTransferScreenState extends State<FileTransferScreen> {
  RTCPeerConnection? peerConnection;
  RTCDataChannel? dataChannel;
  String qrData = "Initializing...";
  
  @override
  void initState() {
    super.initState();
    _initializeConnection();
  }

  Future<void> _initializeConnection() async {
    Map<String, dynamic> config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'}
      ]
    };

    peerConnection = await createPeerConnection(config);

    RTCDataChannelInit dataChannelInit = RTCDataChannelInit();
    dataChannel = await peerConnection!.createDataChannel("fileChannel", dataChannelInit);

    dataChannel!.onMessage = (RTCDataChannelMessage message) {
      print("📂 Received File Data: ${message.text}");
    };

    setState(() {
      qrData = "webrtc://${peerConnection.hashCode}";
    });
  }

  Future<void> sendFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    
    if (result != null) {
      Uint8List? fileData = result.files.single.bytes;
      if (fileData != null) {
        dataChannel?.send(RTCDataChannelMessage.fromBinary(fileData));
        print("📤 File Sent Successfully!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Offline File Transfer")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrData,
              size: 200,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendFile,
              child: Text("📤 Send File"),
            ),
          ],
        ),
      ),
    );
  }
}
