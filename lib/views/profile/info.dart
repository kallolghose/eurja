import 'package:eurja/models/profile/loginmodels.dart';
import 'package:flutter/material.dart';
import 'package:eurja/utilities/mycomponents.dart';

class InfoPage extends StatefulWidget{
  InfoPage({Key key}) : super(key:key);

  @override
  _InfoPage createState() => _InfoPage();
}

class _InfoPage extends State<InfoPage>{

  final AppUtilities _appUtilities = AppUtilities();
  TextEditingController fullNameController;
  TextEditingController dobController;
  TextEditingController emailController;
  String _gender = "M";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fullNameController = new TextEditingController();
    dobController = TextEditingController();
    emailController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(myTitle: "My Profile", context: context,),
      body: SafeArea(
        child: FutureBuilder<LoginResponse>(
          future: _appUtilities.restoreLoginInformation(),
          builder: (BuildContext buildContext, AsyncSnapshot<LoginResponse> snapshot){
            Widget child;
            if(snapshot.hasData){
              LoginData loginData = snapshot.data.data;
              if(loginData.firstName !=null)
                fullNameController.text = loginData.firstName + " " + loginData?.lastName;
              emailController.text = loginData.emailId;
              _gender = loginData.userAdditionalInfo.gender;
              dobController.text = _appUtilities.getFormattedDate(loginData.userAdditionalInfo.dateOfBirth, "yyyy-MM-dd");
              child = CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Row(
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child :
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(Icons.account_box, color: Colors.blue,)),
                                  )
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Full Name",
                                  labelText: "Full Name",
                                  contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  isDense: true
                                ),
                                controller: fullNameController,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child :
                                Padding(
                                    padding: EdgeInsets.all(5),
                                    child:Icon(Icons.email, color: Colors.blue,))
                                )
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  labelText: "Email",
                                  contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  isDense: true
                                ),
                                controller: emailController,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child : Icon(Icons.date_range, color: Colors.blue,)),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Date of Birth",
                                  labelText: "Date of Birth",
                                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  isDense: true
                                ),
                                controller: dobController,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(Icons.merge_type, color: Colors.blue,)
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 70,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: InkWell(
                                          onTap: () => setState(() => _gender = "M"),
                                          child: Container(
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                              border: Border.all(
                                                  color: Colors.blue,
                                                  width: 1
                                              ),
                                              color: _gender == "M" ? Colors.blue : Colors.transparent,
                                            ),
                                            child: ImageIcon(
                                              AssetImage("assets/images/ic_male.png"),
                                              color: _gender == "M" ? Colors.white : Colors.blue,
                                              size: 20,
                                            ),
                                          )
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () => setState(() => _gender = "F"),
                                        child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                            border: Border.all(
                                                color: Colors.blue,
                                                width: 1
                                            ),
                                            color: _gender == "F" ? Colors.blue : Colors.transparent,
                                          ),
                                          child: ImageIcon(
                                            AssetImage("assets/images/ic_female.png"),
                                            color: _gender == "F" ? Colors.white : Colors.blue,
                                            size: 20,
                                          ),
                                        )
                                      )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(10),
                                        child: InkWell(
                                            onTap: () => setState(() => _gender = "O"),
                                            child: Container(
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                border: Border.all(
                                                    color: Colors.blue,
                                                    width: 1
                                                ),
                                                color: _gender == "O" ? Colors.blue : Colors.transparent,
                                              ),
                                              child: Icon(
                                                Icons.devices_other,
                                                color: _gender == "O" ? Colors.white : Colors.blue,
                                                size: 20,
                                              ),
                                            )
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: MaterialButton(
                                    onPressed: (){},
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    child: Text("Update"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0)
                                    )
                                ),
                              ),
                            )
                          ],
                        )
                      ]
                    ),
                  ),
                ],
              );
            }
            else if(snapshot.hasError){
              //Move to Temporary Unavailable Page
            }
            else{
              child = Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 40,
                    height: 40,
                  )
                ],
              );
            }
            return Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
              child: child,
            );
          },
        ),
      )
    );
  }
}