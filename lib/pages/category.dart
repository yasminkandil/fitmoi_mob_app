// import 'package:flutter/material.dart';
// import 'package:fitmoi_mob_app/pages/products_all.dart';
// import 'package:fitmoi_mob_app/utils/color.dart';
// import 'package:fitmoi_mob_app/style/style.dart';

// class CategoryPage extends StatelessWidget {
//   const CategoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: Stack(
//       children: [
//         SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.only(left: 6),
//             height: size.height,
//             width: size.width,
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 50, 49, 48),
//             ),
//             child: SafeArea(
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Image.asset(
//                           'assets/noBack.png',
//                           height: 150,
//                           width: 150,
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           'Category',
//                           style: AppStyle.r12w,
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Text(
//                       'Shop Now',
//                       style: AppStyle.b32w,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//             height: size.height - (size.height / 5),
//             width: size.width,
//             decoration: BoxDecoration(
//                 color: mintColors, borderRadius: BorderRadius.circular(40)),
//             child: Column(children: [
//               Row(
//                 children: [
//                   Text(
//                     "all",
//                     style: AppStyle.m12b
//                         .copyWith(decoration: TextDecoration.underline),
//                   ),
//                   const SizedBox(
//                     width: 30,
//                   ),
//                   Text(
//                     "Favorite",
//                     style: AppStyle.m12bt,
//                   ),
//                   const SizedBox(
//                     width: 30,
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         const SizedBox(height: 70),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         Products(cat: 'Covers')));
//                           },
//                           child: const shortproducts(
//                             background: Color.fromARGB(255, 68, 69, 71),
//                             title: 'Cover Cases',
//                             image: 'assets/covercase.png',
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         Products(cat: 'Powerbank')));
//                           },
//                           child: const longproducts(
//                               background: Color.fromARGB(255, 79, 75, 75),
//                               title: 'Power Banks',
//                               image: 'assets/powerbank.png'),
//                         ),
//                         const SizedBox(height: 70),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         Products(cat: 'Headphones')));
//                           },
//                           child: const shortproducts(
//                             background: Color.fromARGB(255, 60, 57, 57),
//                             title: 'Head Phones',
//                             image: 'assets/headphone.png',
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         Products(cat: 'Cables')));
//                           },
//                           child: const longproducts(
//                               background: Color.fromARGB(255, 63, 60, 60),
//                               title: 'Cables',
//                               image: 'assets/cables.png'),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               )
//             ]),
//           ),
//         ),
//       ],
//     ));
//   }
// }

// class longproducts extends StatelessWidget {
//   final Color background;
//   final String title;
//   final String image;
//   const longproducts(
//       {super.key,
//       required this.background,
//       required this.title,
//       required this.image});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 155,
//       height: 192,
//       decoration: BoxDecoration(
//           color: background,
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(color: Colors.white, width: 2),
//           boxShadow: [
//             BoxShadow(
//                 blurRadius: 50, color: const Color(0xFF0B0C2A).withOpacity(.1))
//           ]),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 16),
//           Text(title, style: AppStyle.m12w),
//           Expanded(child: Image.asset(image))
//         ],
//       ),
//     );
//   }
// }

// class shortproducts extends StatelessWidget {
//   final Color background;
//   final String title;
//   final String image;
//   const shortproducts(
//       {super.key,
//       required this.background,
//       required this.title,
//       required this.image,
//       requiredonPress});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       width: 155,
//       height: 163,
//       decoration: BoxDecoration(
//           color: background,
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(color: Colors.white, width: 2),
//           boxShadow: [
//             BoxShadow(
//                 blurRadius: 50, color: const Color(0xFF0B0C2A).withOpacity(.1))
//           ]),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 16),
//           Text(title, style: AppStyle.m12w),
//           Expanded(child: Image.asset(image))
//         ],
//       ),
//     );
//   }
// }
