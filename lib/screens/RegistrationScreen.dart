import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user_login/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();

  Future<bool> registerUser(String email, String pass, String name, String url) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;

      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = name;
      info.photoUrl = url;

      user.updateProfile(info);

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
                  Text("Registration", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

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
                        hintText: "Email"

                    ),
                    controller: _emailController,
                  ),

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
                        hintText: "Password"

                    ),

                    controller: _passController,
                  ),

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
                        hintText: "Display Name"

                    ),

                    controller: _nameController,
                  ),

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
                        hintText: "Photo Url"

                    ),

                    controller: _imageController,
                  ),

                  SizedBox(height: 16,),

                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text("Register"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () async{
                        final email = _emailController.text.toString().trim();
                        final pass = _passController.text.toString().trim();
                        final name = _nameController.text.toString().trim();
                        final url = _imageController.text.toString().trim();

                        bool result = await registerUser(email, pass, name, url);

                        if(result){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()
                          ));
                        }else{
                          print("Error");
                        }
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
