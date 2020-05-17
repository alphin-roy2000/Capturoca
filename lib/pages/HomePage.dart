import 'dart:ui';

import 'package:Capturoca/pages/NotificationsPage.dart';
import 'package:Capturoca/pages/ProfilePage.dart';
import 'package:Capturoca/pages/SearchPage.dart';
import 'package:Capturoca/pages/TimeLinePage.dart';
import 'package:Capturoca/pages/UploadPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn gSignIn = GoogleSignIn();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
// class _HomePageState extends State<HomePage> {
//   bool _isLoggedIn = false;

//   GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

//   _login() async{
//     try{
//       await _googleSignIn.signIn();
//       setState(() {
//         _isLoggedIn = true;
//       });
//     } catch (err){
//       print(err);
//     }
//   }

//   _logout(){
//     _googleSignIn.signOut();
//     setState(() {
//       _isLoggedIn = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//             child: _isLoggedIn
//                 ? Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Image.network(_googleSignIn.currentUser.photoUrl, height: 50.0, width: 50.0,),
//                       Text(_googleSignIn.currentUser.displayName),
//                       OutlineButton( child: Text("Logout"), onPressed: (){
//                         _logout();
//                       },)
//                     ],
//                   )
//                 : Center(
//                     child: OutlineButton(
//                       child: Text("Login with Google"),
//                       onPressed: () {
//                         _login();
//                       },
//                     ),
//                   )),
//       ),
//     );
//   }
// }
class _HomePageState extends State<HomePage> 
{
   bool isSignedIn = false;

  //  GoogleSignIn _googleSignIn = GoogleSignIn();

  //  _login() async {
  //    try {
  //      await _googleSignIn.signIn();
  //      setState(() {
  //        isLoggedIn=true;
  //      });
  //    }
  //    catch(err){
  //      print(err);
  //    }
  //  }
   
  //  _logout() async{
  //    _googleSignIn.signOut();
  //    setState(() {
  //      isLoggedIn =false;
  //    });
  //  }
  void initState(){
    super.initState();

    gSignIn.onCurrentUserChanged.listen((gSigninAccount){
      controlSignIn(gSigninAccount);
    }, onError: (gError){
      print("Error Message: " + gError);
    });

    // gSignIn.signIn().then((gSignInAccount){
    //   controlSignIn(gSignInAccount);
    // });
  }

  controlSignIn(GoogleSignInAccount signInAccount) async{
    if(signInAccount !=null)
    {
      setState(() {
        isSignedIn = true;

      });
    }
    else{
      setState(() {
        isSignedIn =false;
      });
    }
  }

  loginUser(){
    gSignIn.signIn();
  }

  logoutUser(){
    gSignIn.signOut();
  }



    Scaffold buildHomeScreen(){
      return Scaffold(
        body: PageView(
          children: <Widget>[
            TimeLinePage(),
            SearchPage(),
            UploadPage(),
            NotificationsPage(),
            ProfilePage(),
          ],
        ),
      );
     //return RaisedButton.icon(onPressed: logoutUser, icon: Icon(Icons.close), label: Text("Sign Out"));
   }

  Scaffold buildSignInScreen(){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( 
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Theme.of(context).accentColor,Theme.of(context).primaryColor]
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Capturoca",
              style: TextStyle(fontSize: 92.0, color: Colors.lightBlueAccent,fontFamily: "Signatra"),
            ),
            GestureDetector(
              onTap: ()=> loginUser(),
              child: Container(
                width: 270.0,
                height: 65.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/google_signin_button.png"),
                    fit: BoxFit.cover,
                  )
                )
              )
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(isSignedIn)
    {
      return buildHomeScreen();
    }
    else
    {
      return buildSignInScreen();
    }
  }
}



