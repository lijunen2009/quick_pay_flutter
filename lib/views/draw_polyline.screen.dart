import 'package:amap_base/amap_base.dart';
import 'package:quick_pay/utils/misc.dart';
import 'package:quick_pay/utils/view.dart';
import 'package:flutter/material.dart';

const polylineList = const [
  LatLng(39.999391, 116.135972),
  LatLng(39.898323, 116.057694),
  LatLng(39.900430, 116.265061),
  LatLng(39.955192, 116.140092),
];

class DrawPolylineScreen extends StatefulWidget {
  DrawPolylineScreen();

  factory DrawPolylineScreen.forDesignTime() => DrawPolylineScreen();

  @override
  _DrawPolylineScreenState createState() => _DrawPolylineScreenState();
}

class _DrawPolylineScreenState extends State<DrawPolylineScreen> {
  AMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制线'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: AMapView(
        onAMapViewCreated: (controller) {
          _controller = controller;
          loading(
            context,
            controller.addPolyline(
              PolylineOptions(
                latLngList: polylineList,
                color: Colors.blue,
                isDottedLine: true,
                isGeodesic: true,
                dottedLineType: PolylineOptions.DOTTED_LINE_TYPE_CIRCLE,
                width: 20,
              ),
            ),
          ).catchError((e) => showError(context, e.toString()));
        },
        amapOptions: AMapOptions(
          camera: CameraPosition(
              target: new LatLng(39.999391, 116.135972),
              zoom: 12
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
