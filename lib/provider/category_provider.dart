import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/category_service.dart';

final categoriesProvider = FutureProvider((ref) async {
  CategoriesService categService = CategoriesService();
  return await categService.getcategories();
});
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
