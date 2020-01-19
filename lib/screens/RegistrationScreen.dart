import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user_login/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();

  static AuthCredential _credential;
  static String verificationId;
  static int code;
  static String smsCode;

  Future<bool> showDialogForOTP(context){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Enter SMS Code"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _codeController,
            ),

          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Done"),
            textColor: Colors.white,
            color: Colors.redAccent,
            onPressed: () async{
              FirebaseAuth auth = FirebaseAuth.instance;

              smsCode = _codeController.text.trim();

              _credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);
              auth.signInWithCredential(_credential).then((AuthResult result){
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (BuildContext context) => HomeScreen(user: result.user,)),
                    ModalRoute.withName('/'));
              }).catchError((e){
                print(e);
              });
            },
          )
        ],
      )
    );
  }




  final PhoneVerificationFailed _verificationFailed = (AuthException authException){
    print(authException.message);
  };


  final PhoneCodeAutoRetrievalTimeout _autoRetrievalTimeout = (String verificationId){
    verificationId = verificationId;
    print(verificationId);
    print("Timout");
  };

  Future registerUser(String mobile, BuildContext context) async{

    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
       _auth.verifyPhoneNumber(
          phoneNumber: mobile,
          timeout: Duration(seconds: 60),
          verificationCompleted: (AuthCredential authCredential) async{
            FirebaseAuth _auth = FirebaseAuth.instance;
            _credential = authCredential;

            _auth.signInWithCredential(_credential).then((AuthResult result){
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) => HomeScreen(user: result.user,)),
                  ModalRoute.withName("/"));
            }).catchError((e){
              print(e);
            });
          },


          verificationFailed: _verificationFailed,


          codeSent: (String verificationId, [int forceResendingToken]){
            verificationId = verificationId;
            code = forceResendingToken;
            print("token = $code");
            print("verificationId = $verificationId");
            showDialogForOTP(context);
          },
          codeAutoRetrievalTimeout: _autoRetrievalTimeout
      );




      return true;
    }catch(e){
      print(e);
      return false;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Login", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

                  SizedBox(height: 16,),

                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Mobile Number"

                    ),
                    controller: _emailController,
                  ),

                  SizedBox(height: 16,),


                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text("Register"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () async{
                        final email = _emailController.text.trim();

                        registerUser(email, context);
                      },
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
