import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/tabs/home/events_list/event_item.dart';
import 'package:evently/ui/home/tabs/home/tab_bar/event_category_model.dart';
import 'package:evently/ui/home/tabs/home/tab_bar/tab_item_widget.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../model/event.dart';
import '../../../../utils/app_routes.dart';
import '../../../../utils/firebase_utils.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  final tabBarEvents = [
    EventCategoryModel(
      eventName: LocaleKeys.all,
      selectedEventIcon: AppIcons.selectedAll,
      unSelectedEventIcon: AppIcons.unselectedAll,
    ),
    ...EventCategoryModel.tabBarEvents,
  ];

  Stream<List<Event>>? eventStream;

  @override
  void initState() {
    super.initState();
    eventStream = FirebaseUtils.getAllEvents();
  }

  void updateStream(int index) {
    selectedIndex = index;
    if (selectedIndex == 0) {
      eventStream = FirebaseUtils.getAllEvents();
    } else {
      eventStream = FirebaseUtils.getFilterEvents(selectedIndex: selectedIndex);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    final bool isDark = themeProvider.isDark;
    final bool isEnglish = context.locale.languageCode == 'en';
    var width = context.width;
    var height = context.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: width * .04,
            right: width * .04,
            top: height * .04,
          ),
          child: DefaultTabController(
            length: tabBarEvents.length,
            child: Column(
              spacing: height * .02,
              children: [
                Row(
                  spacing: width * .02,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      spacing: height * .01,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.welcomeBack.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          userProvider.currentUser?.name ?? 'Sara',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        themeProvider.changeAppTheme(!isDark);
                      },
                      icon: ImageIcon(
                        AssetImage(
                          isDark ? AppIcons.darkMode : AppIcons.lightMode,
                        ),
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (isEnglish) {
                          context.setLocale(const Locale('ar'));
                        } else {
                          context.setLocale(const Locale('en'));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: context.width * .1,
                        height: context.width * .1,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          LocaleKeys.languageCode.tr(),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ),
                  ],
                ),
                TabBar(
                  onTap: (index) {
                    updateStream(index);
                  },
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.symmetric(horizontal: width * .02),
                  dividerColor: AppColors.transparent,
                  indicatorColor: AppColors.transparent,
                  isScrollable: true,
                  tabs: tabBarEvents.map((event) {
                    return TabItemWidget(
                      isSelected: selectedIndex == tabBarEvents.indexOf(event),
                      eventName: event.eventName,
                      selectedEventIcon: event.selectedEventIcon,
                      unSelectedEventIcon: event.unSelectedEventIcon,
                    );
                  }).toList(),
                ),
                Expanded(
                  child: StreamBuilder<List<Event>>(
                    stream: eventStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).cardColor,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }

                      var events = snapshot.data ?? [];

                      if (events.isEmpty) {
                        return Center(
                          child: Text(
                            'No Events Found',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        );
                      }

                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Navigator.pushNamed(
                                context,
                                AppRoutes.eventDetailsRouteName,
                                arguments: events[index],
                              );
                            },
                            child: EventItem(
                              event: events[index],
                              onFavoritePressed: () {
                                FirebaseUtils.updateIsFavourite(events[index]);
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: height * .02);
                        },
                        itemCount: events.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
