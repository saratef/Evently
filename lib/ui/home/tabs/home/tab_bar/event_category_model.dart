import '../../../../../generated/locale_keys.g.dart';
import '../../../../../utils/app_assets.dart';

class EventCategoryModel {
  final String eventName;
  final String selectedEventIcon;
  final String unSelectedEventIcon;
  final String? lightImage;
  final String? darkImage;

  EventCategoryModel({
    required this.eventName,
    required this.selectedEventIcon,
    required this.unSelectedEventIcon,
    this.lightImage,
    this.darkImage,
  });


 static List<EventCategoryModel> tabBarEvents = [

   EventCategoryModel(
      eventName: LocaleKeys.sport,
      selectedEventIcon: AppIcons.selectedSport,
      unSelectedEventIcon: AppIcons.unselectedSport,
     lightImage: AppImages.sports,
      darkImage: AppImages.darkSport,
    ),
   EventCategoryModel(
      eventName: LocaleKeys.birthday,
      selectedEventIcon: AppIcons.selectedBirthday,
      unSelectedEventIcon: AppIcons.unselectedBirthday,
     lightImage: AppImages.birthday,
     darkImage: AppImages.darkBirthday,
    ),
   EventCategoryModel(
      eventName: LocaleKeys.meeting,
      selectedEventIcon: AppIcons.selectedMeeting,
      unSelectedEventIcon: AppIcons.unselectedMeeting,
     lightImage: AppImages.meeting,
     darkImage:  AppImages.darkMeeting,
    ),
   EventCategoryModel(
      eventName: LocaleKeys.bookClub,
      selectedEventIcon: AppIcons.selectedBook,
      unSelectedEventIcon: AppIcons.unselectedBook,
     lightImage: AppImages.book,
     darkImage: AppImages.darkBook,
    ),
   EventCategoryModel(
      eventName: LocaleKeys.exhibitions,
      selectedEventIcon: AppIcons.selectedExhibition,
      unSelectedEventIcon: AppIcons.unselectedExhibition,
      lightImage:  AppImages.exhibition,
     darkImage:AppImages.darkMeeting,
    ),
  ];

}