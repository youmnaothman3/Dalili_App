import 'package:flutter/material.dart';

class WaitDialog extends StatelessWidget {
  const WaitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
