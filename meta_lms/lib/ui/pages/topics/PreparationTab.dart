import 'package:flutter/material.dart';

class PreparationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Buttons - Download All, Rearrange, Add Resource
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Download All'),
              onPressed: () {
                // TODO: Implement download functionality
              },
            ),
            ElevatedButton(
              child: Text('Rearrange'),
              onPressed: () {
                // TODO: Implement rearrange functionality
              },
            ),
            ElevatedButton(
              child: Text('Add Resource'),
              onPressed: () {
                // TODO: Implement add resource functionality
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue), // Use your theme color
            ),
          ],
        ),
        // List of items, for example using ListView or Column
        // ...
      ],
    );
  }
}
