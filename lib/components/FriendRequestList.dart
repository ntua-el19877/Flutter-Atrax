import 'package:atrax/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'FriendMessage.dart';
import 'FriendRequest.dart';
import 'HiveInit.dart';
import 'TaskMessage.dart';

class FriendRequestsList extends StatefulWidget {
  // final Color color_Secondary;
  final Box friendbox;
  FriendRequestsList({
    // required this.color_Secondary,
    required this.friendbox,
  });

  @override
  _FriendRequestsListState createState() => _FriendRequestsListState();
}

class _FriendRequestsListState extends State<FriendRequestsList> {
  @override
  Widget build(BuildContext context) {
    // Color _color_TaskMessage = widget.color_Secondary;
    List<FriendRequest> friendList = List.generate(
        widget.friendbox.length,
        (index) => FriendRequest(
            friendbox: widget.friendbox,
            friendID: widget.friendbox.getAt(index).friendID,
            is_active: widget.friendbox.getAt(index).is_active,
            last_name: widget.friendbox.getAt(index).last_name,
            name: widget.friendbox.getAt(index).name));
// Sort the taskMessages list based on date and time
     friendList =
        friendList.where((friend) => friend.is_active == 'false').toList();

    friendList.sort((a, b) {
      // Compare the dates first
      int nameComparison = a.name.compareTo(b.name);
      if (nameComparison != 0) {
        return nameComparison;
      }

      // If the dates are the same, compare the times
      return a.last_name.compareTo(b.last_name);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //const SizedBox(height: 20),
        ...friendList.map((friendList) => Padding(
              padding: const EdgeInsets.all(10),
              child: friendList,
            )),
      ],
      //     ),
      //   ),
    );
  }

  @override
  void didUpdateWidget(FriendRequestsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.friendbox.length != oldWidget.friendbox.length) {
      setState(() {});
    }
  }
}
