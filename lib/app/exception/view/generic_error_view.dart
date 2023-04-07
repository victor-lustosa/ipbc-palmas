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
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Icon(Icons.not_listed_location_outlined, size: 40, color: Colors.red,),
            ),
            Center(
              child: Container(
                width: 226.31,
                margin: const EdgeInsets.only(top: 30, bottom: 59.8),
                child: Text(
                  "Ops! Rota não encontrada.",
                  style: AppFonts.titleNoConnection,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
