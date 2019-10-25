part of chat;

class Message extends DocBase {
  final String uid;
  final String name;
  final int timestamp;
  final String message;

  Message.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.data['uid'],
        name = snapshot.data['name'],
        timestamp = snapshot.data['timestamp'],
        message = snapshot.data['message'],
        super(snapshot);
}
