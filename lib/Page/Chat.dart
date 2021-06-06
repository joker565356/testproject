import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testproject/Model/Chat_Model.dart';
import 'package:testproject/Widgets/ColorSet.dart';

// ignore: must_be_immutable
class Chat extends StatefulWidget {
  String name;

  Chat(String name) {
    this.name = name;
  }
  @override
  _ChatState createState() => _ChatState(this.name);
}

class _ChatState extends State<Chat> {
  String name;
  _ChatState(String name) {
    this.name = name;
  }

  @override
  void initState() {
    super.initState();
  }

  var colorset = new ColorSet();
  double screenWidth, screenHeight;
  Query chats = FirebaseFirestore.instance
      .collection('Chat')
      .orderBy('id', descending: true)
      .limit(8);
  // Query chats = FirebaseFirestore.instance.collection('Chat');
  var chat = new TextEditingController();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Stream Cloud Firestore : ${this.name}',
            style: (TextStyle(fontFamily: 'Prompt'))),
        backgroundColor: colorset.blueOne,
      ),
      body: new SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50),
          child: Column(children: [
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: screenWidth * 0.3, maxHeight: 50.0),
                  child: TextField(
                    controller: chat,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      prefixIcon: Icon(Icons.chat),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    double length = 0;
                    await FirebaseFirestore.instance
                        .collection('Chat')
                        .get()
                        .then((QuerySnapshot querySnapshot) => {
                              querySnapshot.docs.forEach((doc) {
                                length++;
                              })
                            });
                    String date = DateTime.now().toIso8601String();
                    var model = ChatModel(length, this.name, chat.text, date);
                    await model.addChat();
                    chat.clear();
                  },
                  style: TextButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(80.0),
                    ),
                    padding: EdgeInsets.all(0.0),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 100.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Sent",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Prompt',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            StreamBuilder<QuerySnapshot>(
                stream: chats.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print('error');
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print('waiting');
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return new Column(
                    children: [
                      SizedBox(height: 15),
                      Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: snapshot.data.docs
                                .map((DocumentSnapshot document) {
                              if (true) {
                                return listUserGuard(document);
                              }
                            }).toList(),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ],
                  );
                })
          ]),
        ),
      ),
    );
  }

  Widget listUserGuard(DocumentSnapshot document) {
    return Container(
      width: screenWidth,
      child: new Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
                width: 1, color: Color.fromARGB(255, 191, 191, 191))),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(
                        width: 1.0,
                        color: Color.fromARGB(255, 191, 191, 191)))),
            child: Icon(Icons.account_circle_sharp,
                color: colorset.blueTwo, size: 40), // Hardcoded to be 'x'
          ),
          title: Wrap(
            spacing: 5,
            children: [
              new Text(
                  '${document.data()['name']} : ${document.data()['text']}',
                  style: (TextStyle(fontFamily: 'Prompt'))),
              SizedBox(height: 25)
            ],
          ),
          subtitle: new Text('${document.data()['time']}',
              style: (TextStyle(fontFamily: 'Prompt'))),
        ),
      ),
    );
  }
}
