import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String temperature;
  final double maxTempC;
  final double minTempC;

  const MapScreen({super.key,
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.maxTempC,
    required this.minTempC,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  late LatLng location;

  @override
  void initState() {
    super.initState();
    location = LatLng(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map')),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: {
              Marker(
                markerId: MarkerId('Weather Marker'),
                position: location,
                infoWindow: InfoWindow(
                    title: "${widget.latitude} , ${widget.longitude}",
                    snippet: "H: ${widget.maxTempC}°C  L: ${widget.minTempC}°C",
                ),
              ),
            },
            mapType: MapType.hybrid,
            initialCameraPosition: CameraPosition(target: location, zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
        ],
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
