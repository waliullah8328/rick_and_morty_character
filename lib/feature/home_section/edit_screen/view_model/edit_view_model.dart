import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../home/model/home_model.dart';
import '../../home/view_model/home_view_model.dart';




final editCharacterProvider =
StateNotifierProvider.family<EditCharacterNotifier, Result, Result>(
        (ref, character) => EditCharacterNotifier(ref, character));

class EditCharacterNotifier extends StateNotifier<Result> {
  final Ref ref;
  EditCharacterNotifier(this.ref, Result character) : super(character);

  /// Update Text Fields
  void updateName(String value) => state = state.copyWith(name: value);
  void updateType(String value) => state = state.copyWith(type: value);
  void updateOrigin(String value) =>
      state = state.copyWith(origin: Location(name: value, url: state.origin?.url));
  void updateLocation(String value) =>
      state = state.copyWith(location: Location(name: value, url: state.location?.url));

  /// Update Dropdowns
  void updateStatus(String? value) => state = state.copyWith(status: value);
  void updateSpecies(String? value) => state = state.copyWith(species: value);
  void updateGender(String? value) => state = state.copyWith(gender: value);

  /// Save to Hive & refresh main provider
  void save() {
    final box = Hive.box<Result>('characters');
    final updated = state.copyWith(isEdited: true);
    box.put(updated.id, updated);
    ref.read(characterProvider.notifier).refresh();
  }

  /// Reset to original Hive data
  void reset() {
    final box = Hive.box<Result>('characters');
    final original = box.get(state.id);
    if (original != null) {
      state = original;
    }
  }
}