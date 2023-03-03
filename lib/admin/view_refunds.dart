import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitmoi_mob_app/admin/refund_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmoi_mob_app/admin/admin.dart';
import 'package:fitmoi_mob_app/admin/search_user.dart';
import 'package:fitmoi_mob_app/models/user_model.dart';
import 'package:fitmoi_mob_app/provider/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/contact_us_model.dart';
import '../models/refund_model.dart';
import '../provider/refund_provider.dart';
import '../utils/color.dart';
import '../widgets/app_bar.dart';
import '../widgets/upload_images.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

//import 'search_Refunds.dart';
void sendAcceptEmail(String userEmail) async {
  try {
    final smtpServer = gmail('fitt.moii@gmail.com', 'pitycvgftdvztwym');

    final message = Message()
      ..from = const Address('fitt.moii@gmail.com', 'Fit-Moi')
      ..recipients.add(userEmail)
      ..subject = 'Refund Accepted'
      ..text =
          'You will be contacted to recieve your money back and give us the defected product';

    final sendReport = await send(message, smtpServer);
    print('Message sent: ${sendReport.toString()}');
  } on MailerException catch (e) {
    print('Message not sent. $e');
  }
}

void sendDeclineEmail(String userEmail) async {
  try {
    final smtpServer = gmail('fitt.moii@gmail.com', 'pitycvgftdvztwym');

    final message = Message()
      ..from = const Address('fitt.moii@gmail.com', 'Fit-Moi')
      ..recipients.add(userEmail)
      ..subject = 'Refund Declined'
      ..text = "Sorry we can't accept your refund request";

    final sendReport = await send(message, smtpServer);
    print('Message sent: ${sendReport.toString()}');
  } on MailerException catch (e) {
    print('Message not sent. $e');
  }
}

class ViewRefundsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: GreyColors,
          title: Text("Refunds List"),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: mintColors,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
              onPressed: () {
                // method to show the search bar
                //context: context, delegate:
                //MsgSearch();
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: SafeArea(
          child: Consumer(
            builder: (context, watch, _) {
              final reff = ref.watch(refundsProvider);
              return reff.when(
                data: (value) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      RefundModel reff = value[index];

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 350,
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Product Code:",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: mintColors),
                                  ),
                                  Text(reff.prodid),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return Scaffold(
                                              body: GestureDetector(
                                                child: Center(
                                                  child: Hero(
                                                    tag: 'image',
                                                    child: Image.network(
                                                      reff.image1,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          }));
                                        },
                                        child: Container(
                                          width: 110,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1))
                                              ],
                                              shape: BoxShape.rectangle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      reff.image1))),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (() {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return Scaffold(
                                              body: GestureDetector(
                                                child: Center(
                                                  child: Hero(
                                                    tag: 'image',
                                                    child: Image.network(
                                                      reff.image2,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          }));
                                        }),
                                        child: Container(
                                          width: 110,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white),
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1))
                                              ],
                                              shape: BoxShape.rectangle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      reff.image2))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: mintColors),
                                        reff.useremail,
                                      ),
                                      Text(reff.reason),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          const IconData(0xe857,
                                              fontFamily: 'MaterialIcons'),
                                          color: mintColors,
                                        ),
                                        onPressed: () {
                                          sendAcceptEmail(reff.useremail);
                                          Fluttertoast.showToast(
                                              msg: "Email Sent..");
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: mintColors,
                                        ),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('refunds')
                                              .doc(reff.id)
                                              .delete()
                                              .then((value) {
                                            sendDeclineEmail(reff.useremail);
                                            Fluttertoast.showToast(
                                                msg: "Email Sent..");
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: mintColors,
                            height: 10,
                            thickness: 3,
                            indent: 25,
                            endIndent: 25,
                          )
                        ],
                      );
                    },
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Text(error.toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}
