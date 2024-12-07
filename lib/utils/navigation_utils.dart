import 'package:flutter/material.dart';

mixin NavigatorUtils {
  
  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static Future<dynamic> push(BuildContext context, String routeName, {Map<String, dynamic>? arguments}) {
    return Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil((route) {
      return route.settings.name == routeName || Navigator.of(context).canPop() == false;
    });
  }
}