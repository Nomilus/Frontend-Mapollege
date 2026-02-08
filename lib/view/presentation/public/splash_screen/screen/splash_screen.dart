import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:mapollege/view/presentation/public/splash_screen/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 1)),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.done) {
                RxDouble logoSize = MediaQuery.of(context).size.width.obs;

                return Obx(() {
                  Future.delayed(800.ms, () {
                    logoSize(200.0);
                  });

                  return AnimatedContainer(
                        duration: 200.ms,
                        width: logoSize.value,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Lottie.asset(
                          'assets/jsons/animation.json',
                          repeat: false,
                          animate: true,
                          onLoaded: (composition) {
                            Future.delayed(composition.duration, () {
                              controller.start();
                            });
                          },
                        ),
                      )
                      .animate()
                      .scale(
                        delay: 200.ms,
                        duration: 600.ms,
                        curve: Curves.easeOutBack,
                      )
                      .fadeIn(duration: 1000.ms);
                });
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
