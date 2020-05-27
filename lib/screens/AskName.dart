import 'package:flutter/material.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/shape/gf_button_shape.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:vocab_builder/helpers/Routes.dart';
import 'package:vocab_builder/helpers/apicalls.dart';
import 'package:vocab_builder/models/User.dart';

class AskName extends StatefulWidget{
  String phone;
  AskName(String this.phone);
  _AskNameState createState() => _AskNameState(phone); 
}

class _AskNameState extends State<AskName> {
  final _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    name="";
    err_on_name=null;
    focus_node = FocusNode();
    isButtonDisabled=false;
  }
  _AskNameState(String this.phone);
  String phone;
  String name;
  bool isButtonDisabled;
  String err_on_name;
  FocusNode focus_node;
  void gesture_detection() {
    setState(() {
      focus_node.unfocus();
      if(err_on_name!=null) {err_on_name=null;}
    });
  }
  TextEditingController name_controller = TextEditingController();
  String confirm_name() {
      String v = name_controller.text;
      String val = "";
      print(v);
                    String value = v;
                    for(int i=0; i<value.length; i++) {
                      bool a_space = false;
                      while(value[i]==' ' || value[i]=='\t') {
                        i++; a_space = true;
                        if(i>=value.length) break;
                      }
                      if(i>=value.length) break;
                      if(a_space && val.length>0) val+=' ';
                      val+=value[i];
                    }
                    print("val: $val");
                    return val;
  }

  void onPressingSubmit(BuildContext context) async{
    setState( (){isButtonDisabled=true;} );
    Function enableButton = (){
      setState(() {isButtonDisabled=false;});
    };
    if(confirm_name()=="") {
      setState(() {
        err_on_name = "Name can not be empty"; 
      });
      enableButton();
    }
    else {
    try {
      User user = await registerUser(phone, name);
      Navigator.pushNamedAndRemoveUntil(context, Routes.homepage, (Route route)=>false,arguments: user);
    }
    catch (err) {
          var snackbar = SnackBar(content: Text(err.toString()),backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),);
          Scaffold.of(context).showSnackBar(snackbar);
          enableButton();
    }
  }
 }

  Widget myTextField() {
    return Form(
            key:_formKey, 
            child: TextFormField(
            controller: name_controller,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
                                      errorText: err_on_name,
                                      hintText: "Enter Full Name"),
            focusNode: focus_node,
            onTap: () {
              if(err_on_name!=null) {
              setState(() {
                err_on_name=null;
              });
              }
            },
          ),
    );
  }

  Widget nameWidget() {
    return 
    Row(
      children: <Widget>[
        Expanded(flex: 10, child: Text("")), 
        Expanded(flex: 90, child: myTextField()),
        Expanded(flex: 10, child: Text(""),)
      ],
    );
  }

  Widget submit_button(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
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
                    color: Colors.green,
                    elevation: 20,
                    onPressed: !isButtonDisabled? (){onPressingSubmit(context);} : null,
                    text: "Continue",
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
    final height = MediaQuery.of(context).size.height;
    print(height);
    return Column(
       mainAxisSize: MainAxisSize.min,
       children: <Widget>[
         Container(
           constraints: BoxConstraints(maxHeight: 0.2*height,minHeight: 0.2*height),
         ),
         Container(
           constraints: BoxConstraints(minHeight: 0.8*height-10),
           child: Column(
             children: <Widget>[
               nameWidget(),
               submit_button(context),
             ],
           ),
         )
       ],
     );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
                  builder: (contxt) => GestureDetector(
              onTap: gesture_detection,
              child: SingleChildScrollView(child: Theme(
                data: ThemeData(
                  primaryColor: Colors.green,
                  primaryColorDark: Colors.greenAccent,
                ),
                child: Body(contxt)))),
        ),
      );
  }
}