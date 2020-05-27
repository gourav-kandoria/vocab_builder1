import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:vocab_builder/helpers/Routes.dart';
import 'package:vocab_builder/helpers/apicalls.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    countryCode = '+91';
    focus_node = FocusNode();
  }
  // variables //
  double height;
  String countryCode;
  String phone_no;
  bool focus;
  FocusNode focus_node; 
  //

  static Widget loginInfo = Container(
    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    decoration: BoxDecoration(
      //  borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 10.0, // soften the shadow
          spreadRadius: 2.0, //extend the shadow
          offset: Offset(
            0.0, // Move to right 10  horizontally
            8.0, // Move to bottom 10 Vertically
          ),
        )
      ],
      color: Colors.green,
    ),
    child: Align(
      alignment: Alignment.center,
      child: Title(
        color: Colors.white,
        child: Text(
          "Please Login to continue",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );

  static Widget footer(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      constraints: BoxConstraints(maxHeight: 0, maxWidth: width),
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 136, 229, 1),
      ),
      child: SizedBox.expand(),
    );
  }

  Widget phone_number_widget() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 20, 30, 15),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 20,
            child: CountryCodePicker(
              initialSelection: countryCode,
              comparator: (c1, c2) {
                return (c1.dialCode.compareTo(c2.dialCode));
              },
              onChanged: (c) {
                countryCode = c.dialCode;
                print('$countryCode');
              },
            ),
          ),
          Expanded(
            flex: 80,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TextField(
                focusNode: focus_node,
                onTap: () {
                  focus = true;
                },
                onChanged: (p) {
                  phone_no = p;
                  print("$phone_no");
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Phone Number'),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Text(""),
          ),
        ],
      ),
    );
  }

 Widget submit_button(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 15,
            child: Text(""),
          ),
          Expanded(
              flex: 75,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: GFButton(
                    elevation: 20,
                    color: Colors.green,
                    onPressed: () {
                      onPressingSubmit(context);
                    },
                    text: "Send OTP",
                    shape: GFButtonShape.pills,
                    fullWidthButton: true,
                    size: GFSize.LARGE,
                  ))),
          Expanded(child: Text(""), flex: 10),
        ],
      ),
    );
  }

  Widget Body(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        constraints: BoxConstraints(
          minHeight: (4 * height) / 10,
          maxHeight: (4 * height) / 10,
        ),
        padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
        child: Align(
            alignment: Alignment.center,
            child: Image.asset("images/letter.png")),
      ),
      Container(
          constraints: BoxConstraints(
            minHeight: 6 * (height) / 10,
          ),
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                // topLeft: Radius.circular(15.0),
                // topRight: Radius.circular(15.0),
                ),
            color: Colors.white,
          ),
          child: Column(children: <Widget>[
            loginInfo,
            phone_number_widget(),
            submit_button(context),
          ])),
    ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // rgb(118, 166, 240)
        backgroundColor: Colors.green,
        // body: Body(context),
        body: Builder(
              builder: (contxt) => GestureDetector(
                 onTap: (){setState(() {
                 focus_node.unfocus();
                 print("I Was tapped");
                 });
                 },
                 child: SingleChildScrollView(child: Body(contxt))
                 ),
              )
        );
  }

  void onPressingSubmit(BuildContext context) async {
    setState(() {
      focus_node.unfocus();
    });
    print("I was submitted");
          Navigator.pushNamedAndRemoveUntil(context, Routes.askname,(Route route)=>false);      

    Map<dynamic,dynamic> result = await recieveOTP(phone_no); 
    if(result["registered"]==true) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.askname,(Route route)=>false, arguments: phone_no);      
    } 
    var snackbar = SnackBar(content: Text(result["message"]),backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),);
    Scaffold.of(context).showSnackBar(snackbar);
  }
  
}