import 'package:flutter/material.dart';

class FriendMessage extends StatefulWidget {
  // final Box friendbox;
  final String name;
  final String last_name;
  final String is_active;
  FriendMessage({
    Key? key,
    // required this.friendbox,
    required this.name,
    required this.last_name,
    required this.is_active,
  }) : super(key: key);

  @override
  _FriendMessageState createState() => _FriendMessageState();
}

class _FriendMessageState extends State<FriendMessage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double iconHeight = 22;
    double iconRoomHeight = 15;
    return Card(
      key: ValueKey("fname"),
      margin: const EdgeInsets.all(10),
      child: ListTile(
        tileColor: const Color(0xff929AE7),
        //leading: Text(Friends[index]["icon_symbol"]),
        leading: CircleAvatar(
          child: Text("S"),
          backgroundColor: Color(0xffE6F4F1),
        ),
        title: Text(widget.name + " " + widget.last_name),
        //subtitle: Text(Friends[index]["icon_symbol"]),
      ),
    );
  }
}
