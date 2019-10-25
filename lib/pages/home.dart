part of chat;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHATだよ！'),
        centerTitle: true,
      ),
      body: StreamBuilder<FirebaseUser>(
          stream: Provider.of<LoginBloc>(context).user,
          builder: (context, user) {
            if (!user.hasData) {
              return circularIndicator();
            }
            return Provider<FirebaseUser>.value(
              value: user.data,
              child: Container(
                child: Stack(
                  // TODO: ユーザ一覧ページを追加するならoffstageで出し分けしたい
                  children: <Widget>[ChatPage()],
                ),
              ),
            );
          }),
    );
  }
}
