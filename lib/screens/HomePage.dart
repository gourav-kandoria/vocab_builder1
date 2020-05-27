import 'package:flutter/material.dart';
import 'package:vocab_builder/models/User.dart';

class HomePage extends StatefulWidget{
  User user;
  HomePage(this.user);
  _HomePageState createState() => _HomePageState(user); 
}

Widget Body(BuildContext context) {
  return Center(
      child:  Text("Hello World"),
    );
}

class _HomePageState extends State<HomePage> {
  User user;
  _HomePageState(this.user);
  Widget Body(BuildContext context) {
    return DefaultTabController(length: 2, 
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Vocab Builder"),
            stretch: false,
            floating: true,
            pinned: true,
            snap: true,
            bottom: TabBar(tabs: [
              Text("Collections"), Text("Words"),
            ]),
         ),
         SliverFillRemaining(
           child: TabBarView(
             children: <Widget>[

             ],
           ),
         )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
                  builder: (BuildContext contxt) => GestureDetector(
              child: Body(contxt)),
        ),
      );
  }
}