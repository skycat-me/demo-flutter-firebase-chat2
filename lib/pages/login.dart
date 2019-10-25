part of chat;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ようこそChatへ!'),
      ),
      body: Consumer<LoginBloc>(
        builder: (_, bloc, __) => StreamBuilder<Object>(
          stream: bloc.isSigned,
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.data) {
              _gotoHome(context);
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        bloc.doLogin(null);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _gotoHome(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (_) => false,
      );
    });
  }
}
