import 'package:driver/Commons/common_Colors.dart';
import 'package:driver/Commons/constant_strings.dart';
import 'package:driver/Custom_Widgets/custom_Button.dart';
import 'package:driver/Custom_Widgets/custom_appBar.dart';
import 'package:driver/Custom_Widgets/custom_textFieldWidget.dart';
import 'package:driver/Custom_Widgets/custom_textWidget.dart';
import 'package:flutter/material.dart';

class RoutePath extends StatefulWidget {
  const RoutePath({super.key});

  @override
  State<RoutePath> createState() => _RoutePathState();
}

class _RoutePathState extends State<RoutePath> {
  late double divHeight, divWidth;
  bool selected = true;
  TextEditingController From = TextEditingController();
  TextEditingController To = TextEditingController();

  @override
  Widget build(BuildContext context) {
    divHeight = MediaQuery.of(context).size.height;
    divWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBarWidget(title: route, fontsize: divHeight * 0.02),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                height: divHeight * 0.06,
                width: divWidth * 0.90,
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
              textFieldWidget(
                  hintText: "From",
                  control: From,
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.red,
                  )),
              SizedBox(
                height: divHeight * 0.02,
              ),
              textFieldWidget(
                  hintText: "To",
                  control: To,
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.green,
                  )),
              SizedBox(
                height: divHeight * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buttonWidget(
                      buttonName: "Edit Route",
                      buttonWidth: divWidth * 0.4,
                      buttonColor: Colors.red,
                      fontSize: divHeight * 0.017,
                      fontweight: FontWeight.w500,
                      fontColor: secondaryColor),
                  buttonWidget(
                      buttonName: "Show Route",
                      buttonWidth: divWidth * 0.4,
                      buttonColor: primaryColor,
                      fontSize: divHeight * 0.017,
                      fontweight: FontWeight.w500,
                      fontColor: secondaryColor),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container switchButtonWidget({required String title, required bool Selected}) {
    return Container(
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
            fontColor: Selected ? secondaryColor : borderColor),
      ),
    );
  }
}
