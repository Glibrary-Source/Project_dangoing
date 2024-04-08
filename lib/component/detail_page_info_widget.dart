
import 'package:flutter/material.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

class DetailPageInfoWidget extends StatefulWidget {

  final info;

  const DetailPageInfoWidget({super.key, required this.info});

  @override
  State<DetailPageInfoWidget> createState() => _DetailPageInfoWidgetState();
}

class _DetailPageInfoWidgetState extends State<DetailPageInfoWidget> {

  FontStyleManager fontStyleManager = FontStyleManager();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(child: Container(
            margin: EdgeInsets.only(bottom: 4),
            child: Text(widget.info, style: TextStyle(fontFamily: fontStyleManager.primarySecondFont),))),
      ],
    );
  }
}
