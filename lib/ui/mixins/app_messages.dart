import 'package:another_flushbar/flushbar.dart';
import '/ui/theme/app_colors.dart';
import '../../core/extensions/media_query_extensions.dart';
import 'package:flutter/material.dart';

import '../theme/custom_text_styles.dart';

mixin AppMessages<T extends StatefulWidget> on State<T> {
  Future<void> customDialog({
    required String title,
    required String body,
    Image? bannerImage,
    required String buttonLabel,
    VoidCallback? onTap,
    String? secondButtonLabel,
    VoidCallback? secondButtonOnTap,
    bool hasCloseButton = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          width: context.screenWidth * .9,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Material(
              color: Colors.white,
              child: Column(
                spacing: 10,
                children: [
                  if (hasCloseButton)
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close),
                      ),
                    ),

                  /// Title
                  Text(
                    title,
                    style: CustomTextStyles.mediumTitle,
                    textAlign: TextAlign.center,
                  ),
                  ?bannerImage,

                  /// Body
                  Text(
                    body,
                    style: CustomTextStyles.body,
                    textAlign: TextAlign.center,
                  ),

                  /// Top Button
                  ElevatedButton(
                    onPressed: onTap ?? () => Navigator.pop(context),
                    child: Text(buttonLabel),
                  ),

                  /// Optional Bottom Button
                  if (secondButtonLabel != null)
                    ElevatedButton(
                      onPressed:
                          secondButtonOnTap ?? () => Navigator.pop(context),
                      child: Text(secondButtonLabel),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void customFlushBar(
    String message, {
    Color color = AppColors.error,
    bool positionAtTop = true,
  }) async {
    await Flushbar(
      message: message,
      messageText: Text(
        message,
        style: CustomTextStyles.body.copyWith(color: Colors.white),
      ),
      flushbarPosition: positionAtTop
          ? FlushbarPosition.TOP
          : FlushbarPosition.BOTTOM,
      backgroundColor: color,
      borderRadius: BorderRadius.circular(12),
      duration: Duration(seconds: 3),
    ).show(context);
  }

  void showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }

  void hideLoading() {
    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
