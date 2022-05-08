import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
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
      log("Error al obtener mapsApiKey");
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
  }

  @override
  Widget build(BuildContext context) {
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
                target: LatLng((widget.location as GeoPoint).latitude, (widget.location as GeoPoint).longitude),
                zoom: 14.0,
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
    );
  }

  PolylinePoints polylinePoints = PolylinePoints();
  void getPolyLine() async{
    final loc = widget.location as GeoPoint;
    PolylineResult polypuntos = await polylinePoints.getRouteBetweenCoordinates(
      s, 
      PointLatLng(20.6736, -103.35), 
      PointLatLng(loc.latitude, loc.longitude),
      avoidFerries: false,
      optimizeWaypoints: true
    );
    if(polypuntos.points.isEmpty){
      log("CHINGADAMADREEEEEE");
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
