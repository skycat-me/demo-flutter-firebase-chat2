part of chat;

class User extends DocBase {
  final String name;
  final String photoURL;
  final int lastLogin;

  User.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data['name'],
        photoURL = snapshot.data['photoURL'],
        lastLogin = snapshot.data['lastLogin'],
        super(snapshot);
}
