import 'package:driver/Screens/detailedHistory.dart';
import 'package:driver/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool selected=true;
  var divHeight,divWidth;
  TextEditingController fromdate=TextEditingController();
  TextEditingController todate=TextEditingController();
  setDate({
    required TextEditingController control,
})async{
    final DateTime? picked=await showDatePicker(context: context,initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(3000)) as DateTime?;
    if (picked!=null){
      setState(() {
        control.text=DateFormat("yyyy-MM-dd").format(picked);
      });

    }
  }
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
        title: TextWidget(text: 'History', fontWeight: FontWeight.bold, fontsize: divHeight*0.02, fontColor: Colors.white),

      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(15),child: Column(
          crossAxisAlignment:  CrossAxisAlignment.end,
          children: [
           Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children:[ Container(
                width: divWidth*0.45,
                child:TextFieldWidget(

                  suffixIcon: Icon(Icons.calendar_month_sharp,),
                    hintText: "From", control:fromdate,readonly: true,OnClick: () async{
             await  setDate(control: fromdate);
            })
            ),
             Container(
                 width: divWidth*0.45,
                 child:TextFieldWidget(
                     suffixIcon: Icon(Icons.calendar_month_sharp),
                     hintText: "To", control:todate,readonly: true,OnClick: () async{
                   await  setDate(control: todate);
                 })
             ),
          ]
           ),
            SizedBox(height: divHeight*0.02,),
            ButtonWidget(buttonName: "Get Details", buttonWidth: divWidth*0.4, buttonColor: Colors.red, fontSize: divHeight*0.017, fontweight: FontWeight.bold, fontColor: Colors.white),
            SizedBox(height: divHeight*0.02,),
            Container(
              width: divWidth*0.90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.0,color: Color(0xFF00A0E3)),
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
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context,index){
              return  ViewBox(Date: "12/10/2024");
            }, separatorBuilder: (context,index){
              return SizedBox(height: divHeight*0.015,);
            }, itemCount: 4)

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
  ViewBox({
    required String Date
}){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1.0)
      ),
      child:ListTile(title: TextWidget(text: Date, fontWeight: FontWeight.w700, fontsize: divHeight*0.017, fontColor: Colors.black),trailing:InkWell(
          onTap: (){
            Get.to(()=>DetailedHistory(),transition: Transition.zoom, duration: Durations.medium4);

          },
          child:TextWidget(text: 'View Details', fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Color(0xFF00A0E3) ) )),);
  }
}
