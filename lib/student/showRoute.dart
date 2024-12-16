import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:driver/Custom_Widgets/loading.dart';
import 'package:driver/Services/auth_Service.dart';
import 'package:driver/Services/db_Service.dart';
import 'package:driver/student/showSelectedRoute.dart';
import 'package:flutter/material.dart';
class ShowRoute extends StatefulWidget {
  const ShowRoute({super.key});

  @override
  State<ShowRoute> createState() => _ShowRouteState();
}

class _ShowRouteState extends State<ShowRoute> {
  DBService dbService=DBService();
  late double divHeight,divWidth;
  @override
  Widget build(BuildContext context) {
    divHeight=MediaQuery.of(context).size.height;
    divWidth=MediaQuery.of(context).size.width;
    return StreamBuilder(stream: dbService.getRoutes(), builder: (context,snapshots){
      if(!snapshots.hasData) return Scaffold(body:Loading());
      QuerySnapshot querySnapshot=snapshots.data;
      List<DocumentSnapshot> documents=querySnapshot.docs;
      return Scaffold(
        appBar: appBarWidget(title: "Available Van routes", fontsize: divHeight*0.017),
        body:SingleChildScrollView(child:Padding(padding:EdgeInsets.all(15), child:Column(children:[ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context,index){
          String routeName=documents[index].id;
          return Padding(padding:EdgeInsets.symmetric(vertical: 5),child:InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowSelectedRoute(selectedRoute:routeName )));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.circular(10)
              ),
              child:ListTile(
              
              leading: textWidget(text: (index+1).toString() , fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: black),
              title:textWidget(text: routeName , fontWeight: FontWeight.bold, fontsize: divHeight*0.017, fontColor: black),
              trailing: Icon(Icons.chevron_right),
            ),
            )
          )
          );
        },
          itemCount: documents.length,

        ),
          InkWell(
            onTap: (){
              AuthService().logOut();
            },
            child: Text("Logout"),
          )
      ]
        )
        )
      )
      );


    });
  }
}
