import 'package:flutter/material.dart';

import '../../shared/configs/app_configs.dart';
import '../../shared/mixins/clipboard_mixin.dart';

class GenericErrorView extends StatefulWidget {
  const GenericErrorView({super.key});

  @override
  State<GenericErrorView> createState() => _GenericErrorViewState();
}

class _GenericErrorViewState extends State<GenericErrorView> with ClipboardMixin {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Icon(Icons.error_outline_outlined, size: 50, color: Colors.red,),
          ),
          Center(
            child: Container(
              width: 226.31,
              margin: const EdgeInsets.only(top: 30, bottom: 59.8),
              child: Text(
                "Ops! Ocorreu um erro no Sistema.",
                style: AppFonts.titleNoConnection,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
