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
  var friendlist = [];
  var friendKeys = [];
  @override
  void initState() {
    super.initState();
    // print(formatted);
    //var date = widget.box.getAt(1).date;

    friendlist = widget.friendbox.values
        .where((friend) => friend.is_active == 'false')
        .toList();
    friendKeys = widget.friendbox
        .toMap()
        .entries
        .where((friend) => friend.value.is_active == 'false')
        .map((entry) => entry.key)
        .toList();
    // taskKeys = widget.box
    //     .toMap()
    //     .entries
    //     .where((entry) => entry.value.date == formatted)
    //     .map((entry) => entry.key)
    //     .toList();
    // //print("TASKS______________");
    // // print(taskKeys);
    // _myBoxListenable = widget.box.listenable();
  }

  @override
  Widget build(BuildContext context) {
    // Color _color_TaskMessage = widget.color_Secondary;
    List<FriendRequest> friendList = List.generate(
        friendlist.length,
        (index) => FriendRequest(
            friendbox: widget.friendbox,
            friendID: friendKeys[index],
            is_active: friendlist[index].is_active,
            last_name: friendlist[index].last_name,
            name: friendlist[index].name));
// Sort the taskMessages list based on date and time
    // friendList =
    //     friendList.where((friend) => friend.is_active == 'false').toList();
    // friendKeys = widget.friendbox
    //     .toMap()
    //     .entries
    //     .where((friend) => friend.value.is_active == 'false')
    //     .map((entry) => entry.key)
    //     .toList();
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
