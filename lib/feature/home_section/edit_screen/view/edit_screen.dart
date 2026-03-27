import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_character/core/common/widgets/custom_text.dart';



import '../../../../core/utils/constants/app_sizer.dart';
import '../../home/model/home_model.dart';
import '../view_model/edit_view_model.dart';

class EditScreen extends ConsumerWidget {
  final Result character;

  const EditScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editCharacterProvider(character));
    final editNotifier = ref.read(editCharacterProvider(character).notifier);

    final statusOptions = ["Alive", "Dead", "Unknown"];
    final speciesOptions = ["Human", "Alien", "Unknown"];
    final genderOptions = ["Male", "Female", "Unknown"];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Edit Character"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Reset Changes",
            onPressed: () => editNotifier.reset(),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  buildField("Name", editState.name.toString() ,editNotifier.updateName),
                  buildDropdown(
                      "Status", editState.status, statusOptions, editNotifier.updateStatus),
                  buildDropdown(
                      "Species", editState.species, speciesOptions, editNotifier.updateSpecies),
                  buildField("Type", editState.type.toString(), editNotifier.updateType),
                  buildDropdown(
                      "Gender", editState.gender, genderOptions, editNotifier.updateGender),
                  buildField("Origin", editState.origin?.name ?? "", editNotifier.updateOrigin),
                  buildField("Location", editState.location?.name ?? "", editNotifier.updateLocation),
                ],
              ),
            ),
            const SizedBox(height: 30),

            /// Save Button
            ElevatedButton(
              onPressed: () {
                editNotifier.save();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField(String label, String value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: label),
          SizedBox(height: 6.h,),
          TextField(
            onChanged: onChanged,
            controller: TextEditingController(text: value),
            decoration: InputDecoration(

              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown(
      String label, String? currentValue, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: label),
          SizedBox(height: 6.h,),
          InputDecorator(
            decoration: InputDecoration(

              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentValue,
                isExpanded: true,
                items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}