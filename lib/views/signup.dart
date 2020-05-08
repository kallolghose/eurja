import 'package:flutter/material.dart';
import 'package:eurja/views/bottomnavigation.dart';
import 'package:eurja/mycomponents.dart';

class SignUpPage extends StatefulWidget{
  SignUpPage({Key key}) : super(key:key);

  @override
  _SignUpPage createState() => _SignUpPage();

}

class _SignUpPage extends State<SignUpPage>{

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();

  String fullNameError, emailError, passwordError, phoneNoError, countryCode = "+91";

  void performSignUp(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(myTitle: "Sign Up", context: context,),
      body: SafeArea(child:
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 10.0),
                child: Container(
                  height:65,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            height:65,
                            child: DropdownButton<String>(
                              value: countryCode,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 30,
                              underline: Container(
                                height: 0,
                                color: Colors.blue,
                              ),
                              onChanged: (String newValue) {
                                countryCode = newValue;
                                setState(() {
                                });
                              },
                              items: <String>['+1', '+10', '+91', '+89']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                        ),
                      ),
                      Expanded(
                          child: Container(
                            height: 65,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  errorText: phoneNoError,
                                  suffixIcon: Icon(Icons.phone,
                                    color: Colors.blue,)
                              ),
                              controller: phoneNoController,
                              keyboardType: TextInputType.number,
                              onChanged: (value){
                                if(value.length!=0 && value.length!=10){
                                  phoneNoError = "Phone number not proper";
                                }
                                else{
                                  phoneNoError = null;
                                }
                                setState(() {

                                });
                              },
                            ),
                          ),
                          flex : 6
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.only(left: 4.0, right: 4.0),
                child: Container(
                  height: 65,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Full Name',
                        errorText: fullNameError,
                        suffixIcon: Icon(Icons.art_track,
                          color: Colors.blue,),

                      ),
                    controller: fullNameController,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.0, right: 4.0),
                child: Container(
                  height: 65,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      errorText: emailError,
                      suffixIcon: Icon(Icons.mail,
                        color: Colors.blue,),
                    ),
                    onChanged: (value){
                      if(value.length == 0){
                        emailError = null;
                      }
                    },
                    controller: emailController,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.0, right: 4.0),
                child: Container(
                  height: 65,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                        errorText: passwordError,
                        suffixIcon: Icon(Icons.remove_red_eye,
                          color: Colors.blue,)
                    ),
                    obscureText: true,
                    onChanged: (value){
                      if(value.length == 0 || value.length >=6){
                        passwordError = null;
                      }
                      else{
                        passwordError = "Password should be > 6";
                      }
                      setState(() {
                      });

                    },
                    controller: passwordController,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: SizedBox(
                    width: double.infinity,
                    height: 45.0,
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: performSignUp,
                      child: Text("SIGNUP", style: TextStyle(fontSize: 14.0)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)
                      ),
                    )
                ),
              )
            ],
          ),
        )
      ),
      //bottomNavigationBar: MyBottomNavigation(currentIndex: 3),
    );
  }
}