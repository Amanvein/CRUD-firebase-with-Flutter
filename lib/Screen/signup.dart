import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;
  //FirebaseUser user ;

  TextEditingController emailid = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone_no = TextEditingController();

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
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            )
          ],
        ),
      ),
    );
  }

  Widget user_password() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              obscureText: true,
              controller: password,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            )
          ],
        ),
      ),
    );
  }

  Widget phone_user() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: phone_no,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: "email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            )
          ],
        ),
      ),
    );
  }

  Widget newUserBtn() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            RaisedButton(child: Text("Done"), onPressed: new_User)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  text_Email(),
                  phone_user(),
                  user_password(),
                  newUserBtn(),
                ],
              ),
            )),
      ),
    );
  }

  new_User() async {
    try {
      final AuthResult authResult =
          (await firebaseAuth.createUserWithEmailAndPassword(
              email: emailid.text, password: password.text));

      final FirebaseUser user = authResult.user;
      firestore.collection("user").document(user.uid).setData({
        "emailid": emailid.text,
        "phone No": phone_no.text,
        "userUID": user.uid
      });
    } catch (e) {
      print("pppppppppppppppppppppppppppppppp${e}");
    }
  }
}
