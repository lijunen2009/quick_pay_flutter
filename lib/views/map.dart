import 'package:flutter/material.dart';
import 'package:amap_base/amap_base.dart';
import 'package:url_launcher/url_launcher.dart';

//const markerList = const [
//  LatLng(30.308802, 120.071179),
//  LatLng(30.2412, 120.00938),
//  LatLng(30.296945, 120.35133),
//  LatLng(30.328955, 120.365063),
//  LatLng(30.181862, 120.369183),
//];
const polylineList = const [
  LatLng(39.999391, 116.135972),
  LatLng(39.898323, 116.057694),
  LatLng(39.900430, 116.265061),
  LatLng(39.955192, 116.140092),
];
class MapPage extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<MapPage> {
  AMapController _controller;
  String amapKey = '552e907463f80db4b618af5e1532ed6d';
  var lat = 40.851827;
  var lng = 111.801637;

  var markerList = [
//    LatLng(37.785634, -122.406517),
//    LatLng(37.785889, -122.406617),
//    LatLng(37.785934, -122.406417),
//    LatLng(37.785834, -122.406617),
//    LatLng(37.785534, -122.406717),
  ];

  @override
  void dispose() {

    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _init();
  }
  _moveCenter() async{
    _controller.changeLatLng(new LatLng(lat, lng));

  }

  _call() async{
//    await launch('tel:+10010');
    await launch('https://www.baidu.com');
  }
  _init() async{
    await AMap.init(amapKey);
    AMapLocation location = new  AMapLocation();
    var locationRes = await location.getLocation(new LocationClientOptions());
    lat = locationRes.latitude;
    lng = locationRes.longitude;
  }

  _showMap() {
    return new AMapView(
      onAMapViewCreated: (controller) {

        markerList.add(new LatLng(lat ,lng));

        _controller = controller;
        _controller.markerClickedEvent.listen((marker) {
          print(marker);
          Navigator.of(context).pushNamed('map2');

          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(marker.toString())));
        });

//        controller.addMarker(
//            MarkerOptions(
//              icon: 'assets/group.png',
//              position: new LatLng(39.999391, 116.135972),
//              title: '哈哈',
//              snippet: '呵呵',
//            )
//        );
//        controller.changeLatLng(new LatLng(39.999391, 116.135972));
//        controller.addPolyline(
//          PolylineOptions(
//            latLngList: polylineList,
//            color: Colors.blue,
//            isDottedLine: true,
//            isGeodesic: true,
//            dottedLineType: PolylineOptions.DOTTED_LINE_TYPE_CIRCLE,
//            width: 20,
//          ),
//        );
        controller.addMarkers(
          markerList.map((latLng) => MarkerOptions(
            icon: 'assets/store_icon.png',
            position: latLng,
            title: '哈哈',
          )).toList()
        );

      },
      amapOptions: new AMapOptions(
          compassEnabled:false,
          zoomControlsEnabled:true,
          camera: CameraPosition(
          target: new LatLng(lat, lng),
          zoom: 10
        ),

      ),
    );
  }



  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('地图'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          _showMap(),
          new GestureDetector(
            child: new Container(
              margin: new EdgeInsets.only(right: 15.0,bottom: 90.0),
              alignment: Alignment.bottomRight,
              child: new Image.asset('assets/service.png',width: 40.0,height: 40.0,),
            ),
            onTap: (){
              _call();
            },
          ),
          new GestureDetector(
            child: new Container(
              margin: new EdgeInsets.only(right: 15.0,bottom: 30.0),
              alignment: Alignment.bottomRight,
              child: new Image.asset('assets/to_current_location.png',width: 40.0,height: 40.0,),
            ),
            onTap: (){
              _moveCenter();
            },
          ),
          new GestureDetector(
            child: new Container(
              child: new Image.asset('assets/scan.png',width: 150.0,height: 150.0,),
              margin: new EdgeInsets.only(bottom: 15.0),
              alignment: Alignment.bottomCenter,
            ),
          ),
          new GestureDetector(
            child: new Container(
              child: new Image.asset('assets/user.png',height: 40.0,width: 40.0,),
              margin: new EdgeInsets.only(bottom: 30.0,left: 15.0),
              alignment: Alignment.bottomLeft,
            ),
          )
        ],
      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      floatingActionButton: FloatingActionButton(
//        child: new Image.asset('assets/scan.png'),
//        onPressed: (){
//          _moveCenter();
//        },
//      ),
//      body: new Text('map'),
    );
  }
}
