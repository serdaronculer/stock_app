import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/constants.dart';

class CustomTextField extends ConsumerWidget {
  const CustomTextField({
    Key? key,
    required this.textController,
    required this.text,
    required this.hintText,
    required this.materialColor,
    this.isNumber = false,
  }) : super(key: key);
  final TextEditingController textController;
  final String text;
  final String hintText;
  final bool isNumber;
  final MaterialColor materialColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.smallPadding, horizontal: AppPadding.mediumPadding),
      decoration: BoxDecoration(
        color: materialColor[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: AppPadding.largePadding),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: materialColor[900],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                maxLength: 9,
                controller: textController,
                inputFormatters: isNumber ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))] : null,
                keyboardType: isNumber ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  hintText: hintText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
