import 'package:driver/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var divHeight,divWidth;
  TextEditingController amount=TextEditingController();
  String? ticket;
  List Ticket=[
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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change the drawer icon color to white
        ),
        backgroundColor: Color(0xFF00A0E3),
        centerTitle: true,
        title: TextWidget(text: 'Home', fontWeight: FontWeight.bold, fontsize: divHeight*0.02, fontColor: Colors.white),

      ),
      drawer: Drawer(

        child: Column(
          children: [

            SizedBox(height: divHeight*0.04,child: Container(color:Color(0xFF00A0E3) ,),),
         Container(

              color: Color(0xFF00A0E3),
              child:ListTile(
                leading: CircleAvatar(backgroundColor: Colors.white,),

                title: TextWidget(text: "Vechile Id", fontWeight: FontWeight.bold, fontsize: divHeight*0.02, fontColor: Colors.white),
                subtitle: TextWidget(text: "Praveen", fontWeight: FontWeight.w300, fontsize: divHeight*0.017, fontColor: Colors.white),
              ),
            ),

          ],
        ),
      ),
body: SingleChildScrollView(child:Padding(padding: EdgeInsets.all(15),child: Column(
  children: [
    Row(children: [
      SizedBox(height: divHeight*0.02,),
      Image.asset("Assets/speed.png",height: divHeight*0.025,color: Colors.blueGrey,),
      SizedBox(width: divWidth*0.015,),
      TextWidget(text: "Speed Limit", fontWeight: FontWeight.bold, fontsize: divHeight*0.019, fontColor: Colors.black),Spacer(),
     Spacer(),
      TextWidget(text: "Date", fontWeight: FontWeight.w700, fontsize: divHeight*0.017, fontColor: Colors.black),


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
      Image.asset("Assets/vechile.png",height: divHeight*0.02,color: Colors.teal,),
      SizedBox(width: divWidth*0.015,),
      TextWidget(text: "Vechile Expense", fontWeight: FontWeight.bold, fontsize: divHeight*0.019, fontColor: Colors.black),Spacer(),

    ],),
    SizedBox(height: divHeight*0.01,),
    Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [BoxWidget(Img: 'Assets/petrolCan.png', title: 'Petrol Allowance', Amount: '2000', Imgcolor: Colors.red),
      BoxWidget(Img: 'Assets/vechileService.png', title: 'Vechile Service', Amount: '2000',Imgcolor: Colors.brown)
    ]
    ),
    SizedBox(height: divHeight*0.04,),
    Row(children: [
      Image.asset("Assets/ticket.png",height: divHeight*0.02,color: Colors.green,),
      SizedBox(width: divWidth*0.015,),
      TextWidget(text: "Raise Ticket", fontWeight: FontWeight.bold, fontsize: divHeight*0.019
          , fontColor: Colors.black),Spacer(),

    ],),
    SizedBox(height: divHeight*0.01,),
    DropDownWidget(Items:Ticket , Onchange: (newValue){
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

      TextWidget(text: "Amount :", fontWeight: FontWeight.w500, fontsize: divHeight*0.019, fontColor: Colors.black),

      Container(
          width: divWidth*0.6,
          child:
      TextFieldWidget(hintText: "Enter the Amount", control: amount,prefix: Text("₹ "),textfieldType: TextInputType.number,)),

    ],),
SizedBox(height: divHeight*0.02,),
      InkWell(
           onTap: (){
             if (ticket==null){
               Message(context: context, Content: "Please Select the Ticket", fontSize: divHeight*0.017, fontColor: Colors.white, BarColor: Colors.red);

             }
             else if(amount.text.isEmpty){

                 Message(context: context, Content: "Please Enter the Amount", fontSize: divHeight*0.017, fontColor: Colors.white, BarColor: Colors.red);

               }
             else {
               Message(context: context,
                   Content: "Ticket Raised Successfully",
                   fontSize: divHeight * 0.017,
                   fontColor: Colors.white,
                   BarColor: Colors.green);
             }
            // print(amount.text.isNotEmpty);
           },
       child: ButtonWidget(buttonName: "Raise Ticket", buttonWidth: divWidth*0.5, buttonColor: Color(0xFF00A0E3), fontSize: divHeight*0.017, fontweight: FontWeight.bold, fontColor: Colors.white),
     ),
    SizedBox(height: divHeight*0.02,),
    TicketBox(TicketName: ticket.toString(), Amount: amount.text)
  ],
),),
)
    );
  }
BoxWidget({
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
          color: Color(0xFF00A0E3) ,
            border: Border.all(color: Color(0xFF00A0E3) ,width: 1),
           borderRadius: BorderRadius.circular(21)
        ),
        child: Column(
          children: [
            Container(
              height: divHeight*0.1,
              width:divWidth*0.43 ,

              decoration: BoxDecoration(
               color: Colors.white,
                  //Color(0xFF00A0E3)
                //border: Border.all(color:Colors.black ,width: 1.5),
                borderRadius: BorderRadius.circular(20)
              ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Image.asset(Img,height: divHeight*0.04,color: Imgcolor,),
                    TextWidget(text: title, fontWeight: FontWeight.bold, fontsize: divHeight*0.016, fontColor: Colors.black),
                  ],
                ),


            ),
            Spacer(),
            TextWidget(text:"₹ "+Amount, fontWeight: FontWeight.bold, fontsize: divHeight*0.02, fontColor: Colors.white,),
            Spacer(),
          ],
        ),
        
      ),
    );
}
TicketBox({
    required String TicketName,
  required dynamic Amount,
  
}){
    DateTime now=DateTime.now();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                TextWidget(text: TicketName, fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
                TextWidget(text:"₹ "+ Amount, fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.green),
              ],
            ),
            ),
        Expanded(
          flex: 1,
          child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(text: DateFormat("dd-mm-yyyy").format(now), fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
                TextWidget(text: DateFormat("hh:mm a").format(now), fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
              ],
            ),
        ),
  Expanded(
  flex: 1,
  child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(text: "Pending", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.orangeAccent),

              ],
            ),
  ),
          ],
        ),
        ),

    );
}
DrawerItems({
    required Color IconColor,
  required double IconSize,
}){

    return ListTile(
      leading: Icon(Icons.notifications_none_rounded,color: IconColor,size: IconSize,),
      title: TextWidget(text: " Notifications", fontWeight: FontWeight.w500, fontsize: divHeight*0.017, fontColor: Colors.black),
    )
}
}
