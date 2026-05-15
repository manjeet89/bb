import 'package:bb/AddressModule/Country/CountryController.dart';
import 'package:bb/PetInfo/PetListController.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Petlistwidget extends StatefulWidget {
  final Function(Petlistmodel?) onChanged;
  final Petlistmodel? selectedLocation;
  String? countryid;

  Petlistwidget({
    super.key,
    required this.onChanged,
    this.selectedLocation,
    this.countryid,
    // this.label = "stock category",
  });

  @override
  State<Petlistwidget> createState() => _PetlistwidgetState();
}

class _PetlistwidgetState extends State<Petlistwidget> {
  List<Petlistmodel> locations = [];
  bool isLoading = true;
  Petlistmodel? matched;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final allPets = await PetService.fetchPets();

    /// ✅ Filter only alive pets
    locations = allPets.where((pet) {
      return pet.petExpireDate == null ||
          pet.petExpireDate.toString().isEmpty ||
          pet.petExpireDate.toString() == "null";
    }).toList();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    return DropdownSearch<Petlistmodel>(
      items: locations,
      itemAsString: (loc) => loc.petName.toString(), // show location name in UI
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
