
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class FontStyleManager {
  static final FontStyleManager instance = FontStyleManager._internal();
  factory FontStyleManager()=>instance;
  FontStyleManager._internal();

  String suit = "Suit";


  FontWeight weightMedium = FontWeight.w500;
  FontWeight weightRegular = FontWeight.w400;
  FontWeight weightBold = FontWeight.w700;
  FontWeight weightCategoryTitle = FontWeight.w600;
  FontWeight weightHashTagChip = FontWeight.w800;
}