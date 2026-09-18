import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/size_utils.dart';

class DateAndTimeWidget extends StatelessWidget {
  final String title;
  final String buttonText;
  final String iconPath;
  final VoidCallback onChooseDateOrTime;
  const DateAndTimeWidget({super.key,required this.title,required this.iconPath,required this.buttonText, required this.onChooseDateOrTime});

  @override
  Widget build(BuildContext context) {
    var width=context.width;
    return Row(
      spacing: width*.02,
      children: [
        ImageIcon(AssetImage(iconPath),color: Theme.of(context).cardColor,),
        Text(title,style: Theme.of(context).textTheme.headlineMedium,),
        Spacer(),
        TextButton(

            onPressed: (){
          onChooseDateOrTime();
        }, child: Text(buttonText,style: Theme.of(context).textTheme.displayMedium,))
      ],
    );
  }
}
