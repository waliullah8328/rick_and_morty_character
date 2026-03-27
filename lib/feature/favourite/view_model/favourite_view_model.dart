import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final favoriteProvider =
StateNotifierProvider<FavoriteNotifier, Set<int>>(
        (ref) => FavoriteNotifier());

class FavoriteNotifier extends StateNotifier<Set<int>> {
  final box = Hive.box<int>('favorites');

  FavoriteNotifier() : super({}) {
    load();
  }

  void load() {
    state = box.values.toSet();
  }

  void toggle(int id) {
    if (state.contains(id)) {
      box.delete(id);
      state = {...state}..remove(id);
    } else {
      box.put(id, id);
      state = {...state, id};
    }
  }
}