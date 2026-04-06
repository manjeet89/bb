import 'package:bb/AddressModule/State/StateController.dart';
import 'package:bb/AddressModule/State/StateModel.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Statewidget extends StatefulWidget {
  final Function(StateModel?) onChanged;
  final StateModel? selectedLocation;
  final String categoryId;
  String? stateid;
  // final String label;

  Statewidget({
    super.key,
    required this.onChanged,
    this.selectedLocation,
    required this.categoryId,
    required this.stateid,
    // this.label = "stock category",
  });

  @override
  State<Statewidget> createState() => _StatewidgetState();
}

class _StatewidgetState extends State<Statewidget> {
  List<StateModel> locations = [];
  bool isLoading = true;
  StateModel? matched;

  @override
  void initState() {
    super.initState();
    _loadLocations(widget.categoryId.toString());
  }

  @override
  void didUpdateWidget(covariant Statewidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      setState(() {
        isLoading = true;
        locations.clear();
      });
      _loadLocations(widget.categoryId);
    }
  }

  Future<void> _loadLocations(String categoryId) async {
    try {
      locations = await Statecontroller.fetchLocations(categoryId: categoryId);
    } catch (e) {
      print("Error loading stock types: $e");
    }

    // FIND MATCHED ITEM
    if (widget.stateid != null && widget.stateid!.isNotEmpty) {
      for (var loc in locations) {
        if (loc.stateId == widget.stateid) {
          matched = loc;
          print("Matched ID = ${matched?.stateId}");
          print("Matched Name = ${matched?.stateName}");

          break;
        }
      }
    }

    // UPDATE UI
    setState(() {
      isLoading = false;
    });

    // CALL PARENT onChanged AFTER UI UPDATE
    if (matched != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChanged(matched!);
      });
    }
    // setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    return DropdownSearch<StateModel>(
      items: locations,
      itemAsString: (loc) => loc.stateName.toString(), // show location name in UI
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          fillColor: Colors.white,
          // labelText: widget.label,

          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          labelStyle: TextStyle(
            color: AppColors.darkRed, // label color when not focused
          ),

          // floatingLabelStyle: TextStyle(
          //   color: Color.fromARGB(255, 23, 10, 138), // label color when focused
          //   fontWeight: FontWeight.bold,
          // ),

          // border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.darkRed, // border when not focused
            ),
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(4)),
          //   borderSide: BorderSide(
          //     width: 2, // a bit thicker when focused
          //     color: Color.fromARGB(255, 23, 10, 138), // border color when focused
          //   ),
          // ),
        ),
      ),
      popupProps: PopupProps.menu(
         showSearchBox: true, // Always show search bar
        fit: FlexFit.loose, // ✅ IMPORTANT (makes popup wrap content)

        constraints: BoxConstraints(
          maxHeight: 250, // only max limit, no manual calculation
        ),

        listViewProps: ListViewProps(
          shrinkWrap: true, // ✅ THIS FIXES EMPTY SPACE
        ),
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Search ...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      selectedItem: widget.selectedLocation,
      onChanged: widget.onChanged,
    );
  }
}
