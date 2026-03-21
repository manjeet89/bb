import 'package:bb/AddressModule/District/DistricModel.dart';
import 'package:bb/AddressModule/District/DistrictController.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Districtwidget extends StatefulWidget {
  final Function(DistrictModelDropDown?) onChanged;
  final DistrictModelDropDown? selectedLocation;
  final String categoryId;
  // final String label;

  const Districtwidget({
    super.key,
    required this.onChanged,
    this.selectedLocation,
    required this.categoryId,
    // this.label = "stock category",
  });

  @override
  State<Districtwidget> createState() => _DistrictwidgetState();
}

class _DistrictwidgetState extends State<Districtwidget> {
  List<DistrictModelDropDown> locations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLocations(widget.categoryId.toString());
  }

  @override
  void didUpdateWidget(covariant Districtwidget oldWidget) {
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
      locations = await Districtcontroller.fetchLocations(categoryId: categoryId);
    } catch (e) {
      print("Error loading stock types: $e");
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    return DropdownSearch<DistrictModelDropDown>(
      items: locations,
      itemAsString: (loc) => loc.districtName.toString(), // show location name in UI
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
        showSearchBox: true,

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
