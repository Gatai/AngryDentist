import 'package:flutter/widgets.dart';

class SizeConfig {
  /*
  We need to import ‘widgets.dart’ in order to use a very convenient class 
  in Flutter that’s called MediaQueryData which holds the information of
  the current media, among which there is the size of our screen.
  */
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

//initialize those values by writing a constructor function.
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}
