import 'dart:convert';

import 'package:cryptalk/enc_dec/des/des.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:encrypt/encrypt.dart' as enc;
import '../enc_dec/aes/aes.dart';

class DesEncryption extends StatefulWidget {
  const DesEncryption({Key? key}) : super(key: key);

  @override
  State<DesEncryption> createState() => _DesEncryptionState();
}

class _DesEncryptionState extends State<DesEncryption> {

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  String decryptedMsg = '';
  String encryptedMsg = '';

  static late List<int> _encrypted;
  static late List<int> _decrypted;

  void _showToast(BuildContext context, String s) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(s),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    DesEncryptionDecryption.loadKey();

    Widget extraButtons = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20.0, right: 10.0),
              child: SizedBox(
                height: 40,
                width: width / 2.5,
                child: TextButton.icon(
                  onPressed: () {
                    Share.share(encryptedMsg);
                  },
                  icon: Icon(Icons.share_outlined),
                  label: Text(
                    'Share',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFFFFFFF),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF767676),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20.0, left: 10.0),
              child: SizedBox(
                height: 40,
                width: width / 2.5,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/des_change_key');
                  },
                  icon: Icon(Icons.vpn_key_outlined),
                  label: Text(
                    'Change Key',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFFFFFFFF),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF767676),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
    Widget encryptButton = Container(
      padding: EdgeInsets.only(top: 20.0, left: 10.0),
      child: SizedBox(
        height: 40,
        width: width / 2.5,
        child: TextButton.icon(
          onPressed: () {
            _encrypted = DesEncryptionDecryption.encryptDes(textEditingController1.text);
            encryptedMsg = base64.encode(_encrypted);
            _showToast(context, 'Message Encrypted');
            print(encryptedMsg);
          },
          icon: Icon(Icons.lock_outline_rounded),
          label: Text(
            'Encrypt',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFFFFFFFF),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF767676),
            ),
          ),
        ),
      ),
    );
    Widget decryptButton = Container(
      padding: EdgeInsets.only(top: 20.0, left: 10.0),
      child: SizedBox(
        height: 40,
        width: width / 2.5,
        child: TextButton.icon(
          onPressed: () {
            setState(() {
              _decrypted = DesEncryptionDecryption.decryptDes(_encrypted);
              decryptedMsg = utf8.decode(_decrypted);
            });
            print(decryptedMsg);
          },
          icon: Icon(Icons.lock_open_rounded),
          label: Text(
            'Decrypt',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFFFFFFFF),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF767676),
            ),
          ),
        ),
      ),
    );
    Widget enterPlainTextUI = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text('Enter Plain Text', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 10.0, top: 10.0),
          child: TextField(
            cursorHeight: 20,
            autofocus: false,
            controller: textEditingController1,
            decoration: InputDecoration(
              hintText: "Enter plain text",
              contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 0.0,
                borderRadius: BorderRadius.circular(15),
                borderSide:
                BorderSide(color: Colors.blueAccent, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
    Widget enterEncryptedTextUI = Padding(
        padding: const EdgeInsets.only(top: 30.0, right: 8.0, left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('Enter Encrypted Text', style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(height: 8.0),
            TextField(
              cursorHeight: 20,
              autofocus: false,
              controller: textEditingController2,
              decoration: InputDecoration(
                hintText: "Enter here...",
                contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0.0,
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
                ),
              ),
            ),
          ],
        ));
    Widget outputTextUI = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(padding: EdgeInsets.only(left: 20.0, bottom: 10.0, top: 20.0),child: const Text('Decrypted Message', style: TextStyle(fontWeight: FontWeight.bold))),
        Center(
          child: SizedBox(
            height: 100.0,
            width: width/1.07,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.black12,
              ),
              child: Container(padding: EdgeInsets.all(10.0),child: Text(decryptedMsg, style: (TextStyle(fontSize: 16.0)))),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: const Text(
            'DES',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
        titleSpacing: 1.0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                enterPlainTextUI,
                encryptButton,
                enterEncryptedTextUI,
                decryptButton,
                outputTextUI,
                extraButtons,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
