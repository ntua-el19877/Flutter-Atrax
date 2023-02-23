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

  var prev_user_name = 'Spyros_2';
  var Username_controller = TextEditingController(text: 'Spyros');

  var N_friend_requests =1;

  Future<void> readFriendsJson() async {
//final AssetBundle rootBundle = _initRootBundle();
//final String response = await rootBundle.loadString('assets/friends.json');
    final String response =
        '{"friends": [{"fname": "Spyros","lname": "Giannopoulos","icon_symbol": "SG"},{"fname": "Aggelos","lname": "Loukas","icon_symbol": "AL"}]}';
    final data = await json.decode(response);
    final _items = data["friends"];
    //print(_items);
    //print("number of friends : ${_items.length}");
    setState(() {
      Friends = _items;
    });
    //print(Friends[0]["fname"]);
  }

   @override
  void initState() {
    super.initState();
    Username_controller = new TextEditingController(text: prev_user_name);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffE6F4F1),
        body: Column(children: [
          Row(
            children: [
              //BackButton(),
              IconButton(
                icon: Icon(Icons.arrow_back),
                  onPressed: (){
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
          const Align(
              alignment: Alignment.center,
              child: Text(
                'Task Requests',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )
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

  Widget getTaskRequests(){
    return ListView.builder(
     scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
                height:60,
                width:316,
                child: 
                    Card(
                  color: Color(0xff929AE7),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  ),
                  ),
                  child:Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text('Katerina \nsent you a friend request'),
                        SizedBox(
                        height:60,
                        child:  
                        ElevatedButton(onPressed: Navigator.of(context).pop, child: Text('Accept'),style:ElevatedButton.styleFrom(
                          primary: Color(0xff1F8A87), shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(0),
                  topRight: Radius.circular(0),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  ),
                          ), 
                   ),
                   )
                    ),
                        SizedBox(
                        height:60,
                        child: ElevatedButton(
                        onPressed: () {
                        setState(() {
                          N_friend_requests = 0;
                          Navigator.pop(context);
                        }); }
                        , 
                        child: Text('Decline'),
                        style:ElevatedButton.styleFrom(
                          primary: Color(0xffA94C52), shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  ),
                          ),  
                          )
                          )
                        )
                      ] 
                    )
                  ),
                ),
                );
      }
    );
  }

  Future openUserInfo() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("Your profile", textAlign: TextAlign.center,),
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
                  )
                  ),
                const SizedBox(
                  height: 25
                ),
                Text("Share this to connect with new people"),
                /*Image(
                  image: AssetImage('/icons/user_barcode.png'),
                  )*/
                const SizedBox(
                  height: 25
                ),
                Image.asset(
                  'icons/user_barcode_1.png',
                  height: 200,
                  width: 200,
                  ),
                SizedBox(height:25),
                ElevatedButton(
                  child: Text('Friend Requests'),
                  onPressed: openFriendRequests ,
                 style: ElevatedButton.styleFrom(
                    primary: Color(0xffA15EAF), // Background color
                   ),
                )
            ],
          )
          )
          );
   Future openFriendRequests() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("Friend Requests", textAlign: TextAlign.center,),
          insetPadding: EdgeInsets.symmetric(vertical: 200),
          backgroundColor: Color(0xffE6F4F1),
          content: 
          Column(
            children: [
              if (N_friend_requests>0)
              Container(
                height:60,
                width:316,
                child: 
                    Card(
                  color: Color(0xff929AE7),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  ),
                  ),
                  child:Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text('Katerina Lioliou\nsent you a friend request'),
                        SizedBox(
                        height:60,
                        child:  
                        ElevatedButton(onPressed: Navigator.of(context).pop, child: Text('Accept'),style:ElevatedButton.styleFrom(
                          primary: Color(0xff1F8A87), shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(0),
                  topRight: Radius.circular(0),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  ),
                          ), 
                   ),
                   )
                    ),
                        SizedBox(
                        height:60,
                        child: ElevatedButton(
                        onPressed: () {
                        setState(() {
                          N_friend_requests = 0;
                          Navigator.pop(context);
                        }); }
                        , 
                        child: Text('Decline'),
                        style:ElevatedButton.styleFrom(
                          primary: Color(0xffA94C52), shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  ),
                          ),  
                          )
                          )
                        )
                      ] 
                    )
                  ),
                ),
                )
          ],
            )
          )
      );
}
