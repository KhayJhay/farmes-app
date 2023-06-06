import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase2/drawer.dart';
import 'package:firebase2/widgets/farm_product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final numberController = TextEditingController();

  String imageURL = ' ';

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    priceController.dispose();
    numberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text('Feed'),
          backgroundColor: Colors.green,
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(Icons.notifications,
                  color: Color.fromARGB(255, 253, 250, 250)),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(Icons.help, color: Color.fromARGB(255, 253, 250, 250)),
            ),
          ]),
      body: //AsyncSnapshot<QuerySnapshot>
          SizedBox(
        width: double.infinity,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('product').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      FarmProduct(
                        farmNumber:
                            snapshot.data!.docs[index]['contact'].toString(),
                        imageItem:
                            snapshot.data!.docs[index]['image'].toString(),
                        location:
                            snapshot.data!.docs[index]['location'].toString(),
                        itemPrice:
                            snapshot.data!.docs[index]['price'].toString(),
                        productName: snapshot.data!.docs[index]['productName']
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DialogBox();
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
      drawer: CustomDrawer(),
    );
  }

  Future DialogBox() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Product"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Color.fromARGB(255, 230, 255, 235),
                  child: GestureDetector(
                    onTap: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);

                      if (file == null) return;

                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      //Creating references for the images to be stored
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('proimages');

                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);

                      //Uploading the image to firebase storage
                      try {
                        await referenceImageToUpload.putFile(File(file.path));

                        imageURL =
                            await referenceImageToUpload.getDownloadURL();
                      } catch (error) {
                        // TODO
                      }
                    },
                    child: Icon(
                      Icons.photo_camera,
                      color: Color.fromARGB(255, 40, 39, 39),
                      size: 40,
                    ),
                  ),
                ),
                TextField(
                  controller: nameController,
                  autofocus: true,
                  decoration: InputDecoration(hintText: "Product Name"),
                ),
                TextField(
                  controller: priceController,
                  autofocus: true,
                  decoration: InputDecoration(hintText: "Price"),
                ),
                TextField(
                  controller: numberController,
                  autofocus: true,
                  decoration: InputDecoration(hintText: "Number"),
                ),
                TextField(
                  controller: locationController,
                  autofocus: true,
                  decoration: InputDecoration(hintText: "Location"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: Save, child: Text('Save')),
          ],
        );
      },
    );
  }

  Future Save() async {
    Navigator.of(context).pop();
    addFarmDetails(
        nameController.text.trim(),
        priceController.text.trim(),
        locationController.text.trim(),
        numberController.text.trim(),
        imageURL.trim());

    nameController.clear();
    priceController.clear();
    locationController.clear();
    numberController.clear();
  }

  Future addFarmDetails(String productName, String price, String location,
      String contact, String imageURL) async {
    await FirebaseFirestore.instance.collection('product').add({
      'productName': productName,
      'price': price,
      'location': location,
      'contact': contact,
      'image': imageURL,
    });
  }
}
