import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/color_constants.dart';

class LoginIconButtons extends ConsumerStatefulWidget {
  const LoginIconButtons({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Icon icon;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginIconButtonsState();
}

class _LoginIconButtonsState extends ConsumerState<LoginIconButtons> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.zero,
        onPressed: widget.onPressed,
        icon: widget.icon,
        color: AppColors.white);
  }
}

// selectedStockBooks.length == 1 ? editAlertMessage : null,