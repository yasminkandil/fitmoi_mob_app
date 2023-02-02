import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/product_service.dart';

final productsProvider = FutureProvider((ref) async {
  ProductsService prodService = ProductsService();
  return await prodService.getproducts();
});
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
