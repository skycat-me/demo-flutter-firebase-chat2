part of chat;

class LoginBloc {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  /*
    BehaviorSubjectはRxの機能です。
    _user.streamに流れてきた最新のログイン状態を情報を保持しています
   */
  final BehaviorSubject<FirebaseUser> _user = BehaviorSubject<FirebaseUser>();
  final StreamController<void> _doLogin = StreamController<void>();
  final BehaviorSubject<bool> _isSigned = BehaviorSubject<bool>();

  // inputs
  Function(void) get doLogin => _doLogin.sink.add;

  // outputs
  Stream<bool> get isSigned => _isSigned.stream;
  /*
    app.dartではisSignedを監視してtrueになったら
    ホーム画面へ遷移させています。

    > app.dartへ
   */

  Stream<FirebaseUser> get user => _user.stream;

  LoginBloc({
    @required this.auth,
    @required this.googleSignIn,
  }) {
    // コンストラクタでログインチェック処理
    (() async {
      final currentUser = await auth.currentUser();
      /*
        ログイン済みの場合はauthからログインしているユーザーを取得します
       */
      if (currentUser != null) {
        _user.add(currentUser);
        _isSigned.add(true);
      } else {
        _isSigned.add(false);
      }
    })();

    _user.listen((user) {
      // ユーザデータを更新
      /*
        今回のチャットはログイン済みユーザーをusersに保持しています。
        名前、アイコン画像、最終ログイン日時を保持しています。
        (models/user.dart参照)
        ログインに成功して_userにuserが登録されたらFireStoreのusersに
        自分の情報を登録しています。
       */
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
    /*

      Observable.combineLatest：RxDartの機能を使用しています
      複数のStreamをマージします。

     */
    Observable.combineLatest2(_doLogin.stream, _isSigned.where((_) => !_),
        (_c, _d) async {
      GoogleSignInAccount googleUser;
      googleUser = await googleSignIn.signIn();

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      /*
        ※認証が正常に行われずuserが取得できなかった時のハンドリングなどは記述していません
       */
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
