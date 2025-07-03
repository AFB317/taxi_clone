import 'package:duma_taxi/screens/widgets/home/bottom/search/pick_up_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/languages/constants.dart';
import '../../../../../utils/providers/text.dart';

class SearchAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;

  const SearchAppBarWidget({super.key, this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PickUpDatePicker(),
            GestureDetector(
              onTap: () {
                //Sheet to fill the name of the person
              },
              child: Consumer<TextProvider>(
                builder: (context, provider, _) {
                  return Card(
                    shape: const StadiumBorder(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person, size: 15),
                          const SizedBox(width: 5),
                          Text(
                            textToDisplay(context, provider: provider),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  String textToDisplay(BuildContext context, {required TextProvider provider}) {
    if (provider.selectedOption.id != 1) {
      return provider.guestName.length > 10
          ? provider.guestName.substring(0, 10)
          : provider.guestName;
    } else {
      return "${getTranslated(context, 'for_me')}";
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(
    bottom == null
        ? kToolbarHeight
        : kToolbarHeight + bottom!.preferredSize.height,
  );
}
