part of chat;

Widget circularIndicator() {
  return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.amber)));
}
