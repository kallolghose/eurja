import 'package:flutter/material.dart';
import 'package:eurja/constants/routes_path.dart' as routes;
import 'package:eurja/services/navigation_service.dart';
import 'package:eurja/locator.dart';
import 'package:eurja/models/profile/loginmodels.dart';
import 'package:eurja/services/profile/loginservice.dart' as loginService;
import 'package:eurja/models/profile/utilitiesmodel.dart';
import 'package:eurja/services/profile/utilitiesservice.dart';
import 'package:eurja/utilities/mycomponents.dart';
import 'package:eurja/constants/app_constants.dart' as app_constants;

class LoginPage extends StatefulWidget{
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();

}
class _LoginPageState extends State<LoginPage> implements loginService.LoginCallBack, UtilitiesCallBack{

  final NavigationService _navigationService = locator<NavigationService>();
  final AppUtilities _appUtilities = AppUtilities();

  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();

  CountryCodeData selectedCountryCode;
  bool _isLoggingIn = false;
  loginService.LoginApi loginApi;
  UtilitiesAPI utilitiesAPI;
  List<CountryCodeData> data = new List();
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();

  void performLogin(){
    FocusScope.of(context).requestFocus(new FocusNode());

    if(loginKey.currentState.validate()){
      //Create the login request model and hit the API
      setState(() {
        _isLoggingIn = true;
      });
      loginApi.performLogin(LoginRequest(
        isdCode: "+" + selectedCountryCode.countryCode.toString(),
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
    _appUtilities.saveLoginInformation(loginResponse);
  }


  @override
  void onCountryCodeSuccess(CountryCodeResponse countryCodeResponse) {
    setState(() {
      data = countryCodeResponse.data;
    });
  }

  @override
  void onCountryCodeFailure(String message) {

  }

  @override
  void initState() {
    super.initState();
    selectedCountryCode = new CountryCodeData(countryCode: 91, countryCodeString: "IN", countryName: "India", countryImage: "https://www.countryflags.io/in/flat/16.png",
    displayText: "(IN) +91", phoneNumberLength: 10);
    loginApi = new loginService.LoginApi(this);
    utilitiesAPI = new UtilitiesAPI(this);
    utilitiesAPI.getCountryCodes();

  }

  @override
  void dispose(){
    phoneNoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Set a default country code

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child:
        Form(
          key: loginKey,
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
                      Container(
                          height: 65,
                          child: ButtonTheme(
                            alignedDropdown: false,
                            child: DropdownButton<CountryCodeData>(
                              hint: Text("C.Code"),
                              isExpanded: false,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              underline: Container(
                                height: 0,
                                color: Colors.black26,
                              ),
                              onChanged: (CountryCodeData newValue) {
                                selectedCountryCode = newValue;
                                setState(() {
                                  selectedCountryCode;
                                });
                              },
                              value: selectedCountryCode,
                              items: data.map((e) {
                                return new DropdownMenuItem(
                                  child: new Text(e.displayText,
                                    textAlign: TextAlign.center,
                                  ),
                                  value: e,
                                );
                              }).toList(),
                            ),
                          )
                      ),
                      Expanded(
                        child: Container(
                          height: 65,
                          child: TextFormField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.phone,
                                  color: Colors.blue,),
                                hintText: "Phone Number"),
                            controller: phoneNoController,
                            keyboardType: TextInputType.number,
                            onChanged: (value){

                            },
                            validator: (value) {
                              if(value == null && value.isEmpty)
                                return "Please enter phone number";
                              if(value !=null && value.length!=0 && value.length!=selectedCountryCode.phoneNumberLength){
                                return "Please enter a valid phone number";
                              }
                              else
                                return null;
                            },
                          ),
                        ),
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
                      suffixIcon: Icon(Icons.remove_red_eye,
                        color: Colors.blue,)
                  ),
                    obscureText: true,
                    controller: passwordController,
                    validator: (value){
                      if(value == null && value.isEmpty)
                        return "Please enter password";
                      return null;
                    },
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
        )
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