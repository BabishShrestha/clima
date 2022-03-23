import 'package:clima/screens/LoadingScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Clima());
}

class Clima extends StatelessWidget {
  const Clima({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Clima"),
          leading: Image(
            image: AssetImage("assets/clima.png"),
          ),
        ),
        body: SafeArea(child: LoadingScreen()),
      ),
    );
  }
}
