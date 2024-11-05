
import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Custom_Widgets/custom_Button.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';
import 'package:driver/Custom_Widgets/custom_dropDownWidget.dart';
import 'package:driver/Custom_Widgets/custom_snackBar.dart';
import 'package:driver/Custom_Widgets/custom_textFieldWidget.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double divHeight,divWidth;
  TextEditingController amount=TextEditingController();
  String? ticket;
  List ticketsList=[
    "Petrol Allowance",
    "Vechile Service",

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount.addListener((){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    divWidth=MediaQuery.of(context).size.width;
    divHeight=MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: appBarWidget(title: home, fontsize: divHeight*0.02),
      drawer: Drawer(

        child: Column(
          children: [

            SizedBox(height: divHeight*0.04,child: Container(color:primaryColor ,),),
         Container(

              color: primaryColor,
              child:ListTile(
                leading:  CircleAvatar(backgroundColor: secondaryColor,),

                title: textWidget(text: "Vechile Id", fontWeight: FontWeight.bold, fontsize: divHeight*0.02, fontColor: Colors.white),
                subtitle: textWidget(text: "Praveen", fontWeight: FontWeight.w300, fontsize: divHeight*0.017, fontColor: Colors.white),
              ),
            ),
drawerItems(title: "Notifications",icon:Icon(Icons.notifications_none_rounded,color: Colors.yellow,size: divHeight*0.04,)),
            Divider(height: divHeight*0.01,),
            drawerItems(title: "Logout",icon:Icon(Icons.logout,color: Colors.red,size: divHeight*0.04,)),
            Divider(height: divHeight*0.01,),
          ],
        ),
      ),
body: SingleChildScrollView(child:Padding(padding: const EdgeInsets.all(15),child: Column(
  children: [
    Row(children: [
      SizedBox(height: divHeight*0.02,),
      Image.asset("Assets/speed.png",height: divHeight*0.025,color: Colors.blueGrey,),
      SizedBox(width: divWidth*0.015,),
      textWidget(text: "Speed Limit", fontWeight: FontWeight.bold, fontsize: divHeight*0.019, fontColor: Colors.black),const Spacer(),
     const Spacer(),
      textWidget(text: "Date", fontWeight: FontWeight.w700, fontsize: divHeight*0.017, fontColor: Colors.black),


    ],),
    Container(
      height: divHeight*0.30,
      
      child:
    SfCartesianChart(

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
    SizedBox(height: divHeight*0.04,),
    Row(children: [
      Image.asset("Assets/vechile.png",height: divHeight*0.02,color: Colors.teal,),
      SizedBox(width: divWidth*0.015,),
      textWidget(text: "Vechile Expense", fontWeight: FontWeight.bold, fontsize: divHeight*0.019, fontColor: Colors.black),const Spacer(),

    ],),
    SizedBox(height: divHeight*0.01,),
    Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [boxWidget(Img: 'Assets/petrolCan.png', title: 'Petrol Allowance', Amount: '2000', Imgcolor: Colors.red),
      boxWidget(Img: 'Assets/vechileService.png', title: 'Vechile Service', Amount: '2000',Imgcolor: Colors.brown)
    ]
    ),
    SizedBox(height: divHeight*0.04,),
    Row(children: [
      Image.asset("Assets/ticket.png",height: divHeight*0.02,color: Colors.green,),
      SizedBox(width: divWidth*0.015,),
      textWidget(text: "Raise Ticket", fontWeight: FontWeight.bold, fontsize: divHeight*0.019
          , fontColor: borderColor),const Spacer(),

    ],),
    SizedBox(height: divHeight*0.01,),
    dropDownWidget(Items:ticketsList , Onchange: (newValue){
      setState(() {
        ticket=newValue;
      });
    }, lableSize: divHeight*0.017, hintText: "Select the Ticket", Value:ticket, OnClear: () { setState(() {

      ticket=null;
    }); } ),
    SizedBox(height: divHeight*0.02,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

      textWidget(text: "Amount :", fontWeight: FontWeight.w500, fontsize: divHeight*0.019, fontColor: Colors.black),

      Container(
          width: divWidth*0.6,
          child:
      textFieldWidget(hintText: "Enter the Amount", control: amount,prefix: const Text("₹ "),textfieldType: TextInputType.number,)),

    ],),
SizedBox(height: divHeight*0.02,),
      InkWell(
           onTap: (){
             if (ticket==null){
               message(context: context, Content: "Please Select the Ticket", fontSize: divHeight*0.017, fontColor: secondaryColor, BarColor: Colors.red);

             }
             else if(amount.text.isEmpty){

                 message(context: context, Content: "Please Enter the Amount", fontSize: divHeight*0.017, fontColor: secondaryColor, BarColor: Colors.red);

               }
             else {
               message(context: context,
                   Content: "Ticket Raised Successfully",
                   fontSize: divHeight * 0.017,
                   fontColor: secondaryColor,
                   BarColor: Colors.green);
             }
            // print(amount.text.isNotEmpty);
           },
       child: buttonWidget(buttonName: "Raise Ticket", buttonWidth: divWidth*0.5, buttonColor: primaryColor, fontSize: divHeight*0.017, fontweight: FontWeight.bold, fontColor: secondaryColor),
     ),
    SizedBox(height: divHeight*0.02,),
    ticketBox(TicketName: ticket.toString(), Amount: amount.text)
  ],
),),
)
    );
  }
Card boxWidget({
    required String Img,
  required String title,
  required String Amount,
  required Color Imgcolor,

}){
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        height: divHeight*0.2,
        width: divWidth*0.43,
        decoration: BoxDecoration(
          color: primaryColor ,
            border: Border.all(color: primaryColor ,width: 1),
           borderRadius: BorderRadius.circular(21)
        ),
        child: Column(
          children: [
            Container(
              height: divHeight*0.1,
              width:divWidth*0.43 ,

              decoration: BoxDecoration(
               color: secondaryColor,
                  //Color(0xFF00A0E3)
                //border: Border.all(color:Colors.black ,width: 1.5),
                borderRadius: BorderRadius.circular(20)
              ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Image.asset(Img,height: divHeight*0.04,color: Imgcolor,),
                    textWidget(text: title, fontWeight: FontWeight.bold, fontsize: divHeight*0.016, fontColor: borderColor),
                  ],
                ),


            ),
            const Spacer(),
            textWidget(text:"₹ "+Amount, fontWeight: FontWeight.bold, fontsize: divHeight*0.02, fontColor: secondaryColor,),
            const Spacer(),
          ],
        ),
        
      ),
    );
}
 Card ticketBox({
    required String TicketName,
  required dynamic Amount,
  
}){
    DateTime now=DateTime.now();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:  BorderRadius.circular(15)
      ),
      child: Container(
        padding:  const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.0)
        ),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(

              child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                textWidget(text: TicketName, fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
                textWidget(text:"₹ "+ Amount, fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.green),
              ],
            ),
            ),
        Expanded(

          child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(text: DateFormat("dd-mm-yyyy").format(now), fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
                textWidget(text: DateFormat("hh:mm a").format(now), fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
              ],
            ),
        ),
  Expanded(

  child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(text: "Pending", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.orangeAccent),

              ],
            ),
  ),
          ],
        ),
        ),

    );
}
ListTile drawerItems({

  required String title,
  required  Icon icon
}){

    return ListTile(
      leading: icon,
      title: textWidget(text: title, fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: borderColor),
      trailing: Icon(Icons.chevron_right,color: borderColor,size: divHeight*0.02 ,),
    );
}


}
