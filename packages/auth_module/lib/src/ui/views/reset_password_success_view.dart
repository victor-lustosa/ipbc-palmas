import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../auth_module.dart';

class ResetPasswordSuccessView extends StatelessWidget {
  const ResetPasswordSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: context.mediaQuery.size.width,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 162, bottom: 25),
                  child: const Image(
                    image: AssetImage(AppImages.lock),
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Nova senha',
                  style: AppFonts.defaultFont(
                    color: AppColors.grey10,
                    fontSize: 22,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  'criada com sucesso!',
                  style: AppFonts.defaultFont(
                    color: AppColors.grey10,
                    fontSize: 22,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: context.mediaQuery.size.height * .37,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: ButtonWidget(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 48),
                    action: () {
                      navigate(AuthModule.authRoute + AuthModule.loginRoute);
                    },
                    backgroundColor: AppColors.darkGreen,
                    shadowColor: AppColors.grey0,
                    foregroundColor: AppColors.white,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continuar para o login",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
