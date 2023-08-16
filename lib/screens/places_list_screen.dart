import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.placeForm);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).getPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('no registered location!'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, index) => Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: ListTile(
                              titleAlignment: ListTileTitleAlignment.threeLine,
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: FileImage(
                                  greatPlaces.getItem(index).image,
                                ),
                              ),
                              title: Text(
                                greatPlaces.getItem(index).title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              subtitle: Text(
                                '${greatPlaces.getItem(index).location?.address}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.placeDetail,
                                  arguments: greatPlaces.getItem(index),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
