import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmoi_mob_app/admin/admin.dart';
import 'package:fitmoi_mob_app/admin/search_user.dart';
import 'package:fitmoi_mob_app/models/user_model.dart';
import 'package:fitmoi_mob_app/provider/user_provider.dart';

import '../utils/color.dart';
import '../widgets/app_bar.dart';

class ViewUsersPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: GreyColors,
          title: Text("Users List"),
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
                Navigator.pushNamed(context, 'search_users');
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: SafeArea(
          child: Consumer(
            builder: (context, watch, _) {
              final users = ref.watch(usersProvider);
              return users.when(
                data: (value) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      UserModel user = value[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(user.userImage))),
                                ),
                                Column(
                                  children: [
                                    Text(
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: mintColors),
                                        user.email),
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(user.firstname),
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(user.lastname),
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(user.address),
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(user.mobile),
                                  ],
                                ),
                              ],
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
