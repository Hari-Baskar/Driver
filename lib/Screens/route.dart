import 'package:driver/widgets.dart';
import 'package:flutter/material.dart';
class RoutePath extends StatefulWidget {
  const RoutePath({super.key});

  @override
  State<RoutePath> createState() => _RoutePathState();
}

class _RoutePathState extends State<RoutePath> {
  var divHeight,divWidth;
  bool selected=true;
  TextEditingController From =TextEditingController();
  TextEditingController To =TextEditingController();
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
        title: TextWidget(text: 'Route', fontWeight: FontWeight.bold, fontsize: divHeight*0.02, fontColor: Colors.white),

      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(15),child: Column(
          children: [
            Container(
              width: divWidth*0.90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.0,color:Color(0xFF00A0E3) ),
                  color: Colors.white
              ),
              child: Row(
                children: [
                  InkWell(
                      onTap:(){
                        setState(() {
                          selected=!selected;

                        });
                      },

                      child:SwitchButtonWidget(title: "PickUp", Selected: selected)
                  ),
                  InkWell(
                    onTap:(){
                      setState(() {
                        selected=!selected;
                      });
                    },
                    child:SwitchButtonWidget(title: "Drop", Selected: !selected),
                  )
                ],
              ),),
            SizedBox(height: divHeight*0.02,),
            TextFieldWidget(hintText: "From", control: From,prefixIcon: Icon(Icons.location_on_outlined,color: Colors.red,)),
            SizedBox(height: divHeight*0.02,),
            TextFieldWidget(hintText: "To", control: To,prefixIcon: Icon(Icons.location_on_outlined,color: Colors.green,)),
            SizedBox(height: divHeight*0.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonWidget(buttonName: "Edit Route", buttonWidth: divWidth*0.4, buttonColor: Colors.red, fontSize: divHeight*0.017, fontweight: FontWeight.bold, fontColor: Colors.white),
                ButtonWidget(buttonName: "Show Route", buttonWidth: divWidth*0.4, buttonColor: Color(0xFF00A0E3), fontSize: divHeight*0.017, fontweight: FontWeight.bold, fontColor: Colors.white),

              ],
            )
          ],
        ),),
      ),
    );
  }
  SwitchButtonWidget({
    required String title,
    required bool Selected
  }){
    return Container(
      height: divHeight*0.08,
      width: divWidth*0.447,
      decoration: BoxDecoration(
          color: Selected?   Color(0xFF00A0E3):Colors.transparent,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: TextWidget(text: title, fontWeight: FontWeight.w700, fontsize: divHeight*0.017, fontColor:Selected? Colors.white:Colors.black ),
      ),
    );
  }
}
