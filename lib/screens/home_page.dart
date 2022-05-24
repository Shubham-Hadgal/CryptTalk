import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 20.0),
          child: const Text(
            'CrypTalk',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
        titleSpacing: 1.0,
        backgroundColor: const Color(0xFF793A29),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0, bottom: 10.0),
                child: Center(
                  child: Text(
                    'Encrypt\nYour Confidential And Private Data\nSecurely',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: width/1.3,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: width/1.1,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/aes_encryption');
                      },
                      child: const Text('AES'),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFFFFFF),),
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF746F1D),),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: width/1.1,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/des_encryption');
                      },
                      child: const Text('DES'),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFFFFFF),),
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF666B1B),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}