import 'package:CRUD/Screen/home.dart';
import 'package:CRUD/Screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    home: Scaffold(
      body: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailid = TextEditingController();
  TextEditingController password = TextEditingController();

  Widget text_Email() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailid,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.perm_identity),
                  hintText: "email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            )
          ],
        ),
      ),
    );
  }

  Widget text_password() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              obscureText: true,
              controller: password,
              decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            )
          ],
        ),
      ),
    );
  }

  Widget loginBtn() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            RaisedButton(child: Text("Done"), onPressed: Login)
          ],
        ),
      ),
    );
  }

  Widget createUser() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Text("Signup"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                text_Email(),
                text_password(),
                loginBtn(),
                createUser(),
              ],
            ),
          )),
    );
  }

  Future Login() async {
    try {
     final AuthResult authResult = await firebaseAuth
          .signInWithEmailAndPassword(
              email: emailid.text, password: password.text);
              final FirebaseUser user = authResult.user;
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(token: user.uid)));
              print(user.uid);
    } catch (e) {}
  }
}
