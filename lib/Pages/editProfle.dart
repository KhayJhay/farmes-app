import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState();
}



class _editProfileState extends State<editProfile> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final firstNameController = TextEditingController();
  final surnameController = TextEditingController();
  final numberController = TextEditingController();
  final roleController = TextEditingController();
  final locationController = TextEditingController();
  final comfirmPassController = TextEditingController();
  var prefixIcon;

  showModalBox(String docId) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => SingleChildScrollView(
          child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.green,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 0,
                      ),
                      height: 40,
                      width: 350,
                      child: TextField(
                        controller: firstNameController,
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: prefixIcon ??
                                Icon(
                                  Icons.perm_identity,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                            hintText: 'First Name',
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0),
                      height: 40,
                      width: 350,
                      child: TextField(
                        controller: surnameController,
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: prefixIcon ??
                                Icon(
                                  Icons.perm_identity,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                            hintText: 'Last Name',
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0),
                      height: 40,
                      width: 350,
                      child: TextField(
                        controller: emailController,
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: prefixIcon ??
                                Icon(
                                  Icons.mail,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0),
                      height: 40,
                      width: 350,
                      child: TextField(
                        controller: numberController,
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: prefixIcon ??
                                Icon(
                                  Icons.contact_phone,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                            hintText: 'Contact',
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0),
                      height: 40,
                      width: 350,
                      child: TextField(
                        controller: roleController,
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: prefixIcon ??
                                Icon(
                                  Icons.work,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                            hintText: 'Role',
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 0,
                      ),
                      height: 40,
                      width: 350,
                      child: TextField(
                        controller: locationController,
                        cursorColor: Color.fromARGB(255, 255, 255, 255),
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            prefixIcon: prefixIcon ??
                                Icon(
                                  Icons.location_city,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                            hintText: 'Location',
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255))),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    //To Update the Profile
                    GestureDetector(
                      onTap: () {
        
                        FirebaseFirestore.instance.collection('users').doc(docId).update({
                          'first name': firstNameController.text,
                          'last name':surnameController.text,
                          'Location':locationController.text,
                          'Email':emailController.text,
                          'Contact':numberController.text,
                          'Role':roleController.text,
                        }).then((value) {
                        firstNameController.text=" ";
                         surnameController.text="";
                          locationController.text="";
                          emailController.text="";
                          numberController.text="";
                          roleController.text="";
                          Navigator.of(context).pop();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        padding: EdgeInsets.only(left: 142, top: 5),
                        height: 35,
                        width: 350,
                        child: Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
        ));
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    surnameController.dispose();
    numberController.dispose();
    roleController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          backgroundColor: Colors.green,
          elevation: 0,
        ),
        body: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) =>
                       Container(
                            child: Column(
                              children: [
                                Container(
                                    height: 50,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    padding: EdgeInsets.only(right: 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'First Name:',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data?.docs[index]
                                              ['first name'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    )),
                                Divider(
                                  color: Color.fromARGB(255, 154, 154, 154),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 0, left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Last Name:',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data?.docs[index]['last name'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    )),
                                Divider(
                                  color: Color.fromARGB(255, 154, 154, 154),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 0, left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Email:',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data?.docs[index]['Email'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    )),
                                Divider(
                                  color: Color.fromARGB(255, 154, 154, 154),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 0, left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Contact:',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data?.docs[index]['Contact'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    )),
                                Divider(
                                  color: Color.fromARGB(255, 154, 154, 154),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 0, left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Role:',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data?.docs[index]['Role'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    )),
                                Divider(
                                  color: Color.fromARGB(255, 154, 154, 154),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 0, left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Location:',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data?.docs[index]['Location'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    )),
                                Divider(
                                  color: Color.fromARGB(255, 154, 154, 154),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    emailController.text =
                                        snapshot.data?.docs[index]['Email'];
                                    firstNameController.text =
                                        snapshot.data?.docs[index]['first name'];
                                    surnameController.text =
                                        snapshot.data?.docs[index]['last name'];
                                    numberController.text =
                                        snapshot.data?.docs[index]['Contact'];
                                    roleController.text =
                                        snapshot.data?.docs[index]['Role'];
                                    locationController.text =
                                        snapshot.data?.docs[index]['Location'];
                    
                                    showModalBox(snapshot.data!.docs[index].id);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.green,
                                    ),
                                    padding: EdgeInsets.only(left: 130, top: 8),
                                    height: 40,
                                    width: 350,
                                    child: Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                    );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
