import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    super.key,
    required this.data,
    required this.name,
    required this.value,
  });

  final String data;
  final String name;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      width: 42.w,
      decoration: BoxDecoration(
          color: Color(0xffe2e3eb),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(80, 158, 158, 158),
              offset: Offset(4, 4),
              blurRadius: 2,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 2,
            )
          ]),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircularPercentIndicator(
          backgroundColor: Colors.green.shade100,
          progressColor: Colors.green,
          circularStrokeCap: CircularStrokeCap.round,
          radius: 7.h,
          lineWidth: 1.3.h,
          percent: value,
          center: Text(
            "$data%",
            style: TextStyle(fontSize: 15.sp),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          name,
          style: GoogleFonts.prompt(fontWeight: FontWeight.bold, fontSize: 2.h),
        )
      ]),
    );
  }
}
