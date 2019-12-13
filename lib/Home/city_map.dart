import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CityDetailsMap extends StatefulWidget {

   final lat,lng,name; 
  CityDetailsMap({Key key, @required this.lat,@required this.lng,@override this.name}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState(); 
}

class _MyAppState extends State<CityDetailsMap> {
  Completer<GoogleMapController> _controller = Completer();

static double latitude,longitude;
      @override 
        void initState() {
          super.initState();
        }

  GoogleMapController mapController;

void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text(widget.name),
          backgroundColor: Colors.blue[300],
        ),
      body: GoogleMap(
        mapType: MapType.normal,
         initialCameraPosition: CameraPosition(
            target:LatLng(widget.lat, widget.lng),
            zoom: 14.4746,
          ),
         markers: Set<Marker>.of(
          <Marker>[
            Marker(
              draggable: true,
              markerId: MarkerId("1"),
              position: LatLng(widget.lat, widget.lng),
              icon: BitmapDescriptor.defaultMarker,
            )
          ],
        ),
        myLocationEnabled: true,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: true,
        trafficEnabled: false,
        indoorViewEnabled: true,
        compassEnabled: true,
        rotateGesturesEnabled: true,
        zoomGesturesEnabled: true,

       onMapCreated: _onMapCreated,
      ),
    );
  }
}