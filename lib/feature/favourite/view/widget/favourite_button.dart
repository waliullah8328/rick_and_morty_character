import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/favourite_view_model.dart';

class FavoriteButton extends ConsumerWidget {
  final int id;

  const FavoriteButton({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favs = ref.watch(favoriteProvider);
    final isFav = favs.contains(id);

    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        ref.read(favoriteProvider.notifier).toggle(id);
      },
    );
  }
}