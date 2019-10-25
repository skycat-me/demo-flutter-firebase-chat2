part of chat;

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listScrollController = new ScrollController();
    final user = Provider.of<FirebaseUser>(context);

    return Provider<ChatBloc>(
      builder: (_) => ChatBloc(user),
      child: Consumer<ChatBloc>(
          builder: (_, bloc, __) => StreamBuilder<List<Message>>(
                stream: bloc.messages,
                initialData: null,
                builder: (context, messages) {
                  if (!messages.hasData) {
                    return circularIndicator();
                  }
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: messages.data.length,
                          itemBuilder: (context, index) {
                            return _messageListItem(messages.data[index], user);
                          },
                          controller: listScrollController,
                          reverse: true,
                        ),
                      ),
                      _inputForm(chatBloc: bloc)
                    ],
                  );
                },
              )),
    );
  }

  // メッセージ毎のWidget
  Widget _messageListItem(
    Message message,
    FirebaseUser user,
  ) {
    final widgets = [
      Container(
        constraints: const BoxConstraints(maxWidth: 50),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              child: Icon(
                Icons.person,
              ),
            ),
            Text(
              message.name,
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message.message,
          ),
        ),
      ),
    ];
    var mainAxisAlignment = MainAxisAlignment.start;
    if (message.uid == user.uid) {
      mainAxisAlignment = MainAxisAlignment.end;
      widgets.removeAt(0);
    }
    return ListTile(
      title: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Text(
                timestampToString(timestamp: message.timestamp),
                style: TextStyle(fontSize: 13),
              ))
        ],
      ),
    );
  }

  // 入力フォーム
  Widget _inputForm({@required ChatBloc chatBloc}) {
    final textController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 350,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Scrollbar(
                child: TextField(
                  controller: textController,
                  style: new TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  minLines: 1,
                ),
              ),
            ),
            FlatButton.icon(
              onPressed: textController.text != null
                  ? () {
                      chatBloc.postMessage(textController.text);
                      textController.clear();
                    }
                  : null,
              icon: Icon(
                Icons.send,
                color: Colors.green,
              ),
              label: const Text('送信'),
            )
          ],
        ),
      ),
    );
  }
}
