import 'package:cryptalk/enc_dec/aes/aes_change_key.dart';
import 'package:cryptalk/enc_dec/des/des_change_key.dart';
import 'package:cryptalk/screens/aes_encryption.dart';
import 'package:cryptalk/screens/des_encryption.dart';
import 'package:cryptalk/screens/home_page.dart';
import 'package:cryptalk/screens/reset_key.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const Home(),
      '/aes_encryption': (context) => const AesEncryption(),
      '/des_encryption': (context) => const DesEncryption(),
      '/reset_key': (context) => const ResetKey(),

      '/aes_change_key': (context) => const AesChangeKey(),
      '/des_change_key': (context) => const DesChangeKey(),
    },
  ));
}