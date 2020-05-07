import 'package:flutter/material.dart';
import 'bottomnavigation.dart';
import 'signup.dart';
import '../constants/routes_path.dart' as routes;
import '../services/navigation_service.dart';
import '../locator.dart';

class LoginPage extends StatefulWidget{
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();

}
class _LoginPageState extends State<LoginPage>{

  final NavigationService _navigationService = locator<NavigationService>();

  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();

  String _phoneNoError, _passwordError;
  String countryCode = "+91";

  void performLogin(){
    setState(() {
      if(phoneNoController.text.length != 10){
        _phoneNoError = "Enter Valid Phone Number";
      }
    });
  }

  @override
  void dispose(){
    phoneNoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 4.0, right: 4.0),
              child: Container(
                height: 65,
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
                              height: 1,
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
                                errorText: _phoneNoError),
                            controller: phoneNoController,
                            keyboardType: TextInputType.number,
                            onChanged: (value){
                              if(value.length!=0 && value.length!=10){
                                _phoneNoError = "Phone number not proper";
                              }
                              else{
                                _phoneNoError = null;
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
            Padding(padding: EdgeInsets.only(left: 4.0, right: 4.0),
              child: Container(
                height: 65,
                child: TextFormField(decoration: InputDecoration(
                    hintText: 'Password',
                    errorText: _passwordError,
                ),
                  obscureText: true,
                  controller: passwordController,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 4.0, right: 4.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: performLogin,
                    child: Text("LOGIN", style: TextStyle(fontSize: 14.0)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)
                    ),
                  ),
                )
            ),
            Padding(padding: EdgeInsets.only(right:4.0, top:10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      _navigationService.navigateTo(routes.SignUpRoute);
                    },
                    child: Text(
                      'Signup',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),

                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(
        currentIndex: 3,
      ),
    );
  }
}