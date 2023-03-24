import 'package:amity_sdk/amity_sdk.dart';
import 'package:dogs_park/pages/login_page/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/model/amity_channel_model.dart';
import '../utils/repository/chat_repo_imp.dart';

class ChannelController extends GetxController {
  static RxInt channelsLength = 0.obs;
  static ScrollController? scrollController = ScrollController();
  static AmityChatRepoImp channelRepoImp = AmityChatRepoImp();
  static List<Channels> _amityChannelList = [];
  static Map<String, ChannelUsers> channelUserMap = {};
  static List<Channels> getChannelList() {
    return _amityChannelList;
  }

  static Future<void> initial() async {
    var accessToken = UserController.getInstance().accessToken;

    await channelRepoImp.initRepo(accessToken);
    print('Initialize channelRepo');
    await channelRepoImp.listenToChannel((messages) {
      ///get channel where channel id == new message channelId
      var channel = _amityChannelList.firstWhere((amityMessage) =>
          amityMessage.channelId == messages.messages?[0].channelId);
      print(
          "${channel.channelId} got new message from ${messages.messages![0].userId}");
      channel.lastActivity = messages.messages![0].createdAt;

      channel.setLatestMessage(
          messages.messages![0].data!.text ?? "Not Text message: 📷");

      if (messages.messages![0].userId !=
          AmityCoreClient.getCurrentUser().userId) {
        ///add unread count by 1
        channel.setUnreadCount(channel.unreadCount + 1);
      }

      print("Channel: " + channel.toString());

      //move channel to the top
      _amityChannelList.remove(channel);
      _amityChannelList.insert(0, channel);
      channelsLength.value = _amityChannelList.length;
    });

    await channelRepoImp.listenToChannelList((channel) {
      _amityChannelList.insert(0, channel);
    });

    await refreshChannels();
  }

  static Future<void> refreshChannels() async {
    print("refreshChannels...");
    await channelRepoImp.fetchChannelsList((data, error) async {
      if (error == null && data != null) {
        _amityChannelList.clear();

        _addUnreadCountToEachChannel(data);

        if (data.channels != null) {
          for (var channel in data.channels!) {
            _addLatestMessage(channel);
            _amityChannelList.add(channel);
            channelsLength.value = _amityChannelList.length;
            String key =
                channel.channelId! + AmityCoreClient.getCurrentUser().userId!;
            if (channelUserMap[key] != null) {
              var count =
                  channel.messageCount! - channelUserMap[key]!.readToSegment!;
              channel.setUnreadCount(count);
            }
          }
        }
      } else {
        print(error.toString());
        // await AmityDialog()
        //     .showAlertErrorDialog(title: "Error!", message: error!);
      }
    });
  }

  static Future<void> _addLatestMessage(Channels channel) async {
    await channelRepoImp.fetchChannelById(
      channelId: channel.channelId!,
      limit: 1,
      callback: (data, error) {
        if (data != null) {
          if (data.messages!.isNotEmpty) {
            var latestMessage =
                data.messages![0].data?.text ?? "Not Text message: 📷";
            print(
                "get latest message from ${channel.channelId} as $latestMessage");
            channel.setLatestMessage(latestMessage);
          } else {
            print("No latest message");
            channel.setLatestMessage("No message yet");
          }
        } else {
          // log("error from : _addLatestMessage => $latestMessage");
        }
      },
    );
  }

  static Future<void> createGroupChannel(String displayName,
      List<String> userIds, Function(ChannelList? data, String? error) callback,
      {String? avatarFileId}) async {
    await channelRepoImp.createGroupChannel(displayName, userIds,
        (data, error) async {
      if (data != null) {
        print("createGroupChannel: success");
        callback(data, null);
      } else {
        print(error.toString());

        callback(null, error);
      }
    }, avatarFileId: avatarFileId);
  }

  static createConversationChannel(List<String> userIds,
      Function(ChannelList? data, String? error) callback) async {
    await channelRepoImp.createConversationChannel(userIds,
        (data, error) async {
      if (data != null) {
        print("createConversationChannel: success ${data}");

        callback(data, null);
      } else {
        print(error.toString());

        callback(null, error);
      }
    });
  }

  static void _addUnreadCountToEachChannel(ChannelList data) {
    for (var channelUser in data.channelUsers!) {
      channelUserMap[channelUser.channelId! + channelUser.userId!] =
          channelUser;
    }
    print("mapReadSegment complete");
  }

  static void removeUnreadCount(String channelId) async {
    ///get channel where channel id == new message channelId

    try {
      if (_amityChannelList.length > 0) {
        var channel = _amityChannelList
            .firstWhere((amityMessage) => amityMessage.channelId == channelId);

        ///set unread count = 0
        channel.setUnreadCount(0);
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
