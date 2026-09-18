import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/event.dart';
import '../../../../providers/user_provider.dart';
import '../../../../utils/app_routes.dart';
import '../../../../utils/firebase_utils.dart';
import '../home/events_list/event_item.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  String searchQuery = '';
  Stream<List<Event>>? favoriteStream;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      String uId = userProvider.currentUser?.id ?? '';

      favoriteStream = FirebaseUtils.getAllFavouriteEvents( uId);
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .02,
        ),
        child: Column(
          spacing: height * .02,
          children: [
            CustomTextFormField(
              borderColor: Theme.of(context).dividerColor,
              hintText: LocaleKeys.search.tr(),
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              suffixIcon: Icon(
                Icons.search_rounded,
                color: Theme.of(context).cardColor,
              ),
              filled: true,
              fillColor: Theme.of(context).highlightColor,
              onChanged: (text) {
                searchQuery = text;
                setState(() {});
              },
            ),
            Expanded(
              child: StreamBuilder<List<Event>>(
                stream: favoriteStream,
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

                  var filteredList = events.where((event) {
                    return event.eventTitle
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase().trim());
                  }).toList();

                  filteredList.sort((a, b) => a.eventDate.compareTo(b.eventDate));

                  if (filteredList.isEmpty) {
                    return Center(
                      child: Text(
                        'No Favorite Events Found',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.eventDetailsRouteName,
                            arguments: filteredList[index],
                          );
                        },
                        child: EventItem(
                          event: filteredList[index],
                          onFavoritePressed: () {
                            FirebaseUtils.updateIsFavourite(filteredList[index]);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height * .02);
                    },
                    itemCount: filteredList.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}