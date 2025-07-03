import 'package:duma_taxi/models/direction.dart';
import 'package:duma_taxi/utils/constants.dart';
import 'package:duma_taxi/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../models/place.dart';
import '../../../../utils/api.dart';
import '../../../../utils/data_manager.dart';
import '../../../widgets/form_helper.dart';
import '../../../widgets/home/bottom/search/app_bar.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/place_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  bool _isSearching = false;

  TextEditingController originController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  static TextEditingController stop1Controller = TextEditingController();
  static TextEditingController stop2Controller = TextEditingController();
  static TextEditingController stop3Controller = TextEditingController();
  static TextEditingController stop4Controller = TextEditingController();

  FocusNode originFocus = FocusNode();
  FocusNode destinationFocus = FocusNode();
  FocusNode stop1Focus = FocusNode();
  FocusNode stop2Focus = FocusNode();
  FocusNode stop3Focus = FocusNode();
  FocusNode stop4Focus = FocusNode();

  Place? originPoint, destinationPoint;

  bool addStop1 = false;
  bool addStop2 = false;
  bool addStop3 = false;
  bool addStop4 = false;

  List<Place> places = [];

  bool loadingDirection = false;

  _destinationListener() {
    if (destinationController.text.length > 3) {
      _searchPlaces(destinationController.text);
    }
  }

  _stop1Listener() {
    if (stop1Controller.text.length > 3) {
      _searchPlaces(stop1Controller.text);
    }
  }

  _stop2Listener() {
    if (stop2Controller.text.length > 3) {
      _searchPlaces(stop2Controller.text);
    }
  }

  _stop3Listener() {
    if (stop3Controller.text.length > 3) {
      _searchPlaces(stop3Controller.text);
    }
  }

  _stop4Listener() {
    if (stop4Controller.text.length > 3) {
      _searchPlaces(stop4Controller.text);
    }
  }

  _originListener() {
    if (originFocus.hasPrimaryFocus && originController.text.length > 3) {
      _searchPlaces(originController.text);
    }
  }

  _searchPlaces(String keySearch) {
    if (!mounted) return;
    setState(() {
      _isSearching = true;
    });
    Api.searchPlaces(context, text: keySearch).then((values) {
      setState(() {
        _isSearching = false;
      });
      DataManager().placeStream.setPlaces(values);
    });
  }

  @override
  void dispose() {
    stop1Controller.clear();
    stop2Controller.clear();
    stop3Controller.clear();
    stop4Controller.clear();
    destinationController.clear();
    super.dispose();
  }

  @override
  void initState() {
    destinationController.addListener(_destinationListener);
    stop1Controller.addListener(_stop1Listener);
    stop2Controller.addListener(_stop2Listener);
    stop3Controller.addListener(_stop3Listener);
    stop4Controller.addListener(_stop4Listener);
    originController.addListener(_originListener);

    DataManager().placeStream.origin.listen((event) {
      originPoint = event;
      originController.text = textFieldPlace(originPoint);
    });

    DataManager().placeStream.places.listen((events) {
      if (mounted) {
        setState(() {
          places = events;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBarWidget(),
      body: LoadingPage(isAsync: loadingDirection, child: _bodyContent()),
    );
  }

  _bodyContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _topContent(),
          if (_isSearching)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: LinearProgressIndicator(
                color: Theme.of(context).primaryColor,
                minHeight: 1,
                //size: 11,
              ),
            ),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () {
                  _action(places[index]);
                },
                child: PlaceCard(
                  place: places[index],
                  iconData: Ionicons.location,
                ),
              );
            },
            itemCount: places.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }

  _topContent() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchOriginField(
            context,
            controller: originController,
            focusNode: originFocus,
            onClean: () {
              _cleanController(originController);
            },
            onMap: () {
              _openMap(originMap);
            },
          ),
          searchStopField(
            context,
            controller: stop1Controller,
            focusNode: stop1Focus,
            onClean: () {
              _cleanController(stop1Controller);
            },
            isAdd: addStop1,
            onAdd: () {},
            onRemove: () {},
            onMap: () {},
          ),
          if (addStop1)
            searchStopField(
              context,
              controller: stop2Controller,
              focusNode: stop2Focus,
              onClean: () {
                _cleanController(stop2Controller);
              },
              isAdd: addStop2,
              onAdd: () {},
              onRemove: () {},
              onMap: () {},
            ),
          if (addStop2)
            searchStopField(
              context,
              controller: stop3Controller,
              focusNode: stop3Focus,
              onClean: () {
                _cleanController(stop3Controller);
              },
              isAdd: addStop3,
              onAdd: () {},
              onRemove: () {},
              onMap: () {},
            ),
          if (addStop3)
            searchStopField(
              context,
              controller: stop4Controller,
              focusNode: stop4Focus,
              onClean: () {
                _cleanController(stop4Controller);
              },
              isAdd: addStop4,
              onAdd: () {},
              onRemove: () {},
              onMap: () {},
            ),
          searchDestinationField(
            context,
            controller: destinationController,
            focusNode: destinationFocus,
            onClean: () {
              _cleanController(destinationController);
            },
            onMap: () {
              _openMap(destinationMap);
            },
          ),
        ],
      ),
    );
  }

  _cleanController(TextEditingController controller) {
    setState(() {
      controller.clear();
    });
  }

  void _action(Place place) {
    if (destinationFocus.hasPrimaryFocus) {
      if (mounted) {
        setState(() {
          destinationPoint = place;
        });
        _getDirection();
      }
    } else {
      if (mounted) {
        setState(() {
          originPoint = place;
          originController.text = textFieldPlace(originPoint);
        });
      }
    }
  }

  _initRequest() {
    setState(() {
      loadingDirection = true;
    });
    DataManager().placeStream.setOrigin(originPoint!);
    DataManager().placeStream.setDestination(destinationPoint!);
  }

  _getDirection() async {
    _initRequest();
    List<Direction> directions = [];
    await Api.fetchRoute(
      LatLng(originPoint!.latitude!, originPoint!.longitude!),
      LatLng(destinationPoint!.latitude!, destinationPoint!.longitude!),
      1,
    ).then((direction) {
      directions.add(direction!);
      double distance = double.parse("${direction.distance.value}");
      _getPrice(distance: "$distance", distances: [distance]);
    });
  }

  _getPrice({required String distance, required List<double> distances}) {
    setState(() {
      loadingDirection = false;
    });
    Api.getEstimationPrice(
      distance: distance,
      distances: distances,
      time: DataManager().dateTime,
    ).then((types) {
      setState(() {
        loadingDirection = false;
      });
      if (mounted) {
        //setToComplete(context, types: types);
      }
    });
  }

  _openMap(String value) {}
}
