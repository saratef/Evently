import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home/tabs/home/tab_bar/event_category_model.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:evently/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var event = ModalRoute.of(context)!.settings.arguments as Event;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDark;
    var width = context.width;
    var height = context.height;

    String currentImage = EventCategoryModel.getCategoryImage(
      categoryIndex: event.eventCategoryIndex,
      isDark: isDark,
    );

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsetsDirectional.only(
            start: width * .02,
            top: height * .01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).highlightColor,
            border: Border.all(width: 2, color: Theme.of(context).dividerColor),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
        backgroundColor: AppColors.transparent,
        title: Text(
          LocaleKeys.eventDetails.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsetsDirectional.only(
              top: height * .01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).highlightColor,
              border: Border.all(width: 2, color: Theme.of(context).dividerColor),
            ),
            child: IconButton(
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  AppRoutes.editEventRouteName,
                  arguments: event,
                );
                setState(() {});
              },
              icon:  ImageIcon(
                AssetImage(AppIcons.edit),
                color: AppColors.primaryLight,
              ),
            ),
          ),
          SizedBox(width: width * .01),
          Container(
            margin: EdgeInsetsDirectional.only(
              top: height * .01,
              end: width * .04,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).highlightColor,
              border: Border.all(width: 2, color: Theme.of(context).dividerColor),
            ),
            child: IconButton(
              onPressed: () {
                deleteEvent(eventId: event.eventId);
              },
              icon: ImageIcon(
                AssetImage(AppIcons.delete),
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: height * .02,
            children: [
              Container(
                height: height * .25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 2,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(currentImage),
                  ),
                ),
              ),
              Text(
                event.eventTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .03,
                  vertical: height * .015,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(width * .025),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.inputDark
                            : AppColors.textPrimaryDark,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Theme.of(context).dividerColor),
                      ),
                      child: ImageIcon(
                        AssetImage(AppIcons.date),
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    SizedBox(width: width * .03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd MMMM').format(event.eventDate),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          DateFormat('hh:mm a').format(event.eventDate),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                LocaleKeys.description.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * .04),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 2,
                  ),
                ),
                child: Text(
                  event.eventDescription,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteEvent({required String eventId}) {
    DialogUtils.showMessage(
      context: context,
      message: 'Are you sure you want to delete this event?',
      title: 'Delete Event',
      positiveActionName: 'Yes',
      positiveAction: () {
        FirebaseUtils.deleteEventFireSore(eventId).then((value) {
          ToastUtils.showToastMessage(
            message: 'Event Deleted Successfully',
            backgroundColor: AppColors.success,
            textColor: AppColors.textPrimaryDark,
          );
          Navigator.pop(context);
        }).catchError((error) {
          ToastUtils.showToastMessage(
            message: error.toString(),
            backgroundColor: AppColors.error,
            textColor: AppColors.textPrimaryDark,
          );
        });
      },
      negativeActionName: 'Cancel',
    );
  }
}