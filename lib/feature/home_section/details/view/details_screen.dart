import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../edit_screen/view/edit_screen.dart';
import '../../home/model/home_model.dart';
import '../../home/view_model/home_view_model.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  final Result character;

  const DetailsScreen({super.key, required this.character});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  late Result character;

  @override
  void initState() {
    super.initState();
    character = widget.character;
  }

  void refreshData() {
    final box = Hive.box<Result>('characters');
    final updated = box.get(character.id);
    if (updated != null) {
      setState(() => character = updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(character.name ?? "",
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          if (character.isEdited)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: "Reset Character",
              onPressed: () {
                ref.read(characterProvider.notifier).resetById(character.id!);
                refreshData();
              },
            ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditScreen(character: character)));
              refreshData();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: "character_${character.id}",
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(25)),
                child: CachedNetworkImage(
                  imageUrl: character.image ?? "",
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (c, url) =>
                      Container(height: 300, child: const Center(child: CircularProgressIndicator())),
                  errorWidget: (c, url, err) =>
                      Container(height: 300, color: Colors.grey.shade300, child: const Center(child: Icon(Icons.broken_image, size: 50))),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 6))
                  ]),
              child: Column(
                children: [
                  buildItem("Name", character.name),
                  buildItem("Status", character.status),
                  buildItem("Species", character.species),
                  buildItem("Type", character.type),
                  buildItem("Gender", character.gender),
                  buildItem("Origin", character.origin?.name),
                  buildItem("Location", character.location?.name),
                  buildItem(
                      "Created",
                      character.created
                          ?.toLocal()
                          .toString()
                          .split(" ")
                          .first),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildItem(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Text(title,
              style: TextStyle(
                  color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          flex: 3,
          child: Text(value ?? "-", style: const TextStyle(fontWeight: FontWeight.bold)),
        )
      ]),
    );
  }
}