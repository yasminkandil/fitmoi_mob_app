import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmoi_mob_app/services/refund_service.dart';

final refundsProvider = FutureProvider((ref) async {
  RefundsService refService = RefundsService();
  return await refService.getRefunds();
});
