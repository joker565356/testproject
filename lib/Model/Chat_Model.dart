import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  double chatId;
  String chatName;
  String chatText;
  String chatTime;

  ChatModel(double chatId, String chatName, String chatText, String chatTime) {
    this.chatId = chatId;
    this.chatName = chatName;
    this.chatText = chatText;
    this.chatTime = chatTime;
  }

  CollectionReference chat = FirebaseFirestore.instance.collection('Chat');
  Future<void> addChat() async {
    chat
        .add({
          'id': this.chatId,
          'name': this.chatName,
          'text': this.chatText,
          'time': this.chatTime,
        })
        .then((value) => print("Chat Added"))
        .catchError((error) => print("Failed to add Chat: $error"));
  }
  // Future<void> updateCondo() async {
  //   condo.doc(this.docId).update({
  //     'con_name' : this.condoName,
  //     'con_promptpay' : this.condoPromptpay,
  //     'con_rate': this.condoRate,
  //   })
  //   .then((value) => print("Condo Updated"))
  //   .catchError((error) => print("Failed to update Condo: $error"));
  // }
  // Future<void> deleteCondo() async {
  //   condo.doc(this.docId).delete()
  //   .then((value) => print("User Deleted"))
  //   .catchError((error) => print("Failed to delete Condo: $error"));
  // }
}
