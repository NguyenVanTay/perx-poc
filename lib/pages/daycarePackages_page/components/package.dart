import 'package:dogs_park/pages/daycarePackages_page/daycare_package_detail.dart';
import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import '../../../widgets/text_style.dart';

class Package extends StatefulWidget {
  String packageName;
  Color packageColor;
  double packagePrice;
  Icon packageIcon;
  int idService;
  String videoUrl;
  Package({
    required this.packageName,
    required this.packageColor,
    required this.packagePrice,
    required this.packageIcon,
    required this.idService,
    required this.videoUrl,
    Key? key,
  }) : super(key: key);

  @override
  State<Package> createState() => _PackageState();
}

class _PackageState extends State<Package> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // style: const ButtonStyle(
      //     backgroundColor: MaterialStatePropertyAll<Color>(AppColors.white)),
      onPressed: () {
        Get.to(const DayCarePackageDetail(), arguments: widget.idService);
      },
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: Dimens.padding_29, horizontal: Dimens.padding_22),
          decoration: BoxDecoration(
              color: widget.packageColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimens.radius_8),
                topRight: Radius.circular(Dimens.radius_8),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.packageName,
                style: AppTextStyle.daycarePackageName,
              ),
              Text(
                '${widget.packagePrice.toInt().toString()}\$',
                style: AppTextStyle.daycarePrice,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: Dimens.padding_10, horizontal: Dimens.padding_22),
          margin: const EdgeInsets.only(bottom: Dimens.margin_17),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(Dimens.radius_8),
                bottomRight: Radius.circular(Dimens.radius_8),
              ),
              border: Border.all(color: widget.packageColor, width: 0.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.packageName[0] + widget.packageName.substring(1).toLowerCase()} Information',
                style: AppTextStyle.daycareInformation
                    .copyWith(color: widget.packageColor),
              ),
              Container(
                width: Dimens.width_40,
                height: Dimens.height_40,
                decoration: BoxDecoration(
                    color: widget.packageColor,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(Dimens.radius_4))),
                child: IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              content: Container(
                                height: 350,
                                child: WebView(
                                  initialUrl: widget.videoUrl,
                                  javascriptMode: JavascriptMode.unrestricted,
                                  onProgress: (progress) {
                                    print(progress);
                                    LinearProgressIndicator(
                                      value: progress / 100,
                                    );
                                  },
                                ),
                              ),
                              // WebView(
                              //     initialUrl:
                              //         'https://www.youtube.com/watch?v=yX71aXkxaWc&t=1s'),
                              //         AspectRatio(
                              //   aspectRatio: _controller.value.aspectRatio,
                              //   child: VideoPlayer(_controller),
                              // ),
                            );
                          },
                          barrierDismissible: true);
                      // openURL(videoUrl);
                    },
                    icon: widget.packageIcon),
              )
            ],
          ),
        )
      ]),
    );
  }

  Future<void> openURL(String url) async {
    var urlI = Uri.parse(url);
    if (await canLaunchUrl(urlI)) {
      await launch(url,
          forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    }
  }
}
