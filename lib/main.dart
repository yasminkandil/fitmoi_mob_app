import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitmoi_mob_app/pages/forgot_pass.dart';
import 'package:fitmoi_mob_app/pages/login_page.dart';
import 'package:fitmoi_mob_app/pages/must_have_account.dart';
import 'package:fitmoi_mob_app/pages/regi_page.dart';
import 'package:fitmoi_mob_app/pages/try-on.dart';
import 'package:fitmoi_mob_app/pages/view_account.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmoi_mob_app/admin/admin.dart';

import 'package:fitmoi_mob_app/home/home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:fitmoi_mob_app/home/navbar.dart';

import 'admin/add_category.dart';
import 'admin/add_product.dart';
import 'admin/view_categories.dart';
import 'admin/view_product.dart';

//import 'pages/cart_view.dart';
//import 'pages/calendar.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A new message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fitmoi',
      initialRoute: "homepage",
      routes: {
        "homepage": (context) => const MyHomePage(),
        "navbar": (context) => Navigation_bar(),
        'login': (context) => LoginPage(),
        'tryon': (context) => TryOn(),
        'register': (context) => RegisterPage(),
        'dashboard': (context) => const Admin(),
        'profile': (context) => const ViewAccountPage(),
        /*'cart': (context) => CartItem(),
        'shop': (context) => Products(cat: 'Cables'),
        'contact_us': (context) => ContactUs(),
        'gallery': (context) => gallery(),*/
        'must_have_account': (context) => MustHaveAccountPage(),
        'add_category': (context) => AddCategPage(),
        'view_categories': (context) => const ViewCategoriesPage(),
        /* 'order_history': (context) => OrderScreen(ord: 'salma'),
        'view_users': (context) => ViewUsersPage(),
        'view_orders': (context) => ViewOrdersPage(),
        'view_messages': (context) => ViewMessagesPage(),
        
        'view_colors': (context) => const ViewcolorsPage(),
        'view_qualties': (context) => const ViewQualitiesPage(),
        
        
        'add_color': (context) => AddColorPage(),
        'add_quality': (context) => AddQualityPage(),
        
        'add_homeimage': (context) => const AddGalleryhome(),
        'add_gallery': (context) => const AddGallery(),
        'search_users': (context) => const FirebaseSearchUserScreen(),
        //'search_products': (context) => const ProductSearch(),
        
        'araf': (context) => Offerrphoto(),*/
        'forgot_pass': (context) => const ForgotPass(),
        'add_product': (context) => AddProductPage(),
        'view_products': (context) => const ViewProductPage(),
      },
    );
  }
}
