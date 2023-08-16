import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/model/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  bool isReadOnly = false;

  MapScreen(
      {this.initialLocation = const PlaceLocation(
        latitude: -23.1763539,
        longitude: -45.8921038,
      ),
      this.isReadOnly = false,
      Key? key})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPositionMap;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPositionMap = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select you location'),
        actions: [
          if (!widget.isReadOnly)
            IconButton(
              onPressed: _pickedPositionMap == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPositionMap);
                    },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: (_pickedPositionMap == null && !widget.isReadOnly)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('p1'),
                  position:
                      _pickedPositionMap ?? widget.initialLocation.toLatLng(),
                )
              },
      ),
    );
  }
}
