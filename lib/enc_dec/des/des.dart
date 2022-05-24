import 'dart:convert';
import 'package:dart_des/dart_des.dart';
import 'des_change_key.dart';

class DesEncryptionDecryption {

  static String _secretKey = '';

  static late List<int> _encrypted;
  static late List<int> _decrypted;
  static final List<int> _iv = [1, 2, 3, 4, 5, 6, 7, 8];
  static final DES3 _des3CBC = DES3(key: _secretKey.codeUnits, mode: DESMode.CBC, iv: _iv);

  // static String encrypted = '';
  // static String decrypted = '';

  static loadKey() {
    print(_secretKey);
    _secretKey = DesKeys.getKey();
    print(_secretKey);
  }

  static encryptDes(String plainText) {
    return _encrypted = _des3CBC.encrypt(plainText.codeUnits);
    return base64.encode(_encrypted);
  }

  static decryptDes(List<int> _encrypted) {
    return _decrypted = _des3CBC.decrypt(_encrypted);
    return utf8.decode(_decrypted);
  }

}