import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;

  ProductDetailsPage({required this.productId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('product')
          .doc(productId)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!.data()
              as Map<String, dynamic>; // Cast data to Map<String, dynamic>
          return Scaffold(
            appBar: AppBar(
              title: Text(data["productName"]),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(data['image']),
                SizedBox(height: 16),
                Text(
                    'Product Name: ${data["productName"]}'), // Access data using []
                Text('Price: ${data['price']}'),
                Text('Location: ${data['location']}'),
                Text('Contact: ${data['contact']}'),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
