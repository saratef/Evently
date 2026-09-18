import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home/add_event/date_and_time_widget.dart';
import 'package:evently/ui/home/tabs/home/tab_bar/event_category_model.dart';
import 'package:evently/ui/home/tabs/home/tab_bar/tab_item_widget.dart';
import 'package:evently/ui/widgets/custom_elevated_button.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/event.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/firebase_utils.dart';
import '../../../../utils/toast_utils.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late Event event;
  bool isInitialized = false;

  int selectedIndex = 0;
  DateTime? selectedDate;
  String formateDate = '';
  TimeOfDay? selectedTime;
  String formateTime = '';
  var formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  final eventCategoriesList = EventCategoryModel.tabBarEvents;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      event = ModalRoute.of(context)!.settings.arguments as Event;

      titleController = TextEditingController(text: event.eventTitle);
      descriptionController =
          TextEditingController(text: event.eventDescription);

      selectedDate = event.eventDate;
      selectedTime = TimeOfDay.fromDateTime(event.eventDate);
      formateDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
      formateTime = selectedTime!.format(context);

      selectedIndex = event.eventCategoryIndex - 1;
      if (selectedIndex < 0 || selectedIndex >= eventCategoriesList.length) {
        selectedIndex = 0;
      }

      isInitialized = true;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDark;
    var width = context.width;
    var height = context.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.editEvent.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: height * .02,
              children: [
                Container(
                  height: height * .25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        isDark
                            ? eventCategoriesList[selectedIndex].darkImage!
                            : eventCategoriesList[selectedIndex].lightImage!,
                      ),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .06,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: TabItemWidget(
                          isSelected: selectedIndex == index,
                          eventName: eventCategoriesList[index].eventName,
                          selectedEventIcon:
                          eventCategoriesList[index].selectedEventIcon,
                          unSelectedEventIcon:
                          eventCategoriesList[index].unSelectedEventIcon,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width * .02);
                    },
                    itemCount: eventCategoriesList.length,
                  ),
                ),
                Text(
                  LocaleKeys.title.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextFormField(
                  controller: titleController,
                  borderColor: Theme.of(context).dividerColor,
                  hintText: LocaleKeys.eventTitle.tr(),
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  onValidator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Event Title.';
                    }
                    return null;
                  },
                ),
                Text(
                  LocaleKeys.description.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  borderColor: Theme.of(context).dividerColor,
                  hintText: LocaleKeys.eventDescription.tr(),
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  onValidator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Event Description.';
                    }
                    return null;
                  },
                ),
                DateAndTimeWidget(
                  title: LocaleKeys.eventDate.tr(),
                  iconPath: AppIcons.date,
                  buttonText: selectedDate == null
                      ? LocaleKeys.chooseDate.tr()
                      : formateDate,
                  onChooseDateOrTime: onChooseDate,
                ),
                DateAndTimeWidget(
                  title: LocaleKeys.eventTime.tr(),
                  iconPath: AppIcons.time,
                  buttonText: selectedTime == null
                      ? LocaleKeys.chooseTime.tr()
                      : formateTime,
                  onChooseDateOrTime: onChooseTime,
                ),
                CustomElevatedButton(
                  verticalPadding: height * .01,
                  onPressed: updateEvent,
                  backgroundColor: Theme.of(context).cardColor,
                  child: Text(
                    LocaleKeys.updateEvent.tr(),
                    style: AppStyles.medium20White,
                  ),
                ),
                SizedBox(height: height * .04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onChooseDate() async {
    final pickedDate = await showDatePicker(
      locale: EasyLocalization.of(context)?.currentLocale,
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 15000)),
      builder: (context, child) {
        final theme = Theme.of(context);

        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.cardColor,
              onPrimary: theme.colorScheme.onPrimary,
              secondary: theme.cardColor,
              onSecondary: theme.colorScheme.onPrimary,
              surface: theme.scaffoldBackgroundColor,
              onSurface: theme.colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;
      formateDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
      setState(() {});
    }
  }

  Future<void> onChooseTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        final theme = Theme.of(context);

        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.cardColor,
              onPrimary: theme.colorScheme.onPrimary,
              secondary: theme.cardColor,
              onSecondary: theme.colorScheme.onPrimary,
              surface: theme.scaffoldBackgroundColor,
              onSurface: theme.colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      selectedTime = pickedTime;
      formateTime = selectedTime!.format(context);
      setState(() {});
    }
  }

  void updateEvent() {
    if (formKey.currentState?.validate() == true) {
      if (selectedDate == null || selectedTime == null) {
        ToastUtils.showToastMessage(
          message: 'Please choose date and time',
          backgroundColor: AppColors.error,
          textColor: AppColors.textPrimaryDark,
        );
        return;
      }

      bool isDark = Provider.of<AppThemeProvider>(context, listen: false).isDark;

      event.eventName = eventCategoriesList[selectedIndex].eventName;
      event.eventTitle = titleController.text.trim();
      event.eventDescription = descriptionController.text.trim();
      event.eventCategoryIndex = selectedIndex + 1;
      event.eventImage = EventCategoryModel.getCategoryImage(
        categoryIndex: selectedIndex + 1,
        isDark: isDark,
      );
      event.eventDate = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      FirebaseUtils.updateEventFirestore(event).then((value) {
        ToastUtils.showToastMessage(
          message: 'Event Updated Successfully',
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
    }
  }
}