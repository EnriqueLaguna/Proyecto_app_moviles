import 'dart:developer' as Dev;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingPage extends StatefulWidget {
  final dynamic location;
  TrackingPage({Key? key, this.location}) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  GoogleMapController? controller;
  List<Marker> markers = [];
  Polyline? route;
  static const s = String.fromEnvironment("GoogleMapsKey");

  @override
  void initState() {
    super.initState();
    print(s);
    if(s.isEmpty){
      Dev.log("Error al obtener mapsApiKey");
      return;
    }
    final loc = widget.location as GeoPoint;
    markers.addAll([
      Marker(
        markerId: MarkerId("origen"),
        icon: BitmapDescriptor.defaultMarkerWithHue(90),
        position: LatLng(20.6736, -103.35)
      ),
      Marker(
        markerId: MarkerId("destino"),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(loc.latitude, loc.longitude)
      ),
    ]);
    getPolyLine();
  }

  void _onMapCreated(GoogleMapController controller) async{
    this.controller = controller;
    recenterMap();
  }

  void recenterMap() async{
    LatLng a = LatLng(20.6736, -103.35), b = LatLng((widget.location as GeoPoint).latitude, (widget.location as GeoPoint).longitude);
    LatLngBounds target = LatLngBounds(
      southwest: a.latitude>b.latitude?b:a, 
      northeast: a.latitude>b.latitude?a:b
    );
    LatLng center = LatLng(
      target.southwest.latitude+(target.northeast.latitude-target.southwest.latitude)/2.0,
      target.southwest.longitude+(target.northeast.longitude-target.southwest.longitude)/2.0,
    );
    LatLngBounds screen = await this.controller!.getVisibleRegion();
    while(this.controller != null){
      if(
        (screen.northeast.latitude > target.northeast.latitude) && 
        (screen.northeast.longitude > target.northeast.longitude) && 
        (screen.southwest.latitude < target.southwest.latitude) && 
        (screen.southwest.longitude < target.southwest.longitude) &&

        (screen.northeast.latitude > target.southwest.latitude) && 
        (screen.northeast.longitude > target.southwest.longitude) && 
        (screen.southwest.latitude < target.northeast.latitude) && 
        (screen.southwest.longitude < target.northeast.longitude) 
      )
        break;
      screen = await this.controller!.getVisibleRegion();
      await this.controller!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: center,
        zoom: (await this.controller!.getZoomLevel()) - 0.5,
      )));
    };
  }

  @override
  Widget build(BuildContext context) {
    double x1 = 20.6736, x2 = (widget.location as GeoPoint).latitude;
    double z1 = -103.35, z2 = (widget.location as GeoPoint).longitude;
    double cameraLat = (x1 + x2)/2.0, cameraLon = (z1 + z2)/2.0;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Rastreo"),
      ),
      body: Stack(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(cameraLat, cameraLon),
                  zoom: 30.0,
                ),
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                markers: Set<Marker>.of(markers),
                polylines: route != null ? Set<Polyline>.of([route!]) : Set.identity(),
              ),
            ),
          ],
        ),
      ]),
      floatingActionButton: CircleAvatar(
        child: IconButton(
          icon: Icon(Icons.location_searching), color: Colors.yellow[50], onPressed: recenterMap,
        ),
        backgroundColor: Colors.lightGreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  PolylinePoints polylinePoints = PolylinePoints();
  void getPolyLine() async{
    final loc = widget.location as GeoPoint;
    PolylineResult polypuntos = await polylinePoints.getRouteBetweenCoordinates(
      s, 
      PointLatLng(20.6736, -103.35), 
      PointLatLng(loc.latitude, loc.longitude),
    );
    if(polypuntos.points.isEmpty){
      Dev.log("Polypuntos vacío");
      return;
    }
    route = Polyline(
      polylineId: PolylineId("polylínea"),
      color: Colors.yellow[700]!,
      points: polypuntos.points
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList()
    );
    setState(() {});
  }
}
