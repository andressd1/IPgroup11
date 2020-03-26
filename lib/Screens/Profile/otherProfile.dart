import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:template/Models/Arguments.dart';
import 'package:template/Models/User.dart';
import 'package:template/Models/UserDetails.dart';
import 'package:template/Screens/WatchList/watchlist.dart';
import 'package:template/Services/DatabaseServices.dart';

const Color BOTTOM_BAR_COLOR = Colors.redAccent;

class OtherProfile extends StatefulWidget {
  OtherProfile({Key key}) : super(key: key);

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  bool blocked;
  bool pressed = true;
  String strText = 'Follow';
  OtherProfileArgument args;
  bool dataRetrieved = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void getData() async {
    FollowerDetails details =
    await DatabaseServices(User.userdata.uid).getFollower(uid: args.id);
    if (details == null) return;

    if (!details.accepted) {
      pressed = false;
      strText = 'Request Pending';
    } else {
      pressed = false;
      strText = 'Following';
    }
    dataRetrieved = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    if (!dataRetrieved) getData();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(args.userName),
        actions: <Widget>[
          FutureBuilder(
            future: DatabaseServices(User.userdata.uid).isFriend(uid: args.id),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) return Text("");
              return snapshot.data
                  ? IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/chatMessages',
                    arguments: ChatMessagesArgument(id: args.id),
                  );
                },
                icon: Icon(Icons.message),
              )
                  : Text("");
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1501549538842-2f24e2dd6520?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80',
                    ),
                  ),
                ],
              ),
              new Positioned(
                right: 10,
                top: 0,
                child: new FutureBuilder(
                  builder: (context, projectSnap) {
                    if (!projectSnap.hasError &&
                        projectSnap.hasData &&
                        projectSnap.connectionState == ConnectionState.done) {
                      if (blocked == null) {
                        blocked = projectSnap.data;
                      }
                      return new RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: new BorderRadius.circular(15.0)),
                        onPressed: () {
                          if (blocked == false) {
                            DatabaseServices(User.userdata.uid)
                                .blockUser(theirUID: args.id);
                            setState(() {
                              blocked = !blocked;
                            });
                          }
                          else {
                            DatabaseServices(User.userdata.uid)
                                .unBlockUser(theirUID: args.id);
                            setState(() {
                              blocked = !blocked;
                            });
                          }
                        },
                        splashColor: Colors.redAccent,
                        child: new Text(
                          (blocked) ? "Unblock" : "Block",
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                    else {
                      return SizedBox(
                        width: 1,
                      );
                    }
                  },
                  future: DatabaseServices(User.userdata.uid)
                      .checkYouBlocked(theirUID: args.id),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(args.userName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                minWidth: 120.0,
                height: 50.0,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.blue)),
                  color: pressed ? Colors.white : Colors.blue,
                  textColor: pressed ? Colors.black : Colors.white,
                  child: new Text(strText),
                  onPressed: () {
                    setState(() {
                      if (pressed == true) {
                        strText = 'Unfollow';
                        DatabaseServices(User.userdata.uid).follow(args.id);
                      } else {
                        strText = 'Follow';
                        DatabaseServices(User.userdata.uid).unFollow(args.id);
                      }
                      pressed = !pressed;
                    });
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 120.0,
                height: 50.0,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.blue)),
                  onPressed: () async {
                    if (await DatabaseServices(User.userdata.uid)
                        .isFriend(uid: args.id)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WatchList(
                            uid: args.id,
                            index: 0,
                          ),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg:
                          "You're not friends with the person therefore you "
                              "cannot view the watch list of the person",
                          gravity: ToastGravity.CENTER,
                          toastLength: Toast.LENGTH_SHORT);
                    }
                  },
                  color: Colors.white,
                  textColor: Colors.black,
                  child: Text("Watch List", style: TextStyle(fontSize: 16)),
                ),
              ),
              ButtonTheme(
                minWidth: 120.0,
                height: 50.0,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.blue)),
                  onPressed: () async {
                    if (await DatabaseServices(User.userdata.uid)
                        .isFriend(uid: args.id)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WatchList(
                                uid: args.id,
                                index: 1,
                              ),
                        ),
                      );
                    }
                    else {
                      Fluttertoast.showToast(
                        msg: "You're not friends with the person therefore you "
                            "cannot view the review list of the person",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  },
                  color: Colors.white,
                  textColor: Colors.black,
                  child: Text("Review list", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Favorite Movie',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600])),
              ),
              Container(
                width: 120,
                child: Text('Joker',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Favorite Category',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600])),
              ),
              Container(
                width: 120,
                child: Text('Thriller',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Followers',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600])),
              ),
              Container(
                width: 120,
                child: Text('22',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Friends',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600])),
              ),
              Container(
                width: 120,
                child: Text('10',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Reviewed movies',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600])),
              ),
              Container(
                width: 120,
                child: Text('30',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Category most watched',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600])),
              ),
              Container(
                width: 120,
                child: Text('Action',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Gender',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600])),
              ),
              Container(
                width: 120,
                child: Text('Male',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Date of birth',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600])),
              ),
              Container(
                width: 120,
                child: Text('08/09/2000',
                    textAlign: TextAlign.left,
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
