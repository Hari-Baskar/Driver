import 'package:driver/widgets.dart';
import 'package:flutter/material.dart';
class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  var divHeight,divWidth;
  TextEditingController situation=TextEditingController();
  @override
  Widget build(BuildContext context) {
    divHeight=MediaQuery.of(context).size.height;
    divWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change the drawer icon color to white
        ),
        backgroundColor: Color(0xFF00A0E3),
        centerTitle: true,
        title: TextWidget(text: 'Emergency', fontWeight: FontWeight.bold, fontsize: divHeight*0.02, fontColor: Colors.white),

      ),
      body: SingleChildScrollView(child: Padding(padding: EdgeInsets.all(15),child:Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [

            TextWidget(text: "Situation  :", fontWeight: FontWeight.w500, fontsize: divHeight*0.022, fontColor: Colors.black),
            Spacer(),
            Container(
                width: divWidth*0.6,
                child:
                TextFieldWidget(hintText: "", control: situation,)),

          ],),
          SizedBox(height: divHeight*0.02,),
          ButtonWidget(buttonName: "Send to parents and school", buttonWidth: divWidth*0.7, buttonColor: Colors.red, fontSize: divHeight*0.017, fontweight: FontWeight.w500, fontColor: Colors.white),
          SizedBox(height: divHeight*0.02,),
          ButtonWidget(buttonName: " send only school", buttonWidth: divWidth*0.4, buttonColor: Colors.red, fontSize: divHeight*0.017, fontweight: FontWeight.w500, fontColor: Colors.white)
        ],
      ),),),
    );
  }
}
