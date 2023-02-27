import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../routes/routes.dart';
import 'HiveInit.dart';

class FriendRequest extends StatefulWidget {
  final String name;
  final String last_name;
  final String is_active;
  final String friendID;
  final Box friendbox;

  FriendRequest({
    required this.name,
    required this.last_name,
    required this.is_active,
    required this.friendID,
    required this.friendbox,
    Key? key,
  }) : super(key: key);

  @override
  _FriendRequestState createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
    //print(name);
    return Container(
      height: 60,
      width: 316,
      child: Card(
        color: const Color(0xff929AE7),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //Text('Katerina Lioliou\nsent you a friend request'),
          Text(widget.name +
              " " +
              widget.last_name +
              '\nsent you a friend request'),
          SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _addFriend();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1F8A87),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(0),
                      topRight: Radius.circular(0),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                child: const Text('Accept'),
              )),
          SizedBox(
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _removeFriend();
                    /*setState(() {
                                  N_friend_requests = 0;
                                  Navigator.pop(context);
                                });*/
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffA94C52),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                      ),
                    ),
                  ),
                  child: const Text('Decline'),)
                  )
        ]),
      ),
    );
  }

  void _addFriend() {
    // final friend = widget.friendbox.values.firstWhere(
    //   (friend) => friend.friendID == widget.friendID,
    //   orElse: () => null,
    // );
    // print(friend.friendID);
    widget.friendbox.get(widget.friendID).is_active = 'true';
    // friendbox.put(friend.friendID, friend);
  }

  void _removeFriend() {
    // final friend = widget.friendbox.values.firstWhere(
    //   (friend) => friend.friendID == widget.friendID,
    //   orElse: () => null,
    // );
    // print(friend.friendID);
    widget.friendbox.delete(widget.friendID);
  }
}
