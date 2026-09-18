import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/size_utils.dart';

class TabItemWidget extends StatelessWidget {
  final bool isSelected;
  final String eventName;
  final String selectedEventIcon;
  final String unSelectedEventIcon;
  TabItemWidget({
    super.key,
    required this.isSelected,
    required this.eventName,
    required this.selectedEventIcon,
    required this.unSelectedEventIcon,
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected
            ? Theme.of(context).cardColor
            : Theme.of(context).highlightColor,
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        spacing: width*.02,
        children: [
          Image.asset(
            isSelected ? selectedEventIcon : unSelectedEventIcon,
            color: isSelected
                ? AppColors.textPrimaryDark
                : Theme.of(context).cardColor,
            width: width * .07,
          ),
          Text(
            eventName.tr(),
            style: isSelected
                ? AppStyles.medium16White
                : Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
