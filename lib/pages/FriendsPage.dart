import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

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
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  var Friends = [];

  final Username_controller = TextEditingController();
  var prev_user_name = 'Spyros';

  Future<void> readFriendsJson() async {
//final AssetBundle rootBundle = _initRootBundle();
//final String response = await rootBundle.loadString('assets/friends.json');
    final String response =
        '{"friends": [{"fname": "Spyros","lname": "Giannopoulos","icon_symbol": "SG"},{"fname": "Aggelos","lname": "Loukas","icon_symbol": "AL"}]}';
    final data = await json.decode(response);
    final _items = data["friends"];
    print(_items);
    print("number of friends : ${_items.length}");
    setState(() {
      Friends = _items;
    });
    print(Friends[0]["fname"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffE6F4F1),
        body: Column(children: [
          Row(
            children: [
              BackButton(),
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
              child: Text(
                'Task Requests',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
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
          getFriendsList(),
        ]));
  }

  Widget getFriendsList() {
    readFriendsJson();
    print(Friends);
    return ListView.builder(
      itemCount: Friends.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          key: ValueKey(Friends[index]["fname"]),
          margin: const EdgeInsets.all(10),
          child: ListTile(
            tileColor: const Color(0xff929AE7),
            //leading: Text(Friends[index]["icon_symbol"]),
            leading: CircleAvatar(
              child: Text(Friends[index]["icon_symbol"]),
              backgroundColor: Color(0xffE6F4F1),
            ),
            title:
                Text(Friends[index]["fname"] + " " + Friends[index]["lname"]),
            //subtitle: Text(Friends[index]["icon_symbol"]),
          ),
        );
      },
    );
  }

  Future openUserInfo() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("Your profile"),
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
            ],
          )));
}
