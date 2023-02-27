import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../routes/routes.dart';
import 'HiveInit.dart';


class FriendRequest extends StatelessWidget{

final String name;
final String last_name;
final String is_active;
final String friendID;
final Box friendbox;

  const FriendRequest({  
    required this.name,
    required this.last_name,
    required this.is_active,
    required this.friendID,
    required this.friendbox });

@override
Widget build(BuildContext context){ 
  //print(name);
          return Container(
                  height: 60,
                  width: 316,
                  child: Card(
                    color: Color(0xff929AE7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: 
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          //Text('Katerina Lioliou\nsent you a friend request'),
                          Text(name+ " " + last_name + '\nsent you a friend request'),
                          SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                  _addFriend();
                                } ,
                                child: Text('Accept'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff1F8A87),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                ),
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
                                  child: Text('Decline'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xffA94C52),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                      ),
                                    ),
                                  )))
                        ]
                        )
                        ),
                  ),
                );
                
}
    void _addFriend(){
      final friend = friendbox.values.firstWhere(
        (friend) => friend.friendID == friendID,
          orElse: () => null,); 
      print(friend.friendID);
      friend.is_active = 'true';
      friendbox.put(friend.friendID, friend);

    }

    void _removeFriend(){
      final friend = friendbox.values.firstWhere(
        (friend) => friend.friendID == friendID,
          orElse: () => null,); 
      print(friend.friendID);
      friendbox.delete(friend.friendID);
    }
}