import 'package:bb/Breed/BreedController.dart';
import 'package:bb/Breed/BreedModel.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Breedwidget extends StatefulWidget {
  final Function(BreedModel?) onChanged;
  final BreedModel? selectedLocation;
  String? spidiesId;
  String? breedId;
  // final String label;

  Breedwidget({ 
    super.key,
    required this.onChanged,
    this.selectedLocation,
    this.spidiesId,
    this.breedId,
    // this.label = "stock category",
  });

  @override
  State<Breedwidget> createState() => _BreedwidgetState();
}

class _BreedwidgetState extends State<Breedwidget> {
  List<BreedModel> locations = [];
  bool isLoading = true;
  BreedModel? matched;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    locations = await Breedcontroller.fetchLocations(widget.spidiesId.toString());

     // FIND MATCHED ITEM
    if (widget.breedId != null && widget.breedId!.isNotEmpty) {
      for (var loc in locations) {
        if (loc.breedId == widget.breedId) {
          matched = loc;
          print("Matched ID = ${matched?.breedId}");
          print("Matched Name = ${matched?.breedName}");

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
  }
    
  //   setState(() => isLoading = false);
  // }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    return DropdownSearch<BreedModel>(
      items: locations,
      itemAsString: (loc) => loc.breedName.toString(), // show location name in UI
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
