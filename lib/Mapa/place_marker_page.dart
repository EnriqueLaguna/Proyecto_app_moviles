import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceMarkerPage extends StatefulWidget {
  final Function setLocation;
  PlaceMarkerPage({Key? key, required this.setLocation}) : super(key: key);

  @override
  State<PlaceMarkerPage> createState() => _PlaceMarkerPageState();
}

class _PlaceMarkerPageState extends State<PlaceMarkerPage> {
  GoogleMapController? controller;
  Marker? marker;

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onMarkerTapped() {
    marker = null;
  }

  void _add() async{
    double screenWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    double screenHeight = MediaQuery.of(context).size.height * MediaQuery.of(context).devicePixelRatio;
    final String markerIdVal = 'markadors';
    final MarkerId markerId = MarkerId(markerIdVal);
    LatLng pos = await controller!.getLatLng(ScreenCoordinate(x: (screenWidth/2).round(), y: (screenHeight/2).round()));

    final Marker marcador = Marker(
      markerId: markerId,
      position: pos,
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () => _onMarkerTapped(),
    );

    setState(() {
      marker = marcador;
    });
  }

  void _remove() {
    if(marker != null)
      widget.setLocation(marker!.position);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(20.6736, -103.35),
                zoom: 11.0,
              ),
              markers: marker != null ? Set<Marker>.of([marker!]) : Set.identity(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                child: const Text('Mover marcador'),
                onPressed: _add,
              ),
              TextButton(
                child: const Text('Aceptar ubicación'),
                onPressed: _remove,
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
