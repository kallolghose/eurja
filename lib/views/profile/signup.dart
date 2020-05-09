import 'package:flutter/material.dart';
import 'package:eurja/utilities/mycomponents.dart';
import 'package:eurja/services/profile/signupservice.dart';
import 'package:eurja/models/profile/signupmodels.dart';
import 'package:eurja/constants/app_constants.dart' as app_constants;

class SignUpPage extends StatefulWidget{
  SignUpPage({Key key}) : super(key:key);

  @override
  _SignUpPage createState() => _SignUpPage();

}

class _SignUpPage extends State<SignUpPage> implements SignUpCallBack, OTPCallBack {

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();
  final AppUtilities appUtilities = AppUtilities();

  SignUpApi signUpApi;
  OTPApi otpApi;
  bool _isSigningIn = false, _isOTPValidation = false;
  String fullNameError, emailError, passwordError, phoneNoError, countryCode = "+91";

  void performSignUp(){
    FocusScope.of(context).requestFocus(new FocusNode());
    if(isValidated()){
      setState(() {
        _isSigningIn = true;
      });
      signUpApi.performSignUp(SignUpRequest(
        emailId: emailController.text,
        isdCode: countryCode,
        phoneNo: int.parse(phoneNoController.text),
        password: passwordController.text
      ));
    }
  }

  @override
  void onSignUpFailure(String message) {
    setState(() {
      _isSigningIn = false;
    });
    appUtilities.showSnackBar(context, message, app_constants.ERROR);
  }

  @override
  void onSignUpSuccess(SignUpResponse signUpResponse){
    setState(() {
      _isSigningIn = false;
    });
    showOTPDialog();
  }


  @override
  void onOTPSuccess(OTPResponse otpResponse) {
    setState(() {
      _isOTPValidation = false;
    });
  }

  @override
  void onOTPFailure(String message) {
    setState(() {
      _isOTPValidation = false;
    });
    appUtilities.showSnackBar(context, message, app_constants.ERROR);
  }


  @override
  void initState() {
    super.initState();
    signUpApi = SignUpApi(this);
    otpApi = OTPApi(this);
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
                              elevation: 16,
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
                    child: MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: performSignUp,
                      child: setUpLoaderButton(),
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

  Widget setUpLoaderButton(){
    if(!_isSigningIn){
      return Text("SIGN UP", style: TextStyle(fontSize: 14.0));
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

  Widget setUpOTPLoaderButton(){
    if(!_isOTPValidation){
      return Text("Submit", style: TextStyle(fontSize: 14.0));
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

  bool isValidated(){
    bool ret = true;
    String nameRegex = "^[a-zA-Z]+\\s{0,1}[a-zA-Z]*\$";
    if(phoneNoController.text.length != 10){
      phoneNoError = 'Please enter a valid number';
      ret = false;
    }
    else
      phoneNoError = null;

    RegExp nameRxExp = new RegExp(
      r"^[a-zA-Z]+\\s{0,1}[a-zA-Z]*\$",
      caseSensitive: false,
      multiLine: false,
    );
    if(!nameRxExp.hasMatch(fullNameController.text)){
      fullNameError = "Please enter a valid name";
      ret = false;
    }
    else
      fullNameError = null;

    RegExp emailRxExp = new RegExp(
      r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$",
      caseSensitive: false,
      multiLine: false,
    );
    if(!emailRxExp.hasMatch(emailController.text)){
      emailError = "Please enter a valid email";
      ret = false;
    }
    else
      emailError = null;

    if(passwordController.text.length == 0){
      passwordError = "Please enter a valid password";
      ret = false;
    }
    else
      passwordError = null;

    setState(() {
    });
    return ret;
  }

  final FocusNode _otp1 = FocusNode();
  final FocusNode _otp2 = FocusNode();
  final FocusNode _otp3 = FocusNode();
  final FocusNode _otp4 = FocusNode();
  final FocusNode _otp5 = FocusNode();
  final FocusNode _otp6 = FocusNode();

  final _otp1Controller = new TextEditingController();
  final _otp2Controller = new TextEditingController();
  final _otp3Controller = new TextEditingController();
  final _otp4Controller = new TextEditingController();
  final _otp5Controller = new TextEditingController();
  final _otp6Controller = new TextEditingController();

  void showOTPDialog(){
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Container(
            height: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child:
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                          child: Text("Please enter OTP",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        )
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 5.0, top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: ''
                          ),
                          focusNode: _otp1,
                          controller: _otp1Controller,
                          onChanged: (value){
                            if(value.length == 1){
                              _fieldFocusChange(context, _otp1, _otp2);
                            }
                          }
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: ''
                          ),
                          focusNode: _otp2,
                          controller: _otp2Controller,
                          onChanged: (value){
                            if(value.length == 1){
                              _fieldFocusChange(context, _otp2, _otp3);
                            }
                          }
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: ''
                          ),
                          focusNode: _otp3,
                          controller: _otp3Controller,
                          onChanged: (value){
                            if(value.length == 1){
                              _fieldFocusChange(context, _otp3, _otp4);
                            }
                          }
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: ''
                          ),
                          controller: _otp4Controller,
                          focusNode: _otp4,
                            onChanged: (value){
                              if(value.length == 1){
                                _fieldFocusChange(context, _otp4, _otp5);
                              }
                            }
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: ''
                          ),
                          controller: _otp5Controller,
                          focusNode: _otp5,
                          onChanged: (value){
                            if(value.length == 1){
                              _fieldFocusChange(context, _otp5, _otp6);
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: ''
                          ),
                          controller: _otp6Controller,
                          focusNode: _otp6,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top:15.0, bottom: 10.0),
                        child: MaterialButton(
                          onPressed: validateOTP,
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: setUpOTPLoaderButton(),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)
                          )
                        )
                      )
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 5.0, top: 5.0, bottom: 5.0),
                      child: GestureDetector(
                        onTap: (){},
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    Padding(
                        padding: EdgeInsets.only(left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
                        child: GestureDetector(
                          onTap: (){},
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                  ],
                )
              ],
            )
          ),
        );
      }
    );
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void validateOTP(){

  }
}