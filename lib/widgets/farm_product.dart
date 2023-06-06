import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase2/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class FarmProduct extends StatefulWidget {
  const FarmProduct(
      {Key? key,
      required this.imageItem,
      required this.productName,
      required this.itemPrice,
      required this.farmNumber,
      required this.location})
      : super(key: key);

  final String imageItem;
  final String productName;
  final String itemPrice;
  final String farmNumber;
  final String location;

  @override
  State<FarmProduct> createState() => _FarmProductState();
}

class _FarmProductState extends State<FarmProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
      height: 18.h,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 220, 237, 227),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Container(
            height: 12.h,
            width: 12.h,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(
                widget.imageItem,
              ),
            )),
          ),
          SizedBox(
            width: 5.h,
          ),
          Container(
            child: Column(children: [
              SizedBox(height: 2.h),
              Text(
                widget.productName,
                style: GoogleFonts.prompt(
                    fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 1.h),
              Container(
                  height: 2.h,
                  width: 13.w,
                  child: Text(
                    widget.itemPrice,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green)),
              SizedBox(height: 1.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Buy",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Container(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('product')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      FarmProduct(
                                        farmNumber: snapshot
                                            .data!.docs[index]['contact']
                                            .toString(),
                                        imageItem: snapshot
                                            .data!.docs[index]['image']
                                            .toString(),
                                        location: snapshot
                                            .data!.docs[index]['location']
                                            .toString(),
                                        itemPrice: snapshot
                                            .data!.docs[index]['price']
                                            .toString(),
                                        productName: snapshot
                                            .data!.docs[index]['productName']
                                            .toString(),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      );

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(productId: '')));
                    },
                    child: Container(
                      width: 3.h,
                      height: 3.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.orange),
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 1.h,
                          bottom: 2.h,
                        ),
                        child: Icon(
                          Icons.add_circle_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.call,
                    size: 2.h,
                  ),
                  Text(
                    widget.farmNumber,
                    style: TextStyle(color: Colors.black54, fontSize: 12.sp),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Icon(
                    Icons.location_on,
                    size: 2.h,
                  ),
                  Text(widget.location,
                      style: TextStyle(color: Colors.black54, fontSize: 12.sp)),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}
