
import 'package:flutter/material.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';
import 'package:project_dangoing/utils/map_category_check_manager.dart';

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
    return Row(
      children: [
        Checkbox(
            value: MapCategoryCheckManager().getCheckValue(widget.categoryName),
            onChanged: (value) {
              setState(() {
                MapCategoryCheckManager().setCheckValue(widget.categoryName, value!);
              });
            },
        ),
        Text(widget.categoryName)
      ],
    );
  }
}
