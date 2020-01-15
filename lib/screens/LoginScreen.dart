import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  Future<FirebaseUser> login(String email, String pass) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;

      return user;
    }catch(e){
      print(e);
      return null;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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

                Container(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text("Login"),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    onPressed: () async{
                      final email = _emailController.text.toString().trim();
                      final pass = _passController.text.toString().trim();

                      FirebaseUser user = await login(email, pass);

                      if(user != null){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen(name: user.displayName, imageUrl: user.photoUrl,)
                        ));
                      }else{
                        print("Eror");
                      }

                    },
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
