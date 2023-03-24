import '../model/amity_message_model.dart';

class AmityChatRepo {
  Future<void> initRepo(String accessToken) async {}
  Future<void> searchUser(String keyword) async {}

  Future<void> listenToChannel(Function(AmityMessageChat) callback) async {}

  Future<void> fetchChannelById(
      {String? paginationToken,
      required String channelId,
      required Function(AmityMessageChat?, String?) callback}) async {}

  Future<void> sendTextMessage(String channelId, String text,
      Function(AmityMessageChat?, String?) callback) async {}

  Future<void> sendImageMessage(String channelId, String text,
      Function(AmityMessageChat?, String?) callback) async {}

  Future<void> reactMessage(String messageId) async {}
}
