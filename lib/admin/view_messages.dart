import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmoi_mob_app/admin/admin.dart';
import 'package:fitmoi_mob_app/admin/search_user.dart';
import 'package:fitmoi_mob_app/models/user_model.dart';
import 'package:fitmoi_mob_app/provider/user_provider.dart';

import '../models/contact_us_model.dart';
import '../provider/messages_provider.dart';
import '../utils/color.dart';
import '../widgets/app_bar.dart';
import 'search_messages.dart';

class ViewMessagesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> MsgSearch() async {
      await showSearch(
        context: context,
        delegate: MessageSearch(),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: GreyColors,
          title: Text("Messages List"),
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
                MsgSearch();
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: SafeArea(
          child: Consumer(
            builder: (context, watch, _) {
              final mssgs = ref.watch(messagesProvider);
              return mssgs.when(
                data: (value) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      ContactUsModel mssgs = value[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: mintColors),
                                        mssgs.email),
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(mssgs.message),
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
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
