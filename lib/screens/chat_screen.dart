import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/Db77eWPZkpnfbLYexK9Q/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final document = streamSnapshot.data.docs;
          return ListView.builder(
            itemCount: document.length,
            itemBuilder: (ctx, index) => Container(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  document[index]['text'],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/Db77eWPZkpnfbLYexK9Q/messages')
              .add({'text': 'This was added by clicking the button'});
        },
      ),
    );
  }
}
