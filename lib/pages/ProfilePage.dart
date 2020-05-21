

import 'package:Capturoca/models/user.dart';
import 'package:Capturoca/pages/HomePage.dart';
import 'package:Capturoca/widgets/HeaderWidget.dart';
import 'package:Capturoca/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'EditProfilePage.dart';

class ProfilePage extends StatefulWidget {
  final String userProfileId;
  ProfilePage({this.userProfileId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String currentOnlinUserId = currentUser.id;
  
  createProfileTopView(){
    return FutureBuilder(
      future: usersReference.document(widget.userProfileId).get(),
      builder: (context, dataSnapshot){
        if(!dataSnapshot.hasData)
        {
          return circularProgress();

        }
        User user =User.fromDocument(dataSnapshot.data);
        return Padding(
          padding: EdgeInsets.all(17.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: CachedNetworkImageProvider(user.url),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            createColumns("Posts",0),
                            createColumns("Followers",0),
                            createColumns("Following",0),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            createButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top:13.0),
                child: Text(
                  user.username,style: TextStyle(fontSize: 14.0,color: Colors.black)
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top:5.0),
                child: Text(
                  user.profileName,style: TextStyle(fontSize: 18.0,color: Colors.black)
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top:3.0),
                child: Text(
                  user.bio ,style: TextStyle(fontSize: 15.0,color: Colors.black)
                ),
              ),
            ],
          ),
        );

    },);
  }

  createColumns(String title, int count){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(count.toString(),
        style: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(title,
            style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w300),

          ),
        ),
      ],
    );

  }

  createButton(){
    bool ownProfile = currentOnlinUserId == widget.userProfileId;
    if(ownProfile){
      return createButtonTitleAndFunction(title: "Edit Profile", performFunction: editUserProfile,);
    }
  }
// createButtonTitleAndFunction(title: "Edit Profile", performFunction: editUserProfile,);
  createButtonTitleAndFunction({String title, Function performFunction}){
    return Container(
      
      child: FlatButton(
        onPressed: performFunction,
        child: Container(
          
          width: 200.0,
          height: 26.0,
          child: Text(title, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(color:Colors.black,border:Border.all(color:Colors.grey),
          borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }

  editUserProfile() async{
    var navigationResult =  await Navigator.push(context,new  MaterialPageRoute(builder: (context)=> EditProfilePage(currentOnlineUserId: currentOnlinUserId)));
    // Navigator.push(context, MaterialPageRoute(builder: (context)=> new EditProfilePage(currentOnlineUserId: currentOnlinUserId)));
    // Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new EditProfilePage(currentOnlineUserId: currentOnlinUserId)),);
    if(navigationResult)
    {
        showDialog(context: context,builder:(context){Future.delayed(Duration(seconds: 2), () {
                          Navigator.of(context).pop(true);
                        });return AlertDialog(title:Text('Succesfully Saved'),);});
        
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,strTitle: "Profile",),
      body: ListView(
        children: <Widget>[
          createProfileTopView(),
        ],
      ),
    );
  }
}
