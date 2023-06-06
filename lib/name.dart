import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future ChaneName()async{
 Container(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) => Container(
                    
                            child: 
                           
                                Text(
                                  snapshot.data?.docs[index]['first name'],
                                  style: TextStyle(fontSize: 5),
                                ),
                           
                      
                    ),
                  );
                } else {
                  return Container(child: Text("hello"),);
                }
              },
            ),
          );
}