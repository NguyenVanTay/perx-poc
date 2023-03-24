import 'package:amity_sdk/amity_sdk.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

import '../model/amity_channel_model.dart';
import '../model/amity_message_model.dart';
import '../model/amity_response_model.dart';
import 'chat_repo.dart';

class AmityChatRepoImp implements AmityChatRepo {
  late Socket socket;

  @override
  Future<void> initRepo(String accessToken) async {
    print("initAmityChatRepo...");
    print("Access token init Chat Repo: " + accessToken);

    socket = io.io(
        'wss://api.${dotenv.env["REGION"]}.amity.co/?token=$accessToken',
        io.OptionBuilder().setTransports(["websocket"]).build());
    print(socket.query);
    socket.onConnectError((data) => print("on Connect Error Socket:$data"));
    socket.onConnecting((data) => print("connecting..."));

    socket.onConnect((_) {
      print('connected');
    });

    socket.onDisconnect((data) => log("onDisconnect:$data"));
  }

  @override
  Future<void> fetchChannelById(
      {String? paginationToken,
      int? limit = 30,
      required String channelId,
      required Function(
        AmityMessageChat?,
        String?,
      )
          callback}) async {
    print("fetchChannelById...");
    socket.emitWithAck('v3/message.query', {
      "channelId": "$channelId",
      "options": {"last": limit, "token": paginationToken}
    }, ack: (data) {
      print("Fetch channel success: " + channelId);
      var amityResponse = AmityResponse.fromJson(data);
      print(data);
      var responsedata = amityResponse.data;
      if (amityResponse.status == "success") {
        //success
        var amityMessages = AmityMessageChat.fromJson(responsedata!.json!);

        callback(amityMessages, null);
      } else {
        //error

        callback(null, amityResponse.message);
      }
    });
  }

  @override
  Future<void> listenToChannel(Function(AmityMessageChat) callback) async {
    log("listenToChannelById...");
    socket.on('message.didCreate', (data) async {
      var messageObj = await AmityMessageChat.fromJson(data);

      callback(messageObj);
    });
  }

  //   @override
  // Future<void> listenToChannelList(Function(AmityMessage) callback) async {
  //   log("listenToChannelById...");
  //   socket.on('channel.didCreate', (data) async {
  //     var messageObj = await AmityMessage.fromJson(data);

  //     callback(messageObj);
  //   });
  // }

  @override
  Future<void> reactMessage(String messageId) async {
    log("reactMessage...");
  }

  @override
  Future<void> sendImageMessage(String channelId, String text,
      Function(AmityMessageChat?, String?) callback) async {
    log("sendImageMessage...");
  }

  @override
  Future<void> sendTextMessage(String channelId, String text,
      Function(AmityMessageChat?, String?) callback) async {
    log("sendTextMessage...");
    log("fetchChannelById...");
    socket.emitWithAck('v3/message.create', {
      "channelId": "$channelId",
      "type": "text",
      "data": {"text": "$text"}
    }, ack: (data) {
      var amityResponse = AmityResponse.fromJson(data);
      var responsedata = amityResponse.data;
      if (amityResponse.status == "success") {
        //success
        log(responsedata!.json.toString());
        var amityMessages = AmityMessageChat.fromJson(responsedata.json!);

        callback(amityMessages, null);
      } else {
        //error
        callback(null, amityResponse.message);
      }
    });
  }

  void disposeRepo() {
    socket.clearListeners();
    socket.close();
  }

  Future<void> fetchChannelsList(
      Function(ChannelList? data, String? error) callback) async {
    print("fetchChannels...");

    socket.emitWithAck('v3/channel.query', {
      "filter": "member",
      "options": {
        "limit": 100,
      }
    }, ack: (data) {
      print('Data respond from channel list fetch...');
      print(data);
      var amityResponse = AmityResponse.fromJson(data);
      var responsedata = amityResponse.data;
      if (amityResponse.status == "success") {
        //success
        var amityChannels = ChannelList.fromJson(responsedata!.json!);

        callback(amityChannels, null);
      } else {
        //error
        callback(null, amityResponse.message);
      }
    });
    // print(socket.toString());
    print("Emitted with ack" + socket.acks.toString());
  }

  Future<void> listenToChannelList(Function(Channels) callback) async {
    log("listenToChannelListUpdate...");
    socket.on('v3.channel.didCreate', (data) async {
      var channelObj = await ChannelList.fromJson(data);

      callback(channelObj.channels![0]);
    });
  }

  Future<void> startReading(String channelId,
      {Function(String? data, String? error)? callback}) async {
    socket.emitWithAck('channel.startReading', {"channelId": "$channelId"},
        ack: (data) async {
      var amityResponse = await AmityResponse.fromJson(data);
      var responsedata = amityResponse.data;
      if (amityResponse.status == "success") {
        //success
        log("startReading: success");
        callback!("success", null);
      } else {
        //error
        log("startReading: error: ${amityResponse.message}");
        callback!(null, amityResponse.message);
      }
    });
  }

  Future<void> createGroupChannel(String displayName, List<String> userIds,
      Function(ChannelList? data, String? error) callback,
      {String? avatarFileId}) async {
    log("createChannels...");
    socket.emitWithAck('v3/channel.create', {
      "type": "community",
      "displayName": displayName,
      "avatarFileId": avatarFileId,
      "userIds": userIds
    }, ack: (data) {
      var amityResponse = AmityResponse.fromJson(data);
      var responsedata = amityResponse.data;
      if (amityResponse.status == "success") {
        //success
        var amityChannel = ChannelList.fromJson(responsedata!.json!);
        callback(amityChannel, null);
      } else {
        //error
        callback(null, amityResponse.message);
      }
    });
  }

  Future<void> createConversationChannel(List<String> userIds,
      Function(ChannelList? data, String? error) callback) async {
    log("createChannels...");
    socket.emitWithAck('v3/channel.createConversation', {"userIds": userIds},
        ack: (data) {
      var amityResponse = AmityResponse.fromJson(data);
      var responsedata = amityResponse.data;
      if (amityResponse.status == "success") {
        //success
        var amityChannel = ChannelList.fromJson(responsedata!.json!);
        callback(amityChannel, null);
      } else {
        //error
        callback(null, amityResponse.message);
      }
    });
  }

  Future<void> stopReading(String channelId,
      {Function(String? data, String? error)? callback}) async {
    socket.emitWithAck('channel.stopReading', {
      {"channelId": "$channelId"}
    }, ack: (data) async {
      var amityResponse = await AmityResponse.fromJson(data);
      if (amityResponse.status == "success") {
        //success
        log("stopReading: success");
        callback!("success", null);
      } else {
        //error
        log("stopReading: error: ${amityResponse.message}");
        callback!(null, amityResponse.message);
      }
    });
  }

  Future<void> markSeen(String channelId) async {
    socket.emitWithAck('v3/channel.maekSeen', {
      {"channelId": "$channelId", "readToSegment": 100}
    }, ack: (data) async {
      var amityResponse = await AmityResponse.fromJson(data);
      if (amityResponse.status == "success") {
        //success
        log("merkSeen: success");
      } else {
        //error
        log("merkSeen: error: ${amityResponse.message}");
      }
    });
  }

  @override
  Future<void> searchUser(String keyword,
      {Function(List<AmityUser>? data, String? error)? callback,
      String? accessToken}) async {
    // print("check socket ${socket}");
    await initRepo(accessToken!);

    socket.emitWithAck('user.query', {
      "search": keyword,
      "sortBy": "displayName",
    }, ack: (data) {
      var amityResponse = AmityResponse.fromJson(data);
      var responsedata = amityResponse.data;
      List<AmityUser> users = [];
      if (amityResponse.status == "success") {
        var userList = responsedata!.json!;
        for (var user in userList["results"]) {
          var amityUser = AmityUser();
          amityUser.userId = user["userId"];
          amityUser.displayName = user["displayName"];
          users.add(amityUser);
        }
        // userList.forEach((key, value) {
        //   print("check key value ${key} ${value}");
        // });

        callback!(users, null);
      } else {
        //error
        callback!(null, "");
        // callback(null, amityResponse.message);
      }
    });
  }
}
