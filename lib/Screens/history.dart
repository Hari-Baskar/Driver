import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Custom_Widgets/custom_Button.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';
import 'package:driver/Custom_Widgets/custom_textFieldWidget.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:driver/Screens/detailed_history.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool selected = true;
  late double divHeight, divWidth;
  TextEditingController fromdate = TextEditingController();
  TextEditingController todate = TextEditingController();

  setDate({
    required TextEditingController control,
  }) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(3000)) as DateTime?;
    if (picked != null) {
      setState(() {
        control.text = DateFormat("yyyy-MM-dd").format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBarWidget(title: history, fontsize: divHeight * 0.02),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                SizedBox(
                    width: divWidth * 0.45,
                    child: textFieldWidget(
                        suffixIcon: const Icon(
                          Icons.calendar_month_sharp,
                        ),
                        hintText: "From",
                        control: fromdate,
                        readonly: true,
                        OnClick: () async {
                          await setDate(control: fromdate);
                        })),
                SizedBox(
                    width: divWidth * 0.45,
                    child: textFieldWidget(
                        suffixIcon: const Icon(Icons.calendar_month_sharp),
                        hintText: "To",
                        control: todate,
                        readonly: true,
                        OnClick: () async {
                          await setDate(control: todate);
                        })),
              ]),
              SizedBox(
                height: divHeight * 0.02,
              ),
              buttonWidget(
                  buttonName: "Get Details",
                  buttonWidth: divWidth * 0.4,
                  buttonColor: Colors.red,
                  fontSize: divHeight * 0.017,
                  fontweight: FontWeight.w500,
                  fontColor: secondaryColor),
              SizedBox(
                height: divHeight * 0.02,
              ),
              Container(
                width: divWidth * 0.90,
                height: divHeight * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 1.0, color: primaryColor),
                    color: secondaryColor),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            selected = !selected;
                          });
                        },
                        child: switchButtonWidget(
                            title: "PickUp", Selected: selected)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: switchButtonWidget(
                          title: "Drop", Selected: !selected),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: divHeight * 0.02,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return viewBox(date: "12/10/2024");
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: divHeight * 0.015,
                    );
                  },
                  itemCount: 4)
            ],
          ),
        ),
      ),
    );
  }

  Container  switchButtonWidget({required String title, required bool Selected})   =>
      Container(
        height: divHeight * 0.08,
        width: divWidth * 0.447,
        decoration: BoxDecoration(
            color: Selected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: textWidget(
              text: title,
              fontWeight: FontWeight.w700,
              fontsize: divHeight * 0.017,
              fontColor: Selected ? Colors.white : Colors.black),
        ),
      );

  Container  viewBox({required String date}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.0)),
      child: ListTile(
          title: textWidget(
              text: date,
              fontWeight: FontWeight.w500,
              fontsize: divHeight * 0.017,
              fontColor: Colors.black),
          trailing: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailedHistory()));
              },
              child: textWidget(
                  text: 'View Details',
                  fontWeight: FontWeight.w500,
                  fontsize: divHeight * 0.017,
                  fontColor: primaryColor))),
    );
  }
}
