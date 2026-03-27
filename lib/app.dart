import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_character/route/routes.dart';

import 'core/utils/constants/app_sizer.dart';
import 'core/utils/constants/app_sizes.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: Routes.goRouter,
          title: 'Rick And Morty Character App',

          //home: BottomNavScreen (),
          // builder: (context, child) {
          //   // Set global context for auth error handler
          //   //AuthErrorHandler.setGlobalContext(context);
          //   return hasConnection ? child! : const NoInternetWidget();
          // },
        );
      },
    );
  }
}
