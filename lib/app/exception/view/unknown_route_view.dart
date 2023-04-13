import 'package:flutter/material.dart';
import '../../shared/configs/app_configs.dart';

class UnknownRouteView extends StatefulWidget {
  const UnknownRouteView({super.key});

  @override
  State<UnknownRouteView> createState() => _UnknownRouteViewState();
}

class _UnknownRouteViewState extends State<UnknownRouteView> {

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height* 0.85,
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
    );
  }
}