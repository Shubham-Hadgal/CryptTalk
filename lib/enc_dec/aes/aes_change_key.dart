import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Keys {
  static String _key = '';

  static String getKey() {
    _AesChangeKeyState()._read();
    return _key;
  }

  static setKey(String key) {
    _AesChangeKeyState()._save(key);
  }
}

class AesChangeKey extends StatefulWidget {
  const AesChangeKey({Key? key}) : super(key: key);

  @override
  State<AesChangeKey> createState() => _AesChangeKeyState();
}

class _AesChangeKeyState extends State<AesChangeKey> {
  TextEditingController textEditingController1 = TextEditingController();
  int charLength = 0;

  _onChanged(String value) {
    setState(() {
      charLength = value.length;
    });
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'aesKey';
    final value = prefs.getString(key) ?? 'Please set the Key';
    Keys._key = value;
  }

  _save(String secretKey) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'aesKey';
    final value = secretKey;
    prefs.setString(key, value);
    Keys._key = value;
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Enter the valid key of size 16, 24, or 32'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget getKeyTextField = Padding(
        padding: const EdgeInsets.only(top: 30.0, right: 8.0, left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Enter the key',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70))),
                Spacer(),
                Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text('$charLength',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold))),
              ],
            ),
            SizedBox(height: 8.0),
            TextField(
              cursorHeight: 20,
              autofocus: false,
              style: TextStyle(color: Colors.white),
              controller: textEditingController1,
              onChanged: _onChanged,
              decoration: InputDecoration(
                hintText: "Must be in length of 16, 24, 32 characters..",
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
    Widget saveButton = Container(
      padding: EdgeInsets.only(top: 20.0, left: 10.0),
      child: SizedBox(
        height: 40,
        width: width / 2.5,
        child: TextButton.icon(
          onPressed: () async {
            if (textEditingController1.text.length == 16 ||
                textEditingController1.text.length == 24 ||
                textEditingController1.text.length == 32) {
              print(Keys._key);
              await _save(textEditingController1.text);
              setState(() {});
              print('globally: $Keys._key');
            } else {
              _showToast(context);
            }
          },
          icon: Icon(Icons.save_outlined),
          label: Text(
            'Save',
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
    Widget displayKey = Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text('Your Current Key :',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: Keys._key));
                  },
                  icon: Icon(Icons.copy_rounded, size: 24.0, color: Colors.white70,)),
            ],
          ),
          SizedBox(
            height: 70,
            width: width / 0.7,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF414141),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Keys._key, style: TextStyle(fontSize: 18.0, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFF242424),
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: const Text(
            'Change Key',
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
                getKeyTextField,
                saveButton,
                displayKey,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
