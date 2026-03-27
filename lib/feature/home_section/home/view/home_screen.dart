import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/constants/app_sizer.dart';
import '../../../favourite/view/widget/favourite_button.dart';
import '../../details/view/details_screen.dart';
import '../view_model/home_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final searchController = TextEditingController();
  String selectedStatus = "All";
  String selectedSpecies = "All";

  @override
  Widget build(BuildContext context) {
    final characters = ref.watch(characterProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Characters"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          /// 🔍 Search & Filter
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search characters...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onChanged: (value) => ref
                      .read(characterProvider.notifier)
                      .filter(
                    searchQuery: value,
                    status: selectedStatus,
                    species: selectedSpecies,
                  ),
                ),
                SizedBox(height: 16.w),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedStatus,
                        items: ["All", "Alive", "Dead", "Unknown"]
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() => selectedStatus = val!);
                          ref.read(characterProvider.notifier).filter(
                            searchQuery: searchController.text,
                            status: selectedStatus,
                            species: selectedSpecies,
                          );
                        },
                        decoration: const InputDecoration(
                          labelText: "Status",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedSpecies,
                        items: ["All", "Human", "Alien"]
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() => selectedSpecies = val!);
                          ref.read(characterProvider.notifier).filter(
                            searchQuery: searchController.text,
                            status: selectedStatus,
                            species: selectedSpecies,
                          );
                        },
                        decoration: const InputDecoration(
                          labelText: "Species",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// 🔥 Character List
          Expanded(
            child: characters.isEmpty
                ? const Center(
              child: Text(
                "No data found",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
                : NotificationListener<ScrollNotification>(
              onNotification: (scroll) {
                if (scroll.metrics.pixels >=
                    scroll.metrics.maxScrollExtent - 100) {
                  ref.read(characterProvider.notifier).fetchNext();
                }
                return true;
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: characters.length,
                itemBuilder: (_, i) {
                  final c = characters[i];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(character: c),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black.withValues(alpha: 0.05),
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Hero(
                            tag: "character_${c.id}",
                            child: ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(18),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: c.image ?? "",
                                height: 115.h,
                                width: 110.w,
                                fit: BoxFit.fitHeight,
                                placeholder: (context, url) => Container(
                                  height: 100.h,
                                  width: 100.w,
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Container(
                                      height: 100.h,
                                      width: 100.w,
                                      color: Colors.grey.shade300,
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.broken_image),
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    c.name ?? "-",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "${c.status ?? "-"} • ${c.species ?? "-"}",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    c.location?.name ?? "-",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FavoriteButton(id: c.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}