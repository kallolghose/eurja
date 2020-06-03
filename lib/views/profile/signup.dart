import 'package:eurja/services/profile/utilitiesservice.dart';
import 'package:flutter/material.dart';
import 'package:eurja/utilities/mycomponents.dart';
import 'package:eurja/services/profile/signupservice.dart';
import 'package:eurja/models/profile/signupmodels.dart';
import 'package:eurja/constants/app_constants.dart' as app_constants;
import 'package:eurja/constants/routes_path.dart' as routes;
import 'package:eurja/services/navigation_service.dart';
import 'package:eurja/models/profile/utilitiesmodel.dart';
import 'package:eurja/locator.dart';

class SignUpPage extends StatefulWidget{
  SignUpPage({Key key}) : super(key:key);

  @override
  _SignUpPage createState() => _SignUpPage();

}

class _SignUpPage extends State<SignUpPage> implements SignUpCallBack,UtilitiesCallBack {

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();
  final AppUtilities appUtilities = AppUtilities();
  List<CountryCodeData> data = new List();

  SignUpApi signUpApi;
  UtilitiesAPI utilitiesAPI;
  CountryCodeData selectedCountryCode;

  bool _isSigningIn = false;
  GlobalKey<FormState> signUpKey = new GlobalKey<FormState>();

  void performSignUp(){
    if(!_isSigningIn) {
      FocusScope.of(context).requestFocus(new FocusNode());
      if (signUpKey.currentState.validate()) {
        setState(() {
          _isSigningIn = true;
        });
        signUpApi.performSignUp(SignUpRequest(
            fullName: fullNameController.text,
            emailId: emailController.text,
            isdCode: "+" + selectedCountryCode.countryCode.toString(),
            phoneNo: int.parse(phoneNoController.text),
            password: passwordController.text
        ));
      }
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
    showOTPDialog(signUpResponse);
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
    selectedCountryCode = new CountryCodeData(countryCode: 91, countryCodeString: "IN", countryName: "India",
        countryImage:"https://www.countryflags.io/in/flat/16.png",displayText: "(IN) +91", phoneNumberLength: 10
    );
    signUpApi = SignUpApi(this);
    utilitiesAPI = UtilitiesAPI(this);
    utilitiesAPI.getCountryCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(myTitle: "Sign Up", context: context,),
      body: SafeArea(child:
        Container(
          child: Form(
            key: signUpKey,
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
                        Container(
                            height: 65,
                            child: ButtonTheme(
                              alignedDropdown: false,
                              child: DropdownButton<CountryCodeData>(
                                value: selectedCountryCode,
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
                                  });
                                },
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
                                    hintText: "Phone Number",
                                    suffixIcon: Icon(Icons.phone,
                                      color: Colors.blue,)
                                ),
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
                                }
                            ),
                          ),
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
                        suffixIcon: Icon(Icons.art_track,
                          color: Colors.blue,),

                      ),
                      controller: fullNameController,
                      validator: (value){
                        if(value == null || value.isEmpty)
                          return "Please enter full name";
                        else{
                          RegExp nameRxExp = new RegExp(
                            r"^[a-zA-Z]+\s{0,1}[a-zA-Z]*$",
                            caseSensitive: false,
                            multiLine: false,
                          );
                          if(!nameRxExp.hasMatch(value)) {
                            return "Please enter a valid name.";
                          }
                        }
                        return null;
                      },
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
                        suffixIcon: Icon(Icons.mail,
                          color: Colors.blue,),
                      ),
                      onChanged: (value){

                      },
                      controller: emailController,
                      validator: (value){
                        if(value == null || value.isEmpty)
                          return "Please enter Email Address";
                        else{
                          RegExp emailRxExp = new RegExp(
                            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$",
                            caseSensitive: false,
                            multiLine: false,
                          );
                          if(!emailRxExp.hasMatch(value)){
                            return "Please enter a valid email";
                          }
                        }
                        return null;
                      },
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
                          suffixIcon: Icon(Icons.remove_red_eye,
                            color: Colors.blue,)
                      ),
                      obscureText: true,
                      onChanged: (value){

                      },
                      controller: passwordController,
                      validator: (value){
                        if(value == null || value.isEmpty)
                          return "Please enter password";
                        return null;
                      },
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

  void showOTPDialog(SignUpResponse signUpResponse){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_){
        return OTPDialog(signUpResponse: signUpResponse,);
      }
    );
  }
}

class OTPDialog extends StatefulWidget{
  OTPDialog({Key key, this.signUpResponse}) : super(key:key);

  SignUpResponse signUpResponse;
  _OTPDialog createState() => _OTPDialog(signUpResponse);

}

class _OTPDialog extends State<OTPDialog> implements OTPCallBack{

  _OTPDialog(this.signUpResponse);

  SignUpResponse signUpResponse;

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

  OTPApi otpApi;
  bool _isOTPValidation = false;
  String otpError = "";

  @override
  void initState() {
    super.initState();
    otpApi = new OTPApi(this);
  }

  @override
  void onOTPSuccess(OTPResponse otpResponse) {
    setState(() {
      _isOTPValidation = false;
    });
    Navigator.of(context, rootNavigator: true).pop();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_){
          return SuccessDialog();
        }
    );
  }

  @override
  void onOTPFailure(String message) {
    setState(() {
      _isOTPValidation = false;
      otpError = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Container(
          height: 210,
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
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 5.0),
                        child: Text("Enter OTP",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue, fontSize: 14.0,),
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
                    child: Text(
                      otpError,
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
                    child: GestureDetector(
                      onTap: resendOTP,
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

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void validateOTP(){
    if(!_isOTPValidation) {
      setState(() {
        otpError = "";
      });
      FocusScope.of(context).requestFocus(new FocusNode());
      if (_otp1Controller.text != null && _otp2Controller.text != null &&
          _otp3Controller.text != null && _otp4Controller.text != null &&
          _otp5Controller.text != null && _otp6Controller.text != null) {
        setState(() {
          _isOTPValidation = true;
        });
        String otp = _otp1Controller.text + _otp2Controller.text
            + _otp3Controller.text + _otp4Controller.text
            + _otp5Controller.text + _otp6Controller.text;
        OTPRequest otpRequest = OTPRequest(
          isdCode: signUpResponse.data.isdCode,
          phoneNo: signUpResponse.data.phoneNo,
          otp: int.parse(otp),
        );
        otpApi.validateOTP(otpRequest);
      }
      else {
        setState(() {
          otpError = "OTP entered in invalid";
        });
      }
    }
  }

  void resendOTP(){
    //TODO
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
}

class SuccessDialog extends StatefulWidget{
  SuccessDialog({Key key}) : super(key:key);
  _SuccessDialog createState() => _SuccessDialog();
}

class _SuccessDialog extends State<SuccessDialog>{
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
        ),
        child: Container(
          height:220,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Image.asset("assets/images/success_image.png")
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Registration Successful",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context, rootNavigator: true).pop();
                        _navigationService.navigateTo(routes.HomeRoute);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            color: Colors.blue,
                          ),
                          Text("Home",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(right : 15.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context, rootNavigator: true).pop();
                        _navigationService.navigateTo(routes.LoginRoute);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.people,
                            color: Colors.blue,
                          ),
                          Text("Login",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    )
                  ),

                ],
              )
            ],
          )
        )
    );
  }
}