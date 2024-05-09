import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyChatBot extends StatefulWidget {
  const MyChatBot({super.key});

  @override
  State<MyChatBot> createState() => _MyChatBotState();
}

class _MyChatBotState extends State<MyChatBot> {
  //first chatuser
  ChatUser myself = ChatUser(id: '1', firstName: 'Vishal');
  //second chatuser madamm ji name is just for fun
  ChatUser Madamji = ChatUser(id: '1,', firstName: 'Madamji');
  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];
  final ourUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyB0NwNiQ9ydnSzmuMRDWWmhyPVF18RzvoI';
  final header = {'Content-Type': ' application/json'};
  getdata(ChatMessage m) async {
    typing.add(Madamji);
    allMessages.insert(0, m);
    setState(() {});
    //this is become we could not get the extra data we only want to see text
    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };
    await http
        .post(Uri.parse(ourUrl),
        headers: header,
        //jsson encode and jsson decode are used to decode the data
        body: jsonEncode(data))
        .then((value) {
      //statuscode is 200 from the server then we get the data
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        //there we use print satae for the print want we want to say
        print(result['candidates'][0]['content']['parts'][0]['text']);
        //this is for the second chatuser
        ChatMessage m1 = ChatMessage(
            text: result['candidates'][0]['content']['parts'][0]['text'],
            user: Madamji,
            createdAt: DateTime.now());
        allMessages.insert(0, m1);
      } else {
        print('error happens');
      }
    }).catchError((e) {});
    typing.remove(Madamji);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Hey I am your ChatBot,',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.blue,
        //body we have to create a user and a secondary user who gives us reply on the behave of ai bot
        body: DashChat(
            typingUsers: typing,
            currentUser: myself,
            onSend: (ChatMessage m) {
              getdata(m);
            },
            messages: allMessages));
  }
}
