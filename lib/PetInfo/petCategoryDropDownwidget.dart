import 'package:bb/PetInfo/petCategoryController.dart';
import 'package:bb/PetInfo/petCategoryModel.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Petcategorydropdownwidget extends StatefulWidget {
  final Function(Petcategorymodel?) onChanged;
  final Petcategorymodel? selectedLocation;
  String? spidiesId;
  // final String label;

  Petcategorydropdownwidget({
    super.key,
    required this.onChanged,
    this.selectedLocation,
    this.spidiesId,
    // this.label = "stock category",
  });

  @override
  State<Petcategorydropdownwidget> createState() => _PetcategorydropdownwidgetState();
}

class _PetcategorydropdownwidgetState extends State<Petcategorydropdownwidget> {
  List<Petcategorymodel> locations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    locations = await Petcategorycontroller.fetchPetsCategory();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    return DropdownSearch<Petcategorymodel>(
      items: locations,
      itemAsString: (loc) => loc.categoryName.toString(), // show location name in UI
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
