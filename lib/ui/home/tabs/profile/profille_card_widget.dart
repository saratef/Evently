import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget{
  String title;
  Widget trailing;
  bool isDrak;
  ProfileCardWidget({required this.title, required this.trailing, this.isDrak=true});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color:isDrak?AppColors.inputDark:AppColors.textPrimaryDark  ,
        borderRadius: BorderRadiusGeometry.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor,
        width: 2)
      ),
      child: ListTile(
        title: Text(title.tr(),style: Theme.of(context).textTheme.headlineMedium,),
        trailing: trailing,
      ),
    );
  }
}