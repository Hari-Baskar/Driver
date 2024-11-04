import 'package:driver/widgets.dart';
import 'package:flutter/material.dart';
class Passengers extends StatefulWidget {
  const Passengers({super.key});

  @override
  State<Passengers> createState() => _PassengersState();
}

class _PassengersState extends State<Passengers> {
  bool Checked=true;
  var divHeight,divWidth;
  bool selected=true;
  List passenger=[
    {"studentName":"Praveen","classAndSec":"X-C","studentId":"Sec21it053","checked":true},
    {"studentName":"Vasanth","classAndSec":"X-C","studentId":"Sec21it053","checked":true},
    {"studentName":"Madhu","classAndSec":"X-C","studentId":"Sec21it053","checked":true},
    {"studentName":"Ashwin","classAndSec":"X-C","studentId":"Sec21it053","checked":true},
    {"studentName":"Ajith","classAndSec":"X-C","studentId":"Sec21it053","checked":true},
  ];
  List upcoming=[
    {"studentName":"Pranau","classAndSec":"X-C","studentId":"Sec21it053","checked":false},
    {"studentName":"HariRaj","classAndSec":"X-C","studentId":"Sec21it053","checked":false},
    {"studentName":"Roshin","classAndSec":"X-C","studentId":"Sec21it053","checked":false},
    {"studentName":"Yoge","classAndSec":"X-C","studentId":"Sec21it053","checked":false},
    {"studentName":"Aakash","classAndSec":"X-C","studentId":"Sec21it053","checked":false},
  ];
  TextEditingController studentId=TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(selected);
    divHeight=MediaQuery.of(context).size.height;
    divWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change the drawer icon color to white
        ),
        backgroundColor: Color(0xFF00A0E3),
        centerTitle: true,
        title: TextWidget(text: 'Passengers', fontWeight: FontWeight.bold, fontsize: divHeight*0.02, fontColor: Colors.white),

      ),
       body: SingleChildScrollView(child:Padding(padding: EdgeInsets.all(15),

       child: Column(
         crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             Row(children: [

               TextWidget(text: "Student Id :", fontWeight: FontWeight.w500, fontsize: divHeight*0.022, fontColor: Colors.black),
               Spacer(),
               Container(
                   width: divWidth*0.6,
                   child:
                   TextFieldWidget(hintText: "", control: studentId,)),

             ],),
             SizedBox(height: divHeight*0.02,),
             //StudentIdBox(),
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

                     child:SwitchButtonWidget(title: "Passengers", Selected: selected)
                 ),
                 InkWell(
                   onTap:(){
                     setState(() {
                       selected=!selected;
                     });
                   },
                   child:SwitchButtonWidget(title: "Upcoming", Selected: !selected),
                 )
               ],
             ),),
             SizedBox(height: divHeight*0.02,),
selected ?              Container(
    height: divHeight*0.55,
    child:ListView.separated(

               separatorBuilder: (context,index){return SizedBox(height: divHeight*0.02,);},
               shrinkWrap: true,

               itemCount: passenger.length,itemBuilder: (context,index){
               return StudentIdBox(studentName: passenger[index]["studentName"], classAndSec: passenger[index]["classAndSec"], studentId: passenger[index]["studentId"], checked: passenger[index]["checked"], index: index);
             },)):             Container(
  height: divHeight*0.65,
  child:ListView.separated(
               separatorBuilder: (context,index){return SizedBox(height: divHeight*0.02,);},
               shrinkWrap: true,
               itemCount: upcoming.length,itemBuilder: (context,index){
               return StudentIdBox(studentName: upcoming[index]["studentName"], classAndSec: upcoming[index]["classAndSec"], studentId: upcoming[index]["studentId"], checked: upcoming[index]["checked"], index: index);
             },),

    ),
             SizedBox(height: divHeight*0.1,)

         ],
       ),),

       ),
       floatingActionButton: selected ?Padding(padding:EdgeInsets.symmetric(horizontal: 15),child:Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             SizedBox(width: divWidth*0.04,),
         TextWidget(text: "Count : 23", fontWeight: FontWeight.bold, fontsize: divHeight*0.02, fontColor: Colors.green),
         Spacer(),
         FloatingActionButton.extended(
           backgroundColor: Color(0xFF00A0E3),
           onPressed: (){},label:InkWell(
             onTap: (){},
             child: ButtonWidget(buttonName: "Submit All", buttonWidth: divWidth*0.4, buttonColor:Color(0xFF00A0E3) , fontSize: divHeight*0.017, fontweight: FontWeight.w500, fontColor: Colors.white)))]
       )):null ,
    );
  }
  StudentIdBox({
    required String studentName,
    required String classAndSec,
    required String studentId,
    required bool checked,
    required int index,
}){
    return
       Container(
        padding:  EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1.0)
        ),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextWidget(text:  studentName, fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
                  TextWidget(text: classAndSec, fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black45),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(text: studentId, fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor:Color(0xFF00A0E3) ),
                  //TextWidget(text: "1.00 pm", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

              checked ?  Icon(Icons.check_box_outlined,color: Colors.green,): IconButton(icon:Icon(Icons.check_box_outline_blank_rounded,color: Colors.black,)  , onPressed: () {
                   setState(() {
                    // checked=!checked;
                     passenger.insert(0,{"studentName":upcoming[index]["studentName"],"classAndSec":upcoming[index]["classAndSec"],"checked":true,"studentId":upcoming[index]["studentId"]});
                     upcoming.removeAt(index);
                   });
                 } ,),
                  checked ? IconButton(onPressed: (){
                    setState(() {
                    //  Map passen=passenger[index]['checked'];
                      upcoming.insert(0,{"studentName":passenger[index]["studentName"],"classAndSec":passenger[index]["classAndSec"],"checked":false,"studentId":passenger[index]["studentId"]});
                      passenger.removeAt(index);
                    });

                  }, icon: Icon(Icons.delete_outline_outlined,color: Colors.redAccent,)) : Text(""),
                ],
              ),
            ),
          ],
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
