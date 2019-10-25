part of chat;

class LoginBloc {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  final BehaviorSubject<FirebaseUser> _user = BehaviorSubject<FirebaseUser>();
  final StreamController<void> _doLogin = StreamController<void>();
  final BehaviorSubject<bool> _isSigned = BehaviorSubject<bool>();

  // inputs
  Function(void) get doLogin => _doLogin.sink.add;

  // outputs
  Stream<bool> get isSigned => _isSigned.stream;
  Stream<FirebaseUser> get user => _user.stream;

  LoginBloc({
    @required this.auth,
    @required this.googleSignIn,
  }) {
    // コンストラクタでログインチェック処理
    (() async {
      final currentUser = await auth.currentUser();
      if (currentUser != null) {
        _user.add(currentUser);
        _isSigned.add(true);
      } else {
        _isSigned.add(false);
      }
    })();

    _user.listen((user) {
      // ユーザデータを更新
      final docRef = Firestore.instance.collection('users').document(user.uid);
      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          docRef,
          {
            'name': user.displayName,
            'photoURL': user.photoUrl,
            'lastLogin': DateTime.now().millisecondsSinceEpoch
          },
        );
      });
    });

    // _doLogin と falseな_isSigned が 流れてきたらログインリクエストを出す
    Observable.combineLatest2(_doLogin.stream, _isSigned.where((_) => !_),
        (_c, _d) async {
      GoogleSignInAccount googleUser;
      googleUser = await googleSignIn.signIn();

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final authResult = await auth.signInWithCredential(credential);
      _user.add(authResult.user);
      _isSigned.add(true);
    }).listen(null);
  }

  void dispose() {
    _user.close();
    _isSigned.close();
    _doLogin.close();
  }
}
