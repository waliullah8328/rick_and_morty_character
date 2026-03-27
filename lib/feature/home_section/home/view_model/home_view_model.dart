import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../../core/repository/api_services.dart';

import '../model/home_model.dart';

final characterProvider =
StateNotifierProvider<CharacterNotifier, List<Result>>(
        (ref) => CharacterNotifier(ref));

class CharacterNotifier extends StateNotifier<List<Result>> {
  final Ref ref;
  int page = 1;
  bool isLoading = false;

  CharacterNotifier(this.ref) : super([]) {
    fetchNext();
  }

  Future<void> fetchNext() async {
    if (isLoading) return;
    isLoading = true;

    final box = Hive.box<Result>('characters');

    try {
      final apiData = await ref.read(apiProvider).getCharacters(page);
      List<Result> newList = [];

      for (var item in apiData) {
        final local = box.get(item.id);

        // Keep edited data
        if (local != null && local.isEdited) {
          newList.add(local);
        } else {
          final toStore = item.copyWith(originalJson: item.toJson());
          box.put(item.id, toStore);
          newList.add(toStore);
        }
      }

      state = [...state, ...newList];
      page++;
    } catch (e) {
      print("Offline mode: $e");
      if (state.isEmpty) {
        state = box.values.toList();
      }
    }

    isLoading = false;
  }

  void filter({String? searchQuery, String? status, String? species}) {
    final box = Hive.box<Result>('characters');
    List<Result> all = box.values.toList();

    final filtered = all.where((c) {
      final matchesSearch = searchQuery == null ||
          searchQuery.isEmpty ||
          c.name!.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesStatus = status == "All" || c.status == status;
      final matchesSpecies = species == "All" || c.species == species;
      return matchesSearch && matchesStatus && matchesSpecies;
    }).toList();

    state = filtered;
  }

  void resetEdited() {
    final box = Hive.box<Result>('characters');
    for (var c in box.values) {
      if (c.isEdited) {
        final resetItem = c.reset();
        box.put(c.id, resetItem);
      }
    }
    state = box.values.toList();
  }

  void resetById(int id) {
    final box = Hive.box<Result>('characters');
    final c = box.get(id);
    if (c != null && c.isEdited) {
      final resetItem = c.reset();
      box.put(id, resetItem);
    }
    state = box.values.toList();
  }

  Future<void> refresh() async {
    page = 1;
    state = [];
    await fetchNext();
  }
}