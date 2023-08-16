import 'package:flutter/material.dart';

import '../model/place.dart';
import 'map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Place place = ModalRoute.of(context)!.settings.arguments as Place;
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.file(
              place.image,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              place.location!.address!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            icon: const Icon(Icons.map),
            label: const Text('Ver no Mapa'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    isReadOnly: true,
                    initialLocation: place.location!,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
