import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitmoi_mob_app/services/messages_services.dart';

final messagesProvider = FutureProvider((ref) async {
  MessagesService mssgService = MessagesService();
  return await mssgService.getmessages();
});
