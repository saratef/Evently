import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home/tabs/home/tab_bar/event_category_model.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../model/event.dart';
import '../../../../../utils/size_utils.dart';

class EventItem extends StatelessWidget {
  final Event event;
  final VoidCallback? onFavoritePressed;

  const EventItem({
    super.key,
    required this.event,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    bool isDark = Provider.of<AppThemeProvider>(context).isDark;

    String currentImage = EventCategoryModel.getCategoryImage(
      categoryIndex: event.eventCategoryIndex,
      isDark: isDark,
    );

    return Container(
      height: height * .25,
      padding: EdgeInsets.symmetric(
        horizontal: width * .03,
        vertical: height * .012,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor, width: 2),
        image: DecorationImage(
          image: AssetImage(currentImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * .02,
              vertical: height * .006,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              DateFormat('dd MMM').format(event.eventDate),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * .02,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.eventTitle,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: onFavoritePressed,
                  icon: ImageIcon(
                    AssetImage(
                      event.isFavourite
                          ? AppIcons.selectedFavorite
                          : AppIcons.unselectedFavorite,
                    ),
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}