import 'dart:io';

import 'package:amity_sdk/amity_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

import '../components/alert_dialog.dart';

class AmityFileInfoWithUploadStatus {
  AmityFileInfo? fileInfo;
  bool isComplete = false;
  File? file;
  void addFile(AmityFileInfo amityFileInfo) {
    fileInfo = amityFileInfo;
    isComplete = true;
  }

  void addFilePath(File file) {
    this.file = file;
  }
}

class NewPostController extends GetxController {
  final textEditingController = TextEditingController().obs;
  RxInt amityImageLength = 0.obs;
  RxBool isVideoChosen = false.obs;
  final Rx<ImagePicker> _picker = ImagePicker().obs;
  List<AmityFileInfoWithUploadStatus> amityImages = [];
  AmityFileInfoWithUploadStatus amityVideo = AmityFileInfoWithUploadStatus();

  void initialize() {
    textEditingController.value.clear();
    isVideoChosen.value = false;
    amityImages.clear();
  }

  bool isNotSelectedImageYet() {
    if (amityImages.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isNotSelectVideoYet() {
    if (amityVideo.file == null) {
      return true;
    } else {
      return false;
    }
  }

  void getPost(String postId) {
    print('Run get pót');
    AmitySocialClient.newPostRepository()
        .getPost(postId)
        .then((AmityPost post) {
      print('Get possr succtess');
      print(post.createdAt);
      //handle result
    }).onError<AmityException>((error, stackTrace) {
      //handle error
      print('Error in get pót');
    });
  }

  Future<void> createTextpost(BuildContext context,
      {String? communityId}) async {
    print("createTextpost...");
    print(textEditingController.value.text);
    bool isCommunity = (communityId != null) ? true : false;
    if (isCommunity) {
      log("in community...");
      await AmitySocialClient.newPostRepository()
          .createPost()
          .targetCommunity(communityId)
          .text(textEditingController.value.text)
          .post()
          .then((AmityPost post) {
        ///add post to feed
        // Provider.of<CommuFeedVM>(context, listen: false).addPostToFeed(post);
        // Provider.of<CommuFeedVM>(context, listen: false)
        //     .scrollcontroller
        //     .jumpTo(0);
        // notifyListeners();
        print('POST CREATED');
      }).onError((error, stackTrace) async {
        log(error.toString());
        // await AmityDialog()
        //     .showAlertErrorDialog(title: "Error!", message: error.toString());
      });
    } else {
      await AmitySocialClient.newPostRepository()
          .createPost()
          .targetMe() // or targetMe(), targetCommunity(communityId: String)
          .text(textEditingController.value.text)
          .post()
          .then((AmityPost post) {
        ///add post to feed
        // Provider.of<FeedVM>(context, listen: false).addPostToFeed(
        //   post,
        // );
        // Provider.of<FeedVM>(context, listen: false).scrollcontroller.jumpTo(0);
        // notifyListeners();
      }).onError((error, stackTrace) async {
        log(error.toString());
        // await AmityDialog()
        //     .showAlertErrorDialog(title: "Error!", message: error.toString());
      });
    }
  }

  Future<void> addFiles() async {
    if (isNotSelectVideoYet()) {
      final List<XFile>? images =
          await _picker.value.pickMultiImage(maxHeight: 480, imageQuality: 100);
      if (images != null) {
        for (var image in images) {
          var fileWithStatus = AmityFileInfoWithUploadStatus();
          amityImages.add(fileWithStatus);
          // notifyListeners();
          await AmityCoreClient.newFileRepository()
              .image(File(image.path))
              .upload()
              .then((value) {
            if (value is AmityUploadComplete) {
              var fileInfo = value as AmityUploadComplete;
              amityImages.last.addFile(fileInfo.getFile);
            } else {
              log(value.toString());
            }
            // notifyListeners();
          }).onError((error, stackTrace) async {
            log("error: ${error}");
            // await AmityDialog().showAlertErrorDialog(
            //     title: "Error!", message: error.toString());
          });
          print("Image selected: " + image.name);
          // print()
        }
        amityImageLength.value = amityImages.length;
        print("Image length: " + images.length.toString());
        print("Image amity length: " + amityImages.length.toString());
      }
    }
  }

  Future<void> addFileFromCamera() async {
    if (isNotSelectVideoYet()) {
      final XFile? image =
          await _picker.value.pickImage(source: ImageSource.camera);
      print('Image pick' + (image == null).toString());

      if (image != null) {
        var fileWithStatus = AmityFileInfoWithUploadStatus();
        amityImages.add(fileWithStatus);
        // notifyListeners();
        await AmityCoreClient.newFileRepository()
            .image(File(image.path))
            .upload()
            .then((value) {
          var fileInfo = value as AmityUploadComplete;
          print(fileInfo);
          amityImages.last.addFile(fileInfo.getFile);
          // notifyListeners();
        }).onError((error, stackTrace) async {
          log("error: ${error}");
          await AmityDialog()
              .showAlertErrorDialog(title: "Error!", message: error.toString());
        });
      }
    }
  }

  Future<void> addVideo() async {
    if (isNotSelectedImageYet()) {
      try {
        final XFile? video =
            await _picker.value.pickVideo(source: ImageSource.gallery);
        print('Picked Video');
        print(video == null);
        if (video != null) {
          var fileWithStatus = AmityFileInfoWithUploadStatus();

          amityVideo = fileWithStatus;
          amityVideo.file = File(video.path);
          print(video.path);
          print('Run to Amity Video upload');
          // notifyListeners();
          await AmityCoreClient.newFileRepository()
              .video(File(video.path))
              .upload()
              .then((value) {
            var fileInfo = value as AmityUploadComplete;
            print('Video is chosen');
            amityVideo.addFile(fileInfo.getFile);

            log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${fileInfo.getFile.fileId}");

            // notifyListeners();
          }).onError((error, stackTrace) async {
            log("error: ${error}");
            // await AmityDialog().showAlertErrorDialog(
            //     title: "Error!", message: error.toString());
          });
          isVideoChosen.value = true;
        } else {
          log("error: video is null");
          // await AmityDialog().showAlertErrorDialog(
          //     title: "Error!", message: "error: video is null");
        }
      } catch (error) {
        log("error: ${error}");
        // await AmityDialog()
        //     .showAlertErrorDialog(title: "Error!", message: error.toString());
      }
    }
  }

  void deleteImageAt({required int index}) {
    amityImages.removeAt(index);
  }

  //if image is selected, post can't contain videos

  Future<void> createPost(BuildContext context, {String? communityId}) async {
    HapticFeedback.heavyImpact();
    bool isCommunity = (communityId != null) ? true : false;
    print("Create post");
    if (isCommunity) {
      if (isNotSelectVideoYet() && isNotSelectedImageYet()) {
        log("isNotSelectVideoYet() & isNotSelectVideoYet()");

        ///create text post
        await createTextpost(context, communityId: communityId);
        print('Create text post.....');
      } else if (isNotSelectedImageYet()) {
        log("isNotSelectedImageYet");

        ///create video post
        await creatVideoPost(context, communityId: communityId);
      } else if (isNotSelectVideoYet()) {
        log("isNotSelectVideoYet");

        ///create image post
        await creatImagePost(context, communityId: communityId);
      }
    } else {
      print(isNotSelectVideoYet());
      print(isNotSelectedImageYet());
      if (isNotSelectVideoYet() && isNotSelectedImageYet()) {
        print("isNotSelectVideoYet() & isNotSelectVideoYet()");

        ///create text post
        print('Create text post.....');
        await createTextpost(context);
      } else if (isNotSelectedImageYet()) {
        print("isNotSelectedImageYet");

        ///create video post
        await creatVideoPost(context);
      } else if (isNotSelectVideoYet()) {
        print("isNotSelectVideoYet");

        ///create image post
        await creatImagePost(context);
        print('Create Image post');
      }
    }
  }

  Future<void> creatImagePost(BuildContext context,
      {String? communityId}) async {
    log("creatImagePost...");
    List<AmityImage> _images = [];
    for (var amityImage in amityImages) {
      if (amityImage.fileInfo is AmityImage) {
        var image = amityImage.fileInfo as AmityImage;
        _images.add(image);
        log("add file to _images");
      }
    }
    log(_images.toString());
    bool isCommunity = (communityId != null) ? true : false;
    if (isCommunity) {
      await AmitySocialClient.newPostRepository()
          .createPost()
          .targetCommunity(communityId)
          .image(_images)
          .text(textEditingController.value.text)
          .post()
          .then((AmityPost post) {
        ///add post to feedx
        // Provider.of<CommuFeedVM>(context, listen: false).addPostToFeed(post);
        // Provider.of<CommuFeedVM>(context, listen: false)
        //     .scrollcontroller
        //     .jumpTo(0);
      }).onError((error, stackTrace) async {
        log(error.toString());
        // await AmityDialog()
        //     .showAlertErrorDialog(title: "Error!", message: error.toString());
      });
    } else {
      await AmitySocialClient.newPostRepository()
          .createPost()
          .targetMe()
          .image(_images)
          .text(textEditingController.value.text)
          .post()
          .then((AmityPost post) {
        ///add post to feedx
        // Provider.of<FeedVM>(context, listen: false).addPostToFeed(post);
        // Provider.of<FeedVM>(context, listen: false).scrollcontroller.jumpTo(0);
      }).onError((error, stackTrace) async {
        log(error.toString());
        // await AmityDialog()
        //     .showAlertErrorDialog(title: "Error!", message: error.toString());
      });
    }
  }

  Future<void> creatVideoPost(BuildContext context,
      {String? communityId}) async {
    log("creatVideoPost...");
    if (amityVideo != null) {
      bool isCommunity = (communityId != null) ? true : false;
      if (isCommunity) {
        await AmitySocialClient.newPostRepository()
            .createPost()
            .targetCommunity(communityId)
            .video([amityVideo.fileInfo as AmityVideo])
            .text(textEditingController.value.text)
            .post()
            .then((AmityPost post) {
              ///add post to feedx
              // Provider.of<CommuFeedVM>(context, listen: false)
              //     .addPostToFeed(post);
              // Provider.of<CommuFeedVM>(context, listen: false)
              //     .scrollcontroller
              //     .jumpTo(0);
            })
            .onError((error, stackTrace) async {
              // await AmityDialog().showAlertErrorDialog(
              //     title: "Error!", message: error.toString());
            });
      } else {
        await AmitySocialClient.newPostRepository()
            .createPost()
            .targetMe()
            .video([amityVideo?.fileInfo as AmityVideo])
            .text(textEditingController.value.text)
            .post()
            .then((AmityPost post) {
              ///add post to feedx
              // Provider.of<FeedVM>(context, listen: false).addPostToFeed(post);
              // Provider.of<FeedVM>(context, listen: false)
              //     .scrollcontroller
              //     .jumpTo(0);
            })
            .onError((error, stackTrace) async {
              // await AmityDialog().showAlertErrorDialog(
              //     title: "Error!", message: error.toString());
            });
      }
    }
  }
}
