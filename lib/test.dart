import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// // class FitModelPage extends StatefulWidget {
// //   @override
// //   _FitModelPageState createState() => _FitModelPageState();
// // }

// // class _FitModelPageState extends State<FitModelPage> {
// //   String _status = '';
// //   String _humanModel = '';
// //   String _garmentModel = '';
// //   String _humanMtl = '';
// //   String _garmentMtl = '';
// //   String _humanImage = '';
// //   String _garmentImage = '';

// //   Future<void> _fitModel() async {
// //     setState(() {
// //       _status = 'Processing...';
// //     });

// //     final Map<String, dynamic> requestData = {
// //       'uniqueId': '14', // Set your uniqueId here
// //       'garmentClass': 'short-pant', // Set your garmentClass here
// //     };

// //     final response = await http.post(
// //       Uri.parse(
// //           'http://your-backend-url/fit-model'), // Replace with your backend URL
// //       headers: {'Content-Type': 'application/json'},
// //       body: jsonEncode(requestData),
// //     );

// //     if (response.statusCode == 200) {
// //       final responseBody = jsonDecode(response.body);

// //       setState(() {
// //         _status = responseBody['completed'];
// //         _humanModel = responseBody['humanModel'];
// //         _garmentModel = responseBody['garmentModel'];
// //         _humanMtl = responseBody['human-mtl'];
// //         _garmentMtl = responseBody['garment-mtl'];
// //         _humanImage = responseBody['human-image'];
// //         _garmentImage = responseBody['garment-image'];
// //       });
// //     } else {
// //       setState(() {
// //         _status = 'Error: ${response.statusCode}';
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Fit Model'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Text('Status: $_status'),
// //             ElevatedButton(
// //               onPressed: _fitModel,
// //               child: const Text('Fit Model'),
// //             ),
// //             // Display the results returned from the backend
// //             Text('Human Model: $_humanModel'),
// //             Text('Garment Model: $_garmentModel'),
// //             Text('Human Mtl: $_humanMtl'),
// //             Text('Garment Mtl: $_garmentMtl'),
// //             Text('Human Image: $_humanImage'),
// //             Text('Garment Image: $_garmentImage'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fitmoi_mob_app/pages/contact_us.dart';
import 'package:fitmoi_mob_app/pages/products_all.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:fitmoi_mob_app/product_powerbank.dart';

import '../../home/home_page.dart';

// String chosenCateg = 't-shirt';

// class Categorie extends StatefulWidget {
//   String cat;
//   Categorie({
//     Key? key,
//     required this.cat,
//   });

//   @override
//   State<Categorie> createState() => _CategorieState();
// }

// class _CategorieState extends State<Categorie> {
//   List<String> prod = [];
//   int selectedIndex = 0;
//   String selectedCategory = ''; // Track selected category index

//   Future getDocProdF() async {
//     await FirebaseFirestore.instance.collection('subcategoryF').get().then(
//           (snapshot) => snapshot.docs.forEach((document) {
//             print(document.reference);
//             prod.add(document.reference.id);
//           }),
//         );
//   }

//   //List<String> prodM = [];
//   Future getDocProdM() async {
//     await FirebaseFirestore.instance.collection('subcategoryM').get().then(
//           (snapshot) => snapshot.docs.forEach((document) {
//             print(document.reference);
//             prod.add(document.reference.id);
//           }),
//         );
//   }

//   // Function to handle category tap
//   void onCategoryTap(int index) {
//     setState(() {
//       selectedIndex = index;
//       // selectedIndex = index;
//       selectedCategory = prod[index]; // Update selected category

//       // Add conditions for different categories
//       if (widget.cat == 'female') {
//         // Handle category F logic
//         if (selectedCategory == 't-shirt') {
//           // Add if condition for 'shirt'
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Products(
//                 cat: 'female',
//                 subcat: 't-shirt',
//               ),
//             ),
//           );
//           chosenCateg = 't-shirt';
//         } else if (selectedCategory == 'pant') {
//           // Add if condition for 'shirt'
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Products(
//                 cat: 'female',
//                 subcat: 'pant',
//               ),
//             ),
//           );
//           chosenCateg = 'pant';
//         } else if (selectedCategory == 'shirt') {
//           // Add if condition for 'shirt'
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Products(
//                 cat: 'female',
//                 subcat: 'shirt',
//               ),
//             ),
//           );
//           chosenCateg = 'shirt';
//         } else if (selectedCategory == 'skirt') {
//           // Add if condition for 'shirt'
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Products(
//                 cat: 'female',
//                 subcat: 'skirt',
//               ),
//             ),
//           );
//           chosenCateg = 'skirt';
//         } else if (selectedCategory == 'short-pant') {
//           // Add if condition for 'shirt'
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Products(
//                 cat: 'female',
//                 subcat: 'short-pant',
//               ),
//             ),
//           );
//           chosenCateg = 'short-pant';
//         }
//       } else if (widget.cat == 'male') {
//         // Handle category M logic
//         if (selectedCategory == 'shirt') {
//           // Add if condition for 'shirt'
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Products(
//                 cat: 'male',
//                 subcat: 'shirt',
//               ),
//             ),
//           );
//           chosenCateg = 'shirt';
//         } else if (selectedCategory == 't-shirt') {
//           // Add if condition for 'shirt'
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Products(
//                 cat: 'male',
//                 subcat: 't-shirt',
//               ),
//             ),
//           );
//           chosenCateg = 't-shirt';
//         } else if (selectedCategory == 'pant') {
//           // Add if condition for 'shirt'
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Products(
//                 cat: 'male',
//                 subcat: 'pant',
//               ),
//             ),
//           );
//           chosenCateg = 'pant';
//         } else if (selectedCategory == 'short-pant') {
//           // Add if condition for 'shirt'
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Products(
//                 cat: 'male',
//                 subcat: 'short-pant',
//               ),
//             ),
//           );
//           chosenCateg = 'short-pant';
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: widget.cat == 'female' ? getDocProdF() : getDocProdM(),
//         builder: (context, snapshot) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15),
//             child: SizedBox(
//               height: 30,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: prod.length,
//                 itemBuilder: (context, index) => buildCategory(
//                   category: prod[index],
//                   index: index,
//                   selectedIndex:
//                       selectedIndex, // Pass selected index to buildCategory
//                   cat: widget.cat,
//                   onTap: onCategoryTap, // Pass onTap callback to buildCategory
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }

// class buildCategory extends StatelessWidget {
//   final String category;
//   final int index;
//   final int selectedIndex;
//   final String cat;
//   final Function(int) onTap; // Add onTap callback function

//   const buildCategory({
//     Key? key,
//     required this.category,
//     required this.index,
//     required this.selectedIndex,
//     required this.cat,
//     required this.onTap, // Add onTap callback function
//   });

//   @override
//   Widget build(BuildContext context) {
//     return cat == 'female'
//         ? FutureBuilder(
//             future: FirebaseFirestore.instance
//                 .collection('subcategoryF')
//                 .doc(category)
//                 .get(),
//             builder: ((context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 Map<String, dynamic> data = snapshot.data?.data() != null
//                     ? snapshot.data!.data()! as Map<String, dynamic>
//                     : <String, dynamic>{};
//                 return GestureDetector(
//                   onTap: () {
//                     onTap(index); // Call onTap callback function
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text("${data['subCategF']}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: selectedIndex ==
//                                         index // Update color based on selectedIndex
//                                     ? Colors
//                                         .green // Use different color for selected category
//                                     : Colors
//                                         .black)), // Use default color for unselected categories
//                         Container(
//                           margin: const EdgeInsets.only(top: 15 / 4),
//                           height: 2,
//                           width: 30,
//                           color: selectedIndex ==
//                                   index // Update color based on selectedIndex

//                               ? mintColors
//                               : Colors.transparent,
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }
//               return const Text("Loading...");
//             }))
//         : FutureBuilder(
//             future: FirebaseFirestore.instance
//                 .collection('subcategoryM')
//                 .doc(category)
//                 .get(),
//             builder: ((context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 Map<String, dynamic> data = snapshot.data?.data() != null
//                     ? snapshot.data!.data()! as Map<String, dynamic>
//                     : <String, dynamic>{};
//                 return GestureDetector(
//                   onTap: () {
//                     onTap(index);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text("${data['subCategM']}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: selectedIndex == index
//                                     ? const Color.fromARGB(72, 0, 0, 0)
//                                     : const Color.fromARGB(72, 0, 0, 0))),
//                         Container(
//                           margin: const EdgeInsets.only(top: 15 / 4),
//                           height: 2,
//                           width: 30,
//                           color: selectedIndex == index
//                               ? Colors.black
//                               : Colors.transparent,
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               }
//               return const Text("Loading...");
//             }));
//   }
// }
uploadImage() async {
  final _storage = FirebaseStorage.instance;
  final _picker = ImagePicker();
  PickedFile? image;

  //Check Permissions
  await Permission.photos.request();

  var permissionStatus = await Permission.photos.status;

  //Select Image
  image = await _picker.getImage(source: ImageSource.gallery);
  var file = File(image!.path);

  if (image != null) {
    //Upload to Firebase
    // var snapshot =
    //     await _storage.ref().child(p.basename(image.path)).putFile(file);

    //var downloadUrl = await snapshot.ref.getDownloadURL();

    // setState(() {
    //   imageUrl = downloadUrl;
    //   greyimage = imageUrl;
    //   setImage(imageUrl);
    //   getImage();
    // });
  } else {
    Fluttertoast.showToast(msg: 'Grant Permissions and try again');
    return null;
  }
}


// import 'package:flutter/material.dart';
// import 'package:arkit_plugin/arkit_plugin.dart';

// class ARScene extends StatefulWidget {
//   final String userId;
//   final String chosenCateg;

//   ARScene({this.userId, this.chosenCateg});

//   @override
//   _ARSceneState createState() => _ARSceneState();
// }

// class _ARSceneState extends State<ARScene> {
//   ARKitController arkitController;
//   Object human;
//   Object shirt;
//   Texture tshirtTexture;

//   @override
//   void initState() {
//     super.initState();

//     human = Object(
//       fileName: 'assets/human.obj',
//       position: Vector3(0, 0, 0),
//       scale: Vector3(0.1, 0.1, 0.1),
//     );

//     shirt = Object(
//       fileName: 'assets/t-shirt_${widget.userId}.obj',
//       position: Vector3(0, 0, 0),
//       scale: Vector3(0.15, 0.15, 0.15),
//       lighting: true,
//     );

//     // Load the texture image
//     loadTexture();
//   }

//   Future<void> loadTexture() async {
//     final ByteData textureData = await rootBundle.load('assets/t-shirt-texture.png');
//     tshirtTexture = Texture.fromImageData(
//       textureData.buffer.asUint8List(),
//       name: 'tshirtTexture',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ARKitSceneView(
//       onARKitViewCreated: onARKitViewCreated,
//       enableTapRecognizer: true,
//     );
//   }

//   void onARKitViewCreated(ARKitController arkitController) {
//     this.arkitController = arkitController;

//     final scene = arkitController.scene;

//     scene.lightNodes.clear();

//     scene.world.add(human);

//     if (widget.chosenCateg == 'shirt') {
//       // Apply the texture to the shirt object
//       shirt.texture = tshirtTexture;

//       scene.world.add(shirt);
//     }
//   }

//   @override
//   void dispose() {
//     arkitController?.dispose();
//     super.dispose();
//   }
// }
