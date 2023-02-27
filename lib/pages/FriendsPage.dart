import 'package:atrax/components/FriendRequest.dart';
import 'package:atrax/components/FriendRequestList.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import 'package:hive/hive.dart';

import '../components/DevButtons.dart';
import '../components/FriendsList.dart';
import '../components/HiveInit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/TaskRequest.dart';

/*Future<void> readJson() async {
//final AssetBundle rootBundle = _initRootBundle();
//final String response = await rootBundle.loadString('assets/friends.json');
String rawJson = '{"name":"Mary","age":30}';
final String response = '{"friends": [{"fname": "Spyros","lname": "Giannopoulos","icon_symbol": "SG"},{"fname": "Aggelos","lname": "Loukas","icon_symbol": "AL"}]}';
final data = await json.decode(response);
final _items = data["friends"];
print("number of friends : ${_items.length}");
setState(() { _myState = newValue; });Friends = _items;
} */

class FriendsPage extends StatefulWidget {
  final Box friendbox;

  @override
  _FriendsPageState createState() => _FriendsPageState();

  FriendsPage({Key? key, required this.friendbox}) : super(key: key);
}

class _FriendsPageState extends State<FriendsPage> {
  var Friends = [];

  var prev_user_name = 'username123';
  var Username_controller = TextEditingController(text: 'Spyros');

  var N_friend_requests = 1;

  @override
  void didUpdateWidget(FriendsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.friendbox.length != oldWidget.friendbox.length) {
      setState(() {
        // updateTasksForSelectedDay();
        // print("----------------------------------");
        // print(taskKeys);
        // getSelectedDayTasks();
      });
    }
  }
//   Future<void> readFriendsJson() async {
// //final AssetBundle rootBundle = _initRootBundle();
// //final String response = await rootBundle.loadString('assets/friends.json');
//     final String response =
//         '{"friends": [{"fname": "Spyros","lname": "Giannopoulos","icon_symbol": "SG"},{"fname": "Aggelos","lname": "Loukas","icon_symbol": "AL"}]}';
//     final data = await json.decode(response);
//     final _items = data["friends"];
//     //print(_items);
//     //print("number of friends : ${_items.length}");

//     /*final prefs = await SharedPreferences.getInstance();
//     final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
//     if(isFirstLaunch){
//     widget.friendbox.put(0, Friend(name: 'John', last_name: 'A', is_active: true));
//     widget.friendbox.put(1, Friend(name: 'John_2', last_name: 'A', is_active: true));
//     widget.friendbox.put(2, Friend(name: 'John_3', last_name: 'A', is_active: true));
//     prefs.setBool('isFirstLaunch', false);
//     }*/

//     print(widget.friendbox.length);
//     //print(widget.friendbox.get(0).name);

//     setState(() {
//       Friends = _items;
//     });

//     //print(Friends[0]["fname"]);
//   }

//   Future<void> readFriendsFromDB() async {
//     final String response =
//         '{"friends": [{"fname": "Spyros","lname": "Giannopoulos","icon_symbol": "SG"},{"fname": "Aggelos","lname": "Loukas","icon_symbol": "AL"}]}';
//     final data = await json.decode(response);
//     final _items = data["friends"];
//     //print(_items);
//     //print("number of friends : ${_items.length}");
//     setState(() {
//       Friends = _items;
//     });
//     //print(Friends[0]["fname"]);
//   }

  @override
  void initState() {
    super.initState();
    Username_controller = new TextEditingController(text: prev_user_name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6F4F1),
      body: Column(
        children: [
          Row(
            children: [
              // const BackButton(),
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    prev_user_name = Username_controller.text;
                    Navigator.pop(context);
                  });
                },
              ),
              Spacer(),
              Container(
                color: const Color(0xff929AE7),
                child: TextButton(
                  child: Icon(Icons.person_outlined, color: Color(0xff252525)),
                  onPressed: openUserInfo,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: /*Text(
                'Task Requests',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )*/
                TaskRequest(
              name: 'Task 1',
              description: 'This is my task',
              date: '2023-02-22',
              time: '10:00 AM',
              repetitiveness: 'Daily',
              notifications: [
                {"date": "2023-03-01", "time": "10:00 AM"},
                {"date": "2023-03-03", "time": "3:30 PM"},
                {"date": "2023-03-05", "time": "8:15 AM"},
              ],
              importance: 'High',
              location: 'latitude' + '37.7749' + 'longitude' + '-122.4194',
              recording_file_path: 'assets/recordings/Scoobydoo.mp3',
              //photo_file_path: 'assets/icons/user_barcode_1.png',
              friend_name: ['John', 'Jane'],
            ),
          ),
          //getTaskRequests(),
          SizedBox(height: 50),
          Align(
              alignment: Alignment.center,
              child: Text(
                'Friends List',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
          /*ElevatedButton(
          child: Text("Read Friends"),
          onPressed: readJson,
        ),*/
          FriendList(
            friendbox: widget.friendbox,
          ),
          // Row(
          //   children:[ElevatedButton(onPressed: (){}), child: child)]
          // )
        ],
      ),
    );
  }

  Future openUserInfo() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text(
            "Your profile",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xffE6F4F1),
          content: Column(
            children: [
              Text("Username :"),
              TextFormField(
                  controller: Username_controller,
                  //initialValue: "Spyros",
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  )),
              const SizedBox(height: 25),
              Text("Share this to connect with new people"),
              /*Image(
                  image: AssetImage('/icons/user_barcode.png'),
                  )*/
              const SizedBox(height: 25),
              Image.asset(
                'icons/user_barcode_1.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 25),
              ElevatedButton(
                child: Text('Friend Requests'),
                onPressed: openFriendRequests,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffA15EAF), // Background color
                ),
              )
            ],
          )));
  Future openFriendRequests() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text(
            "Friend Requests",
            textAlign: TextAlign.center,
          ),
          //insetPadding: EdgeInsets.symmetric(vertical: 200),
          backgroundColor: Color(0xffE6F4F1),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            //FriendRequest(name: 'Nikos', last_name: 'Fiannopoulos', is_active: 'false',),
            FriendRequestsList(friendbox: widget.friendbox),
          ])));
}
