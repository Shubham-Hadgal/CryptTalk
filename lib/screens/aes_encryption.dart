import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:encrypt/encrypt.dart' as enc;
import '../enc_dec/aes/aes.dart';

class AesEncryption extends StatefulWidget {
  const AesEncryption({Key? key}) : super(key: key);

  @override
  State<AesEncryption> createState() => _AesEncryptionState();
}

class _AesEncryptionState extends State<AesEncryption> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  String decryptedMsg = '';
  String encryptedMsg = '';

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

    EncryptionDecryption.loadKey();

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
                    if(encryptedMsg.isNotEmpty) {
                      Share.share(encryptedMsg);
                    }
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
                      const Color(0xFF4F4F4F),
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
                    Navigator.pushNamed(context, '/aes_change_key');
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
                      const Color(0xFF4F4F4F),
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
            encryptedMsg =
                EncryptionDecryption.encryptAES(textEditingController1.text);
            _showToast(context, 'Message Encrypted');
            // print(encryptedMsg);
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
              const Color(0xFF4F4F4F),
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
              decryptedMsg = EncryptionDecryption.decryptAES(
                  enc.Encrypted.fromBase64(textEditingController2.text));
            });
            // same key used to encrypt
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
              const Color(0xFF4F4F4F),
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
            child: Text('Enter Plain Text', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
        ),
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 10.0, top: 10.0),
          child: TextField(
            style: TextStyle(
              color: Colors.white
            ),
            cursorHeight: 20,
            autofocus: false,
            controller: textEditingController1,
            decoration: InputDecoration(
              hintText: "Enter text here...",
              hintStyle: TextStyle(color: Colors.white70),
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
                child: Text('Enter Encrypted Text', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
            ),
            SizedBox(height: 8.0),
            TextField(
              cursorHeight: 20,
              style: TextStyle(color: Colors.white),
              autofocus: false,
              controller: textEditingController2,
              decoration: InputDecoration(
                hintText: "Enter text here...",
                hintStyle: TextStyle(color: Colors.white70),
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
        Container(padding: EdgeInsets.only(left: 20.0, top: 20.0),child: const Text('Decrypted Message', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70))),
        SizedBox(height: 10.0),
        Center(
          child: SizedBox(
            height: 100.0,
            width: width/1.07,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.black12,
              ),
              child: Container(padding: EdgeInsets.all(10.0),child: Text(decryptedMsg, style: (TextStyle(fontSize: 16.0, color: Colors.white)))),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Color(0xFF242424),
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: const Text(
            'AES',
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
