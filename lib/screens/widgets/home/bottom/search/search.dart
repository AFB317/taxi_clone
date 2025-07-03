import 'package:flutter/material.dart';

import '../../../../../utils/functions.dart';
import '../../../../../utils/languages/constants.dart';

class SearchCard extends StatelessWidget {
  final Function next;

  const SearchCard({super.key, required this.next});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        assignDate(DateTime.now());
        next();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Icon(Icons.location_pin, color: Theme.of(context).primaryColor),
              const SizedBox(width: 10),
              Text(
                "${getTranslated(context, 'choose_destination')}",
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
