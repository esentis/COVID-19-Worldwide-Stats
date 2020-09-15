import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'elevated_card.dart';

class CountrySearcher extends StatelessWidget {
  const CountrySearcher({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      gradientColors: [
        const Color(0xFF848ccf),
        const Color(0xFF322f3d),
      ],
      shadowColor: Colors.black,
      elevation: 15,
      child: Container(
        child: CountryListPick(
          // to show or hide flag
          isShowFlag: true,
          // true to show  title country or false to code phone country
          isShowTitle: true,
          // to show or hide down icon
          isDownIcon: true,
          isShowCode: true,
          showEnglishName: true,
          // to get feedback data from picker
          onChanged: (CountryCode countryCode) async {
            var arguments = [
              countryCode.code.toLowerCase(),
              countryCode.flagUri,
              countryCode.name
            ];
            await Get.toNamed('/countryScreen', arguments: arguments);
          },
        ),
      ),
    );
  }
}
