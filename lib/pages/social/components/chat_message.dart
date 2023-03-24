import 'package:dogs_park/theme/colors.dart';
import 'package:dogs_park/widgets/text_style.dart';
import 'package:flutter/material.dart';

import '../../../theme/dimens.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isUser;
  static ThemeData UserMsgTheme = ThemeData(
    backgroundColor: AppColors.primary,
    textTheme: const TextTheme(
      headline3: TextStyle(
        fontSize: 13,
        color: AppColors.black,
        fontFamily: Dimens.fontFamily,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
  static ThemeData FriendMsgTheme = ThemeData(
    backgroundColor: Colors.grey.shade300,
    textTheme: const TextTheme(
      headline3: TextStyle(
        fontSize: 13,
        color: Colors.white,
        fontFamily: Dimens.fontFamily,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
  const ChatMessage({required this.message, this.isUser = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widthConstrait = MediaQuery.of(context).size.width * 0.65;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      // constraints: BoxConstraints(maxWidth: widthConstrait),
      // width: widthConstrait,
      child: Row(
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isUser
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '2:30',
                      style:
                          AppTextStyle.chatHistoryText.copyWith(fontSize: 12),
                    ),
                  )
                : const SizedBox(),
            isUser
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: const BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                    width: 35,
                    height: 35,
                  ),
            Container(
              width: widthConstrait,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: isUser
                      ? UserMsgTheme.backgroundColor
                      : FriendMsgTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                message,
                maxLines: 10,
                style: isUser
                    ? UserMsgTheme.textTheme.headline3
                    : FriendMsgTheme.textTheme.headline3,
              ),
            ),
            isUser == false
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '2:30',
                      style:
                          AppTextStyle.chatHistoryText.copyWith(fontSize: 12),
                    ),
                  )
                : const SizedBox(),
          ]),
    );
  }
}
