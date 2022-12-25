import 'package:flutter/material.dart';
import 'package:shop_my/router/routes.dart';
import 'package:shop_my/views/auth/login_screen.dart';
import 'package:shop_my/views/auth/singup_screen.dart';
import 'package:shop_my/views/auth/update_record.dart';
import 'package:shop_my/views/home/add_item.dart';
import 'package:shop_my/views/home/cart_screen.dart';
import 'package:shop_my/views/home/editscreen.dart';
import 'package:shop_my/views/home/historyscreen.dart';
import 'package:shop_my/views/home/home_screen.dart';
import 'package:shop_my/views/loading/splash_screen.dart';

import '../views/home/create_store.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    List<dynamic> parsedSettings = paramsParser(settings);
    String path = parsedSettings[0];
    // ignore: unused_local_variable
    Map<String, String>? params = parsedSettings[1];
    switch (path) {
      case appRootRoute:
        return routeWrapper(const SplashScreen());
      case updateRoute:
        return routeWrapper(const UpdateRecord(
          userkey: '',
        ));
      case CreatetoreRoute:
        return routeWrapper(const CreateStore());
      case AddItemRoute:
        return routeWrapper(const AddItem());

      case historyRoute:
        var data = settings.arguments as Map<String, dynamic>;
        return routeWrapper(Historyscreen(
          cartItems: data["cartItems"],
          total: data["total"],
          total_discount: data["total_discount"],
          total_tax: data["total_tax"],
        ));
      case loginRoute:
        return routeWrapper(const LoginScreen());
      case singupRoute:
        return routeWrapper(const SingupScreen());
      case homeRoute:
        return routeWrapper(const HomeScreen());
      case editRoute:
        return routeWrapper(const Edit());
      case detailsRoute:
        return routeWrapper(CartScreen(
          cartItems: settings.arguments as List,
        ));

      default:
        return routeWrapper(
          Center(
              child: SizedBox(
            child: Column(
              children: [
                Text('No route defined for ${settings.name} '),
                Text('arguments: ${settings.arguments.toString()}'),
              ],
            ),
          )),
        );
    }
  }
}

MaterialPageRoute routeWrapper(Widget widget,
    [bool shouldOverflowVertical = false]) {
  return MaterialPageRoute(
      builder: (context) => Scaffold(
            backgroundColor: Colors.white,
            body: widget,
          ));
}

List<dynamic> paramsParser(RouteSettings settings) {
  String path = settings.name!;
  Map<String, String>? params;
  if (settings.name!.length > 1 && settings.name!.contains("?")) {
    List<String> splitedUrl = settings.name!.split("?");
    path = splitedUrl[0];
    params = Uri.splitQueryString(splitedUrl[1].toString());
  }
  return [path, params];
}
