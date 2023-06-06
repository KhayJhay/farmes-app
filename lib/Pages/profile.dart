
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase2/Pages/home.dart';
import 'package:firebase2/Pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';


class Profile extends StatefulWidget {
  final VoidCallback HomePage;
  const Profile({Key? key, required this.HomePage}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();

}



class _ProfileState extends State<Profile> {
  
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final firstNameController = TextEditingController();
  final surnameController = TextEditingController();
  final numberController = TextEditingController();
  final roleController = TextEditingController();
  final locationController = TextEditingController();
  final comfirmPassController = TextEditingController();
  var prefixIcon;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    comfirmPassController.dispose();
    firstNameController.dispose();
    surnameController.dispose();
    numberController.dispose();
    roleController.dispose();
    locationController.dispose();

    super.dispose();
  }


  String imageURL='';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
              height: 250,
              width: 600,
              // color: Colors.green,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/six.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 2, 2, 2).withOpacity(0.35),
                    BlendMode.darken),
              )),
              child: Column(
                children: [
                  Container(
                    width: 600,
                    decoration: BoxDecoration(color: Colors.green),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0, right: 300),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context, HomePage());
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 0),
                    child: CircleAvatar(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {

                              ImagePicker imagePicker = ImagePicker();
                              XFile? file = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                                  print('${file?.path}');

                                  if (file == null) return;

                              String uniqueFileName = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();

                              

                              //Creating references for the images to be stored
                              Reference referenceRoot =
                                  FirebaseStorage.instance.ref();
                              Reference referenceDirImages =
                                  referenceRoot.child('images');

                              Reference referenceImageToUpload =
                                  referenceDirImages.child(uniqueFileName);

                              //Uploading the image to firebase storage
                              try {
                                await referenceImageToUpload.putFile(File(file.path));

                               imageURL=await referenceImageToUpload.getDownloadURL();

                              }catch(error) {
                                // TODO
                              }
                            },
                            child: Icon(
                              Icons.photo_camera,
                              color: Color.fromARGB(255, 40, 39, 39),
                              size: 40,
                            ),
                          ),



                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Edit Photo",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 12),
                                ),
                                Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 5, 5, 5),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      backgroundImage: NetworkImage(''),
                      backgroundColor: Colors.white60,
                      radius: 80,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 0,
              ),
              height: 50,
              width: 350,
              child: TextField(
                controller: firstNameController,
                cursorColor: Colors.green,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: prefixIcon ??
                        Icon(
                          Icons.perm_identity,
                          color: Colors.green,
                        ),
                    hintText: 'First Name',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 0),
              height: 50,
              width: 350,
              child: TextField(
                controller: surnameController,
                cursorColor: Colors.green,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: prefixIcon ??
                        Icon(
                          Icons.perm_identity,
                          color: Colors.green,
                        ),
                    hintText: 'Last Name',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 20, color: Colors.green)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 0),
              height: 50,
              width: 350,
              child: TextField(
                controller: emailController,
                cursorColor: Colors.green,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: prefixIcon ??
                        Icon(
                          Icons.mail,
                          color: Colors.green,
                        ),
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 20, color: Colors.green)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 0),
              height: 50,
              width: 350,
              child: TextField(
                controller: numberController,
                cursorColor: Colors.green,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: prefixIcon ??
                        Icon(
                          Icons.contact_phone,
                          color: Colors.green,
                        ),
                    hintText: 'Contact',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 20, color: Colors.green)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 0),
              height: 50,
              width: 350,
              child: TextField(
                controller: roleController,
                cursorColor: Colors.green,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: prefixIcon ??
                        Icon(
                          Icons.work,
                          color: Colors.green,
                        ),
                    hintText: 'Role',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 20, color: Colors.green)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 0),
              height: 50,
              width: 350,
              child: TextField(
                controller: locationController,
                cursorColor: Colors.green,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    prefixIcon: prefixIcon ??
                        Icon(
                          Icons.location_city,
                          color: Colors.green,
                        ),
                    hintText: 'Location',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 20, color: Colors.green)),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                SignUp();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green,
                ),
                padding: EdgeInsets.only(left: 150, top: 11),
                height: 50,
                width: 350,
                child: Text(
                  'Sign-Up',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ]),
        ),
      ),
    );
  }

  Future SignUp() async {
    addUserDetails(
      firstNameController.text.trim(),
      surnameController.text.trim(),
      emailController.text.trim(),
      int.parse(numberController.text.trim()),
      roleController.text.trim(),
      locationController.text.trim(),
      imageURL.trim()
    );

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Your Details have been saved successfully"),
          );
        });

    firstNameController.clear();
    surnameController.clear();
    emailController.clear();
    numberController.clear();
    roleController.clear();
    locationController.clear();
  }

  Future addUserDetails(String firstName, String lastName, String email,
      int contact, String role, String location, var imageURL) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'Email': email,
      'Contact': contact,
      'Role': role,
      'Location': location,
      'image':imageURL
    });
  }
}
