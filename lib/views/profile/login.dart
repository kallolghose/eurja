import 'package:flutter/material.dart';
import 'package:eurja/constants/routes_path.dart' as routes;
import 'package:eurja/services/navigation_service.dart';
import 'package:eurja/locator.dart';
import 'package:eurja/models/profile/loginmodels.dart';
import 'package:eurja/services/profile/loginservice.dart' as loginService;
import 'package:eurja/utilities/mycomponents.dart';
import 'package:eurja/constants/app_constants.dart' as app_constants;

class LoginPage extends StatefulWidget{
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();

}
class _LoginPageState extends State<LoginPage> implements loginService.LoginCallBack{

  final NavigationService _navigationService = locator<NavigationService>();
  final AppUtilities _appUtilities = AppUtilities();

  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();

  String _phoneNoError, _passwordError;
  String countryCode = "+91";
  bool _isLoggingIn = false;
  loginService.LoginApi loginApi;


  void performLogin(){
    FocusScope.of(context).requestFocus(new FocusNode());
    if(phoneNoController.text.length != 10) {
      setState(() {
        _phoneNoError = "Enter Valid Phone Number";
      });
    }
    else{
      //Create the login request model and hit the API
      setState(() {
        _isLoggingIn = true;
      });
      loginApi.performLogin(LoginRequest(
        isdCode: countryCode,
        phoneNo: int.parse(phoneNoController.text),
        password: passwordController.text
      ));
    }
  }

  @override
  void onLoginFailure(String message) {
    setState(() {
      _isLoggingIn = false;
    });
    _appUtilities.showSnackBar(this.context, message, app_constants.ERROR);
  }

  @override
  void onLoginSuccess(LoginResponse loginResponse) {
    setState(() {
      _isLoggingIn = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginApi = new loginService.LoginApi(this);
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
      resizeToAvoidBottomInset: false,
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
                            elevation: 16,
                            underline: Container(
                              height: 0,
                              color: Colors.black26,
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
                                suffixIcon: Icon(Icons.phone,
                                  color: Colors.blue,),
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
                    suffixIcon: Icon(Icons.remove_red_eye,
                      color: Colors.blue,)                ),
                  obscureText: true,
                  controller: passwordController,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 4.0, right: 4.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45.0,
                  child: MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: performLogin,
                    child: setUpLoaderButton(),
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
      //bottomNavigationBar: MyBottomNavigation(currentIndex: 3,),
    );
  }

  Widget setUpLoaderButton(){
    if(!_isLoggingIn){
      return Text("LOGIN", style: TextStyle(fontSize: 14.0));
    }
    else{
      return SizedBox(
          width: 20.0,
          height: 20.0,
          child : CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        );
    }
  }
}