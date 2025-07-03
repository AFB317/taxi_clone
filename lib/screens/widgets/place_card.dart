import 'package:flutter/material.dart';

import '../../models/place.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final IconData iconData;

  const PlaceCard({super.key, required this.place, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Icon(iconData),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${place.name}",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${place.address}",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 0.5, color: Colors.grey[300], height: 1),
        ],
      ),
    );
  }
}
