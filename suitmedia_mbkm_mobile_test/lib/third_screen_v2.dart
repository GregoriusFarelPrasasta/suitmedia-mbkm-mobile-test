import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia_mbkm_mobile_test/UserModel.dart';
import 'package:suitmedia_mbkm_mobile_test/second_screen.dart';
import 'package:http/http.dart' as http;

class ThirdScreenV2 extends StatefulWidget {
  final String inputtedName;
  final String selectedUsername;

  ThirdScreenV2({required this.inputtedName, required this.selectedUsername});

  @override
  _ThirdScreenV2State createState() => _ThirdScreenV2State();
}

class _ThirdScreenV2State extends State<ThirdScreenV2> {
  final controller = ScrollController();
  List<User> users = [];
  int _pageNumber=1;
  bool hasMore = true;
  bool isLoading = false;

  late String name;
  late String username;

  @override
  void initState() {
    super.initState();

    name = widget.inputtedName;
    username = widget.selectedUsername;

    fetchUsers();

    controller.addListener(() {
      if(controller.position.maxScrollExtent == controller.offset) {
        fetchUsers();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      _pageNumber = 0;
      users.clear();
    });

    fetchUsers();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Third Screen")),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.all(8),
            itemCount: users.length + 1,
            itemBuilder: (context, index) {
              if (index < users.length) {
                final iteratedUser = users[index];
                return Card(
                  child: Row(
                    children: [
                      Image.network(
                        iteratedUser.avatar,
                        fit: BoxFit.fitWidth,
                        width: 20,
                        height: 20,
                      ),
                      Expanded( // Wrap ListTile with Expanded
                        child: ListTile(
                          title: Text(
                            iteratedUser.first_name + " " + iteratedUser.last_name,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                iteratedUser.email,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          username = iteratedUser.first_name + ' ' + iteratedUser.last_name;
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SecondScreen(inputtedName: name, initialUsername: username,))
                          );
                        },
                        child: const Text('Pick User'),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: hasMore ? CircularProgressIndicator()
                      : Text('All users have been loaded')
                  ),
                );
              }
            }
        ),
      )
    );
  }

  Future fetchUsers() async {
    if (isLoading) return;
    isLoading = true;
      const per_page = 10;
      final response = await http.get(
          Uri.parse(
              'https://reqres.in/api/users?page=$_pageNumber&per_page=$per_page')
      );
      if (response.statusCode == 200) {
        final List<dynamic> newUsers = json.decode(response.body)['data'];
        print (newUsers);
        setState(() {
          _pageNumber++;
          isLoading = false;

          if (newUsers.length < per_page) {
            hasMore = false;
          }

          users.addAll((newUsers.map((e) => User.fromJson(e)).toList()));
        });
    }
  }
}