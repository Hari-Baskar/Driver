import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Custom_Widgets/custom_Button.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';
import 'package:driver/Custom_Widgets/custom_dropDownWidget.dart';
import 'package:driver/Custom_Widgets/custom_snackBar.dart';
import 'package:driver/Custom_Widgets/custom_textFieldWidget.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:driver/Pojo/vechileDetails_Pojo.dart';
import 'package:driver/Services/auth_Service.dart';
import 'package:driver/Services/db_Service.dart';
import 'package:driver/userManagement/check_Auth.dart';
import 'package:driver/Custom_Widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double divHeight, divWidth;
  TextEditingController amount = TextEditingController();
  String? ticket;
  List ticketsList = [
    "Petrol Allowance",
    "Vechile Service",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount.addListener(() {
      setState(() {});
    });
  }

  String? userId;
  AuthService authService = AuthService();
  DBService dbService = DBService();
  //VechileDetails vechileDetails = VechileDetails();

  @override
  Widget build(BuildContext context) {
    divWidth = MediaQuery.of(context).size.width;
    divHeight = MediaQuery.of(context).size.height;

    final user = Provider.of<User?>(context);
    String userId = user!.uid;

    return StreamBuilder(
        stream: dbService.getVechileDetails(uid: userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Loading();

          DocumentSnapshot documentSnapshot =
              snapshot.data ;

          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
;

          return Scaffold(
              backgroundColor: white,
              appBar: appBarWidget(

                  title: home, fontsize: divHeight * 0.02,drawer:true ),
              drawer: Drawer(
                child: Column(
                  children: [
                    SizedBox(
                      height: divHeight * 0.04,
                      child: Container(
                        color: blue,
                      ),
                    ),
                    Container(
                      color: blue,
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: white,
                        ),
                        title: textWidget(
                            text: data["driverName"].toString(),
                            fontWeight: FontWeight.bold,
                            fontsize: divHeight * 0.02,
                            fontColor: white),
                        subtitle: textWidget(
                            text: data["email"].toString(),
                            fontWeight: FontWeight.w300,
                            fontsize: divHeight * 0.017,
                            fontColor: white),
                      ),
                    ),
                    drawerItems(
                        title: "Notifications",
                        icon: Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.orangeAccent,
                          size: divHeight * 0.04,
                        ),
                        function: () {}),
                    Divider(
                      height: divHeight * 0.01,
                    ),
                    drawerItems(
                        title: "Logout",
                        icon: Icon(
                          Icons.logout,
                          color: red,
                          size: divHeight * 0.04,
                        ),
                        function: () async {
                          await authService.logOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CheckAuth()));
                        }),
                    Divider(
                      height: divHeight * 0.01,
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [

                          SizedBox(
                            height: divHeight * 0.02,
                          ),
                 Row(
                        children: [
                          Image.asset(
                            "Assets/vechile.png",
                            height: divHeight * 0.02,
                            color: Colors.teal,
                          ),
                          SizedBox(
                            width: divWidth * 0.015,
                          ),
                          textWidget(
                              text: "Vechile Expense",
                              fontWeight: FontWeight.bold,
                              fontsize: divHeight * 0.019,
                              fontColor: black),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: divHeight * 0.01,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            boxWidget(
                                img: 'Assets/petrolCan.png',
                                title: 'Petrol Allowance',
                                amountRs: data["petrolAllowanceAmount"]
                                    .toString(),
                                imgcolor: red),
                            boxWidget(
                                img: 'Assets/vechileService.png',
                                title: 'Vechile Service',
                                amountRs: data["vechileServiceAmount"]
                                    .toString(),
                                imgcolor: Colors.brown)
                          ]),
                      SizedBox(
                        height: divHeight * 0.04,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "Assets/ticket.png",
                            height: divHeight * 0.02,
                            color: green,
                          ),
                          SizedBox(
                            width: divWidth * 0.015,
                          ),
                          textWidget(
                              text: "Raise Ticket",
                              fontWeight: FontWeight.bold,
                              fontsize: divHeight * 0.019,
                              fontColor: black),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: divHeight * 0.01,
                      ),
                      dropDownWidget(
                          Items: ticketsList,
                          Onchange: (newValue) {
                            setState(() {
                              ticket = newValue;
                            });
                          },
                          lableSize: divHeight * 0.017,
                          hintText: "Select the Ticket",
                          Value: ticket,
                          OnClear: () {
                            setState(() {
                              ticket = null;
                            });
                          }),
                      SizedBox(
                        height: divHeight * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          textWidget(
                              text: "Amount :",
                              fontWeight: FontWeight.w500,
                              fontsize: divHeight * 0.019,
                              fontColor: black),
                          SizedBox(
                              width: divWidth * 0.6,
                              child: textFieldWidget(
                                hintText: "Enter the Amount",
                                control: amount,
                                prefix: const Text("₹ "),
                                textfieldType: TextInputType.number,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: divHeight * 0.02,
                      ),
                      InkWell(
                        onTap: () async {
                          if (ticket == null) {
                            message(
                                context: context,
                                Content: "Please Select the Ticket",
                                fontSize: divHeight * 0.017,
                                fontColor: white,
                                BarColor: red);
                          } else if (amount.text.isEmpty) {
                            message(
                                context: context,
                                Content: "Please Enter the Amount",
                                fontSize: divHeight * 0.017,
                                fontColor: white,
                                BarColor: red);
                          } else {
                            await dbService.addTicketToHistory(
                                ticketName: ticket!,
                                Amount: amount.text,
                                uid: userId);
                            message(
                                context: context,
                                Content: "Ticket Raised Successfully",
                                fontSize: divHeight * 0.017,
                                fontColor: white,
                                BarColor: green);
                            ticket = null;
                            amount.clear();
                          }
                          // print(amount.text.isNotEmpty);
                        },
                        child: buttonWidget(
                            buttonName: "Raise Ticket",
                            buttonWidth: divWidth * 0.5,
                            buttonColor: blue,
                            fontSize: divHeight * 0.017,
                            fontweight: FontWeight.bold,
                            fontColor: white),
                      ),
                      SizedBox(
                        height: divHeight * 0.02,
                      ),
                      StreamBuilder(
                          stream: dbService.todayTicketStream(uid: userId),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return const Text("");
                            Map<dynamic, dynamic> todaysTicket = snapshot.data;
                            List ticketsListStream = [];
                            if (todaysTicket.containsKey("ticket")) {
                              ticketsListStream = todaysTicket['ticket'];
                            } else {
                              ticketsListStream = [];
                            }
                            return ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  Map<dynamic, dynamic> ticketDataStream =
                                      ticketsListStream[index];
                                  return ticketBox(
                                      ticketData: ticketDataStream,
                                      userid: userId);
                                },
                                itemCount: ticketsListStream.length);
                          }),
                      // ticketBox(TicketName: ticket.toString(), Amount: amount.text)
                    ],
                  ),
                ),
              ));
        });
  }

  Card boxWidget({
    required String img,
    required String title,
    required String amountRs,
    required Color imgcolor,
  }) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: divHeight * 0.2,
        width: divWidth * 0.43,
        decoration: BoxDecoration(
            color: blue,
            border: Border.all(color: blue, width: 1),
            borderRadius: BorderRadius.circular(21)),
        child: Column(
          children: [
            Container(
              height: divHeight * 0.1,
              width: divWidth * 0.43,
              decoration: BoxDecoration(
                  color: white,
                  //Color(0xFF00A0E3)
                  //border: Border.all(color:Colors.black ,width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    img,
                    height: divHeight * 0.04,
                    color: imgcolor,
                  ),
                  textWidget(
                      text: title,
                      fontWeight: FontWeight.bold,
                      fontsize: divHeight * 0.016,
                      fontColor: black),
                ],
              ),
            ),
            const Spacer(),
            textWidget(
              text: "₹ " + amountRs,
              fontWeight: FontWeight.bold,
              fontsize: divHeight * 0.02,
              fontColor: white,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Card ticketBox({required String userid, required Map ticketData}) {
    String status = ticketData["status"];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textWidget(
                      text: ticketData["ticketName"],
                      fontWeight: FontWeight.w500,
                      fontsize: divHeight * 0.017,
                      fontColor: black),
                  textWidget(
                      text: "₹ " + ticketData["amount"],
                      fontWeight: FontWeight.w500,
                      fontsize: divHeight * 0.017,
                      fontColor: green),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(
                      text: ticketData["date"],
                      fontWeight: FontWeight.w500,
                      fontsize: divHeight * 0.017,
                      fontColor: black),
                  textWidget(
                      text: ticketData["time"],
                      fontWeight: FontWeight.w500,
                      fontsize: divHeight * 0.017,
                      fontColor:  black),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(
                      text: status,
                      fontWeight: FontWeight.w500,
                      fontsize: divHeight * 0.017,
                      fontColor: status == "Pending"
                          ? orange
                          : green),
                  status == "Pending"
                      ? IconButton(
                          onPressed: () async {
                            await dbService.deleteTicket(
                                uid: userid, ticketDetails: ticketData);
                          },
                          icon: const Icon(
                            Icons.delete_outline_outlined,
                            color: red,
                          ))
                      : const SizedBox()
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
    required Icon icon,
    required function,
  }) {
    return ListTile(
      onTap: function,
      leading: icon,
      title: textWidget(
          text: title,
          fontWeight: FontWeight.w500,
          fontsize: divHeight * 0.017,
          fontColor: black),
      trailing: Icon(
        Icons.chevron_right,
        color: black,
        size: divHeight * 0.02,
      ),
    );
  }
}
