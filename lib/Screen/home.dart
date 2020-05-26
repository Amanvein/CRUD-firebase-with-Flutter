import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  TextEditingController update = TextEditingController();
  var token;
  Home({Key key,  this.token}) : super(key: key);

  Firestore firestore = Firestore.instance;

 Widget textField(){
   return Container(
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         children: <Widget>[
           TextField(
             controller: update,
           )
         ],
       ),
     ),
   );
 }

 Widget updateBtn(){
   return Container(
     child: Column(
       children: <Widget>[
         RaisedButton(
           child: Text("UPdate"),
           onPressed: updateData)
       ],
     ),
   );
 }
 Widget deleteBtn(){
   return Container(
     child: Column(
       children: <Widget>[
         RaisedButton(
           child: Text("Delete"),
           onPressed: deleteData)
       ],
     ),
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: 
        Center(
            child: 
            StreamBuilder(
          stream: Firestore.instance.collection('user').document(token).snapshots(),
          builder: (context, snapshot) {
            return Container(
              child: Column(
                children: <Widget>[
                  Text(snapshot.data['emailid']),
                  Text(snapshot.data['phone No']),
                  textField(),
                  updateBtn(),
                  deleteBtn(),
                ],
              ),
                );
          },
        )),
      ),
    );
  }
  void updateData(){
    try {
      firestore.collection("user").document(token).updateData({"emailid":update.text});
    } catch (e) {
      print(e);
    }
  }

  void deleteData(){
    try {
      firestore.collection("user").document(token).delete();
    } catch (e) {
      print(e);
    }
  }  
}
