import 'package:duma_taxi/models/service_type.dart';
import 'package:duma_taxi/screens/widgets/home/bottom/search/search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/data_manager.dart';
import '../../../../utils/enumerations.dart';
import '../../../../utils/languages/constants.dart';
import '../../form_helper.dart';

class BottomStateWidget extends StatefulWidget {
  const BottomStateWidget({super.key});

  @override
  State<BottomStateWidget> createState() => BottomStateWidgetState();
}

class BottomStateWidgetState extends State<BottomStateWidget> {
  late ScreenState _screenState;
  late ServiceType selectedService;
  GlobalKey<FormState> descriptionKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    _screenState = ScreenState.initial;
    DataManager().screenStream.screenState.listen((event) {
      if (!mounted) return;
      setState(() {
        _screenState = event;
      });
    });
    selectedService = ServiceType.defaults[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_screenState) {
      case ScreenState.pending:
      //return const PendingContainer();
      case ScreenState.search:
      //return const SearchDriverContainer();
      case ScreenState.isComing:
      case ScreenState.isWaiting:
      case ScreenState.isRiding:
      //return const ActiveRideContainer();
      case ScreenState.finished:
      case ScreenState.rated:
      /*if (displayEndRequest("${_request!.id}")) {
          return FinishedContainer(request: _request!);
        } else {
          return _defaultContent();
        }*/
      case ScreenState.canceled:
      /* if (displayEndRequest("${_request!.id}")) {
          return const CanceledContainer();
        } else {
          return _defaultContent();
        }*/
      default:
        return initialContainer();
    }
  }

  Widget initialContainer() {
    return Card(
      elevation: 20,
      color: Colors.grey[100],
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: selectedService.id == 3
            ? MediaQuery.of(context).size.height * 0.7
            : null,
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(children: serviceTypesContainer()),
                  ),
                  Visibility(
                    visible: selectedService.id == 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: descriptionKey,
                        child: myDescriptionField(
                          context,
                          controller: descriptionController,
                          onValidate: (value) {
                            if (value.toString().isEmpty) {
                              return '${getTranslated(context, 'empty_field')}';
                            }
                            return null;
                          },
                          hint:
                              "${getTranslated(context, 'description_package')}",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SearchCard(
                next: () {
                  if (selectedService.id == 2) {
                    selectedService.setDescription(
                      descriptionController.text,
                    );
                    if (descriptionKey.currentState!.validate()) {
                      context.push(
                        "/${RouterPath.main}/${RouterPath.search}",
                      );
                    }
                  } else {
                    context.push("/${RouterPath.main}/${RouterPath.search}");
                  }
                  DataManager().selectedService = selectedService;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> serviceTypesContainer() {
    List<Widget> wds = [];
    ServiceType.defaults.map((rideType) {
      wds.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedService = rideType;
              descriptionController.text = '';
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: selectedService == rideType
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selectedService == rideType ? Colors.white : Colors.grey,
                width: selectedService == rideType ? 3 : 0.1,
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  "${rideType.image}",
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 50,
                ),
                const SizedBox(height: 5),
                Text(
                  "${getTranslated(context, '${rideType.name}')}",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                    color: selectedService == rideType
                        ? Colors.white
                        : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
    return wds;
  }
}
