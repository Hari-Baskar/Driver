import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:driver/Services/db_Service.dart';
import 'package:driver/userManagement/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailedHistory extends StatefulWidget {
  final String docId;
  final String uid;
  const DetailedHistory({super.key, required this.docId,  required this.uid});

  @override
  State<DetailedHistory> createState() => _DetailedHistoryState();
}

class _DetailedHistoryState extends State<DetailedHistory> {
  late double divHeight, divWidth;
  Map<String,dynamic>? data;
  DBService dbService=DBService();
  List<dynamic> ticket=[];
  List<dynamic> pickupPassengersList=[];
  List<dynamic> dropPassengersList=[];
  List<dynamic> totalPassengerId=[];

  documentDetails()async{
    DocumentSnapshot documentSnapshot=await dbService.getDocumentDetails(uid: widget.uid, docId: widget.docId);


    setState(() {
     data=documentSnapshot.data() as Map<String,dynamic>;

     dynamic ticketList=data!["ticket"];
     dynamic pickupList=data!["pickupPassengersList"];
     dynamic dropList=data!["dropPassengersList"];
     ticket=ticketList!=null ? ticketList:[];
     pickupPassengersList=pickupList!=null ? pickupList : [];
     dropPassengersList=dropList!=null ? dropList:[];
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    documentDetails();


  }
bool select=true;
String? userId;
  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;
   final user=Provider.of<User?>(context);
   userId=user!.uid;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_month_sharp,
              color: const Color(0xFF00A0E3),
              size: divHeight * 0.04,
            ),
            SizedBox(
              width: divWidth * 0.01,
            ),
            textWidget(
                text: widget.docId,
                fontWeight: FontWeight.w900,
                fontsize: divHeight * 0.02,
                fontColor: const Color(0xFF00A0E3)),
          ],
        ),
      ),
      body: data!=null ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "Assets/ticket.png",
                    height: divHeight * 0.02,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: divWidth * 0.015,
                  ),
                  textWidget(
                      text: "Tickets",
                      fontWeight: FontWeight.bold,
                      fontsize: divHeight * 0.019,
                      fontColor: borderColor),
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: divHeight * 0.01,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return ticketBox(ticketDetails: data!["ticket"][index]);
                },itemCount: data!["ticket"].length,),
              SizedBox(
                height: divHeight * 0.04,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(
                      text: "Select trip Type :  ",
                      fontWeight: FontWeight.bold,
                      fontsize: divHeight * 0.017,
                      fontColor: borderColor),
                  SizedBox(width: divWidth*0.02,),
                  chipButton(chipName: "PickUp", selected: select),
                  SizedBox(width: divWidth*0.02,),
                  chipButton(chipName: "Drop", selected: !select),
                ],
              ),
              SizedBox(height: divHeight*0.02,),

              select  ? tripSpeedAndPassengersDetails(passengersList: pickupPassengersList, uid: userId!):tripSpeedAndPassengersDetails(passengersList: dropPassengersList, uid: userId!)
            ],
          ),
        ),
      ): Loading()
    );
  }

  Card ticketBox({
    required  Map ticketDetails,
}) {
    String status=ticketDetails["status"];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: secondaryColor             ,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(
                      text: ticketDetails["ticketName"],
                      fontWeight: FontWeight.w500,
                      fontsize: divHeight * 0.017,
                      fontColor: borderColor),
                  textWidget(
                      text:ticketDetails["amount"],
                      fontWeight: FontWeight.w500,
                      fontsize: divHeight * 0.017,
                      fontColor: Colors.green),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(
                      text: ticketDetails["time"],
                      fontWeight: FontWeight.w500,
                      fontsize: divHeight * 0.017,
                      fontColor: borderColor),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(
                      text: status ,
                      fontWeight: FontWeight.w500,
                      fontsize: divHeight * 0.017,
                      fontColor:status=="Pending" ? Colors.orangeAccent: Colors.green),
                  textWidget(
                      text: ticketDetails["status"]=="Pending" ? "" : "Approved Time",
                      fontWeight: FontWeight.w500,
                      fontsize: divHeight * 0.017,
                      fontColor: borderColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   studentIdBox({
    required Map passengerDetails,required bool checked

    // required int index,
  }) {
    return Padding(padding:EdgeInsets.symmetric(vertical: 5), child:Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              width: 1.0, color:  checked ? presentColor :absentColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          textWidget(
              text: passengerDetails["studentName"],
              fontWeight: FontWeight.w500,
              fontsize: divHeight * 0.017,
              fontColor: Colors.black),
          textWidget(
              text: passengerDetails["studentId"],
              fontWeight: FontWeight.w500,
              fontsize: divHeight * 0.017,
              fontColor: primaryColor),
          //TextWidget(text: "1.00 pm", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
          textWidget(
              text: passengerDetails["classAndSec"],
              fontWeight: FontWeight.w500,
              fontsize: divHeight * 0.017,
              fontColor: Colors.black45),
        ],
      ),
    )
    );
  }

  chipButton({
    required String chipName,
    required bool selected,
  }) =>
      InkWell(
        onTap: () {
          setState(() {
            select=!select;
          });
        },
        child: Chip(
            backgroundColor:selected? primaryColor :secondaryColor ,
            label: textWidget(
                text: chipName,
                fontWeight: FontWeight.w500,
                fontsize: divHeight * 0.017,
                fontColor:selected? secondaryColor : borderColor)),
      );

  tripSpeedAndPassengersDetails({
    required List passengersList,
    required String uid

}){
   int noOfPassengers=passengersList.length;
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              "Assets/speed.png",
              height: divHeight * 0.025,
              color: Colors.blueGrey,
            ),
            SizedBox(
              width: divWidth * 0.015,
            ),
            textWidget(
                text: "Speed Limit",
                fontWeight: FontWeight.bold,
                fontsize: divHeight * 0.019,
                fontColor: borderColor),
          ],
        ),
        SizedBox(
          height: divHeight * 0.30,
          child: SfCartesianChart(
            primaryXAxis: const NumericAxis(),
            primaryYAxis: const NumericAxis(),
            series: <CartesianSeries>[
              SplineSeries<Map<String, double>, double>(
                dataSource: const [
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
                color: primaryColor,
                width: 2,
              ),
            ],
          ),
        ),

        SizedBox(height: divHeight*0.02,),
        Row(
          children: [
            Image.asset(
              "Assets/groups.png",
              height: divHeight * 0.02,
              color: Colors.deepPurple,
            ),
            SizedBox(
              width: divWidth * 0.015,
            ),
            textWidget(
                text: "Passengers",
                fontWeight: FontWeight.bold,
                fontsize: divHeight * 0.019,
                fontColor: borderColor),
            const Spacer(),
          ],
        ),
        SizedBox(
          height: divHeight * 0.01,
        ),
        StreamBuilder(stream: dbService.totalPassengers(uid: uid), builder: (context,snapshots) {
          if(!snapshots.hasData) return Loading();
          List<DocumentSnapshot> documents=snapshots.data.docs;
          int totalPassengerCount=documents.length;
          if(totalPassengerId.isEmpty){
            for(int i=0;i<totalPassengerCount;i++){
              totalPassengerId.add(documents[i].id);
            }
          }
          return Column(children: [Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            textWidget(
                text: "Present : ${noOfPassengers}",
                fontWeight: FontWeight.w500,
                fontsize: divHeight * 0.017,
                fontColor: Colors.green),
            textWidget(
                text: "Absent : ${totalPassengerCount-noOfPassengers}",
                fontWeight: FontWeight.w500,
                fontsize: divHeight * 0.017,
                fontColor: Colors.red),
          ],
        ),
        SizedBox(
          height: divHeight * 0.01,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,

            itemBuilder: (context, index) {
              Map<String,dynamic> passdet=documents[index].data() as Map<String,dynamic>;
            String currentPassengerId=passdet["docId"];
            bool present=passengersList.any((dataItem) => dataItem["studentId"] == currentPassengerId);

              return studentIdBox(passengerDetails:passdet,checked:present );
            }, itemCount: totalPassengerCount,)
    ]
    );
  }
  )


      ],
    );
  }
}
