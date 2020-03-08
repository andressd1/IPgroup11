import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color BOTTOM_BAR_COLOR = Colors.redAccent;

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int currentindex = 0; // home = 0
  var currentSelectedValue = 'Male';
  var currentSelectedValueCat = 'Action';

  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();
  var dateFormat = DateFormat('d-MM-yyyy');

  _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1903, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date.value =
            TextEditingValue(text: ('${dateFormat.format(picked)}').toString());
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Edit Profile'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 110,
                  height: 140,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1501549538842-2f24e2dd6520?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80'),
                      ),
                    ),
                    Container(
                      width: 50,
                      child: FloatingActionButton(
                        backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
                        elevation: 0,
                        onPressed: () => {},
                        tooltip: 'Edit',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Edit"),
                          ],
                        ),
                        //label: Text('Approve'),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 110,
                  height: 140,
                  alignment: Alignment.topRight,
                  child: MaterialButton(
                    //elevation: 0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: 120,
                    child: new TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        height: 1.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Frank Davis',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                  child: new TextField(
                    //textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18.0, height: 0, color: Colors.black),

                    decoration: InputDecoration(
                      hintText: 'Joker',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                  child: DropdownButton<String>(
                    value: currentSelectedValueCat,
                    onChanged: (newVal) {
                      setState(
                        () {
                          print(newVal);
                          currentSelectedValueCat = newVal;
                        },
                      );
                    },
                    items: <String>[
                      'Action',
                      'Comedy',
                      'Thriller',
                      'Horror',
                      'Family'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  //width: 120,
                  //child: Text('Male', textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                /*Container(
                    width: 120,
                    child: Text('Thriller', textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),*/
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                  child: DropdownButton<String>(
                    value: currentSelectedValue,
                    onChanged: (newVal) {
                      setState(
                        () {
                          print(newVal);
                          currentSelectedValue = newVal;
                        },
                      );
                    },
                    items: <String>['Male', 'Female', 'Other', 'Not say']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  //width: 120,
                  //child: Text('Male', textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Container(
//                  padding: EdgeInsets.only(left: 20),
//                  child: Text('Date of birth',
//                      style: TextStyle(
//                          fontSize: 18,
//                          fontWeight: FontWeight.bold,
//                          color: Colors.grey[600])),
//                ),
//                Container(
//                  width: 120,
//                  child: Text('08/09/2000',
//                      textAlign: TextAlign.left,
//                      style:
//                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                ),
//              ],
//            ),
//          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Date of birth', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600])),
              ),
              /*Container(
                width: 120,
                child: Text('08/09/2000', textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),*/
            ],
          ),

          Transform(
            transform: Matrix4.translationValues(270, -32, 0.0),                 child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => _selectDate(),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _date,
                    //keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      hintText: "08-09-2000",
                      border: InputBorder.none,
                      //hasFloatingPlaceholder: true
                    ),
                  ),
                ),
              ), //child: Text('Date of Birth'),
            ],
          ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        selectedFontSize: 0.0,
        backgroundColor: BOTTOM_BAR_COLOR,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: currentindex,
        onTap: (index){
          setState(() {
            currentindex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              backgroundColor: BOTTOM_BAR_COLOR,
              title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              backgroundColor: BOTTOM_BAR_COLOR,
              title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              backgroundColor: BOTTOM_BAR_COLOR,
              title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              backgroundColor: BOTTOM_BAR_COLOR,
              title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              backgroundColor: BOTTOM_BAR_COLOR,
              title: Text('')),
        ],
      ),
    );
  }
}
