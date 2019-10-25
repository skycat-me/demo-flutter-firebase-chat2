part of chat;

class DocBase {
  final String documentId;

  @mustCallSuper
  DocBase(DocumentSnapshot snapshot) : documentId = snapshot.documentID;
}
