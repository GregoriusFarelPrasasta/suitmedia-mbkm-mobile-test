import 'package:flutter/material.dart';
import 'package:suitmedia_mbkm_mobile_test/second_screen.dart';
import 'PalindromeFunction.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Screen',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.blueGrey
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('First Screen'),
        ),
        body: const FirstScreenForm(),
      ),
    );
  }
}

//Form Widget
class FirstScreenForm extends StatefulWidget {
  const FirstScreenForm({super.key});

  @override
  FirstScreenFormState createState() {
    return FirstScreenFormState();
  }
}

//Form State
class FirstScreenFormState extends State<FirstScreenForm> {
  final _formKey = GlobalKey<FormState>();
  late String palindrome;
  late String name;

  @override
  Widget build(BuildContext context) {
    return Center(child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            child: TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill out this field';
                }
                name = value;
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            width: 300,
            child: TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill out this field';
                }
                palindrome = value;
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Palindrome',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context, barrierDismissible: false,

                      builder: (BuildContext context) {
                        if (isPalindrome(palindrome)) {
                          return new AlertDialog(
                            title: new Text('Check Palindrome Result'),
                            content: new SingleChildScrollView(
                              child: new ListBody(
                                children: [
                                  new Text('isPalindrome'),
                                ],
                              ),
                            ),
                            actions: [
                              new ElevatedButton(
                                child: new Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );

                        } else {
                          return new AlertDialog(
                            title: new Text('Check Palindrome Result'),
                            content: new SingleChildScrollView(
                              child: new ListBody(
                                children: [
                                  new Text('not palindrome'),
                                ],
                              ),
                            ),
                            actions: [
                              new ElevatedButton(
                                child: new Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }

                      },
                    );
                  }
                },
                child: const Text('Check'),
              ),
            )


          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondScreen(inputtedName: name, initialUsername: 'Selected Username',))
                    );
                  }
                },
                child: const Text('Next'),
              ),
            )
          ),
        ],
      ),
    ));
  }
}

