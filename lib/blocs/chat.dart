part of chat;

class ChatBloc {
  final FirebaseUser user;

  // outputs
  /*
    messagesのStreamでFireStoreからリアルタイムに流れてくる
    メッセージのsnapshotを監視します。
    Message.fromDocumentSnapshotは流れてくるデータを整形しています。
    model > message.dart で詳細を確認できます。

    今はメッセージの削除機能などがないため問題ありませんが
    Streamにはaddやdelete,updateなどいろんなイベントが流れてくるので
    イベントのタイプも監視し処理を分岐する必要があります。

    _postMessageはメッセージの投稿を行います。
    FiresStoreのデータの登録はset,addやupdateなどいくつかのメソッドを
    使い分けで新規登録、編集機能などを作成します
   */
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
