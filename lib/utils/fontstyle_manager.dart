
import 'dart:ui';

class FontStyleManager {
  static final FontStyleManager instance = FontStyleManager._internal();
  factory FontStyleManager()=>instance;
  FontStyleManager._internal();

  String suit = "Suit";


  FontWeight weightTitle = FontWeight.w800;
  FontWeight weightSubTitle = FontWeight.w500;
  FontWeight weightCategoryTitle = FontWeight.w600;
  FontWeight weightHashTagChip = FontWeight.w800;
}