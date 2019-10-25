part of chat;

class ChatBloc {
  final FirebaseUser user;

  // outputs
  final Stream<List<Message>> messages;

  final BehaviorSubject<String> _postMessage = BehaviorSubject<String>();

  // input
  Function(String) get postMessage => _postMessage.sink.add;

  ChatBloc(this.user)
      : messages = Firestore.instance
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .map((snapshot) => snapshot.documents
                .map((doc) => Message.fromDocumentSnapshot(doc))
                .toList()) {
    _postMessage.listen((text) async {
      await Firestore.instance.collection('messages').add({
        'uid': user.uid,
        'message': text,
        'name': user.displayName,
        'timestamp': DateTime.now().millisecondsSinceEpoch
      });
    });
  }

  void dispose() {
    _postMessage.close();
  }
}
