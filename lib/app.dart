part of chat;

class MyApp extends StatelessWidget {
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

  Widget _moveFirstPage() {
    return Consumer<LoginBloc>(
      builder: (_, bloc, __) => StreamBuilder<bool>(
        stream: bloc.isSigned,
        initialData: false,
        builder: (context, snapshot) {
          return snapshot.data ? HomePage() : LoginPage();
        },
      ),
    );
  }
}
