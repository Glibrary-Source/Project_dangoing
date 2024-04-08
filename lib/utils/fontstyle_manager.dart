
import 'dart:ui';

class FontStyleManager {
  static final FontStyleManager instance = FontStyleManager._internal();
  factory FontStyleManager()=>instance;
  FontStyleManager._internal();

  String primaryFont = "gamtan_tantan";
  String primarySecondFont = "gamtan_dotum_regular";
}