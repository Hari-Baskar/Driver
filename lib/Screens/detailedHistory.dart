import 'package:driver/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class DetailedHistory extends StatefulWidget {
  const DetailedHistory({super.key});

  @override
  State<DetailedHistory> createState() => _DetailedHistoryState();
}

class _DetailedHistoryState extends State<DetailedHistory> {
  var divHeight,divWidth;
  @override
  Widget build(BuildContext context) {
    divHeight=MediaQuery.of(context).size.height;
    divWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_month_sharp,color:Color(0xFF00A0E3) ,size: divHeight*0.04,),
            SizedBox(width: divWidth*0.01,),
            TextWidget(text: "Date", fontWeight: FontWeight.w900, fontsize: divHeight*0.02, fontColor: Color(0xFF00A0E3) ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(15),child: Column(
          children: [
            Row(children: [
              Image.asset("Assets/speed.png",height: divHeight*0.025,color: Colors.blueGrey,),
              SizedBox(width: divWidth*0.015,),
              TextWidget(text: "Speed Limit", fontWeight: FontWeight.bold, fontsize: divHeight*0.019, fontColor: Colors.black),



            ],),
            Container(
              height: divHeight*0.30,

              child:
              SfCartesianChart(

                primaryXAxis: NumericAxis(),
                primaryYAxis: NumericAxis(),
                series: <CartesianSeries>[
                  SplineSeries<Map<String, double>, double>(
                    dataSource: [
                      {'x': 0, 'y': 10},
                      {'x': 1, 'y': 7},
                      {'x': 2, 'y': 10},
                      {'x': 3, 'y': 8},
                      {'x': 4, 'y': 6},
                      {'x': 5, 'y': 4},
                      {'x': 6, 'y': 5},
                      {'x': 7, 'y': 7},
                      {'x': 8, 'y': 10},
                      {'x': 10, 'y': 8},
                      {'x': 12, 'y': 6},
                      {'x': 14, 'y': 4},
                    ],
                    xValueMapper: (Map<String, double> data, _) => data['x']!,
                    yValueMapper: (Map<String, double> data, _) => data['y']!,
                    color: Colors.blue,
                    width: 2,
                  ),
                ],
              ),
            ),
            SizedBox(height: divHeight*0.04,),
            Row(children: [
              Image.asset("Assets/ticket.png",height: divHeight*0.02,color: Colors.green,),
              SizedBox(width: divWidth*0.015,),
              TextWidget(text: "Tickets", fontWeight: FontWeight.bold, fontsize: divHeight*0.019, fontColor: Colors.black),Spacer(),

            ],),
            SizedBox(height: divHeight*0.01,),
            TicketBox(),
            SizedBox(height: divHeight*0.04,),
            Row(children: [
              Image.asset("Assets/groups.png",height: divHeight*0.02,color: Colors.deepPurple,),
              SizedBox(width: divWidth*0.015,),
              TextWidget(text: "Passengers", fontWeight: FontWeight.bold, fontsize: divHeight*0.019, fontColor: Colors.black),Spacer(),

            ],),

            SizedBox(height: divHeight*0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              TextWidget(text: "Present : 30", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.green),
                TextWidget(text: "Absent : 4", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.red),
              ],
            ),
            SizedBox(height: divHeight*0.01,),
            StudentIdBox(studentName: "Praveen", classAndSec: "X-C", studentId: "Sec21it053", checked:true),
            SizedBox(height: divHeight*0.015,),
            StudentIdBox(studentName: "Baskar", classAndSec: "X-C", studentId: "Sec21it053",checked:false),
          ],
        ),),
      ),
    );
  }
  TicketBox(){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(15)
      ),
      child: Container(
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

                  TextWidget(text: "Ticket Name ", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
                  TextWidget(text: "5000", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.green),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextWidget(text: "1.00 pm", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(text: "Approved", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.green),
                  TextWidget(text: "1.30 pm", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  StudentIdBox({
    required String studentName,
    required String classAndSec,
    required String studentId,
   required bool checked,
   // required int index,
  }){
    return
      Container(
        padding:  EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1.0,color: checked ? Colors.green:Colors.red)
        ),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [


                  TextWidget(text:  studentName, fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),

                  TextWidget(text: studentId, fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor:Color(0xFF00A0E3) ),
                  //TextWidget(text: "1.00 pm", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
            TextWidget(text: classAndSec, fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black45),
          ],
        ),


      );
  }
}
