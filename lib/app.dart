part of chat;

/*
  最初に呼ばれるメインのウィジェット
 */
class MyApp extends StatelessWidget {
  // 今回はFirebase AuthのGoogle認証を使用する。
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider<LoginBloc>(
        builder: (_) => LoginBloc(
          auth: _auth,
          googleSignIn: _googleSignIn,
        ),
        dispose: (_, bloc) => bloc.dispose(),
        child: _moveFirstPage(),
      ),
    );
  }

  /*
    画面・ウィジェットを跨ぐように状態を管理しなければならない場合は
    Blocパターンを使用します。（今回は認証情報・状態を管理します）
    今年のGoogle I/OよりProviderを推奨するとGoogleより
    発表があったのでこちらを使用していきます。

    > blocs/login.dart へ
   */

  Widget _moveFirstPage() {
    return Consumer<LoginBloc>(
      builder: (_, bloc, __) => StreamBuilder<bool>(
        stream: bloc.isSigned,
        initialData: false,
        builder: (context, snapshot) {
          /*
            Login BlocのisSignedの状態に応じて遷移先のページを振り分けます。
            ここまでがログインの一連の流れです。
            ではチャット画面の処理にうつりましょう

           */
          return snapshot.data ? HomePage() : LoginPage();
        },
      ),
    );
  }
}
