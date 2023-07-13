import 'package:flutter/material.dart';
import 'package:suitmedia_mbkm_mobile_test/third_screen_v2.dart';
import 'package:suitmedia_mbkm_mobile_test/first_screen.dart';

class SecondScreen extends StatefulWidget {
  final String inputtedName;
  final String initialUsername;

  SecondScreen({required this.inputtedName, required this.initialUsername});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late String name;
  late String username;

  @override
  void initState() {
    super.initState();
    name = widget.inputtedName;
    username = widget.initialUsername;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body:
      Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25.00, 50.00, 25.00, 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome,'
                    ),
                    Text(
                        name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      username,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThirdScreenV2(inputtedName: name, selectedUsername: username,))
                    );
                  },
                  child: const Text('Choose a User'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FirstScreen()));
                  },
                  child: const Text('Back to First Screen'),
                ),
              ),
            ],
          ),
        )

      ),
    );
  }
}
