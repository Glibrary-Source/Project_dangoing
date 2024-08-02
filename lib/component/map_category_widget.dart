import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';
import 'package:project_dangoing/utils/map_category_check_manager.dart';
import 'package:project_dangoing/utils/map_status_manager.dart';

class MapCategoryWidget extends StatefulWidget {
  String categoryName;

  MapCategoryWidget({super.key, required this.categoryName});

  @override
  State<MapCategoryWidget> createState() => _MapCategoryWidgetState();
}

class _MapCategoryWidgetState extends State<MapCategoryWidget> {
  FontStyleManager fontStyleManager = FontStyleManager();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          bool? newValue = !MapCategoryCheckManager().getCheckValue(widget.categoryName)!;
          MapCategoryCheckManager()
              .setCheckValue(widget.categoryName, newValue);
          for (var marker in MapStatusManager()
              .storeMarkerMap[widget.categoryName]!) {
            marker.setIsVisible(newValue);
          }
        });
      },
      child: Row(
        children: [
          Checkbox(
            value: MapCategoryCheckManager().getCheckValue(widget.categoryName),
            checkColor: dangoingColorOrange500,
            splashRadius: 24,
            fillColor: const MaterialStatePropertyAll(CupertinoColors.systemGrey6),
            overlayColor: MaterialStatePropertyAll(Colors.green.withOpacity(0.2)),
            side:  MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 1.0, color: Colors.black45),
            ),
            onChanged: null,
          ),
          Text(widget.categoryName)
        ],
      ),
    );
  }
}
