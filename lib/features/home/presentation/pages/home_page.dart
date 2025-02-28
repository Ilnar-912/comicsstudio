import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../drawing/presentation/pages/drawing_page.dart';
import '../../domain/models/comic.dart';
import '../../providers/comic_provider.dart';


class HomePage extends StatelessWidget {
  const HomePage({ super.key });

  void _showAddComicDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить новый комикс'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Название комикса'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  Provider.of<ComicProvider>(context, listen: false)
                      .addComic(titleController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Добавить'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
          ],
        );
      },
    );
  }

  void _showEditComicDialog(BuildContext context, Comic comic, int index) {
    final TextEditingController titleController =
        TextEditingController(text: comic.title);
    final TextEditingController coverController =
        TextEditingController(text: comic.coverImage);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Редактировать комикс'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Название комикса'),
              ),
              TextField(
                controller: coverController,
                decoration: const InputDecoration(hintText: 'Путь к обложке'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  Provider.of<ComicProvider>(context, listen: false)
                      .updateComicTitle(index, titleController.text);
                }
                if (coverController.text.isNotEmpty) {
                  Provider.of<ComicProvider>(context, listen: false)
                      .updateComicCover(index, coverController.text);
                }
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ComicProvider>(context, listen: false).loadComics();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список комиксов'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddComicDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ComicProvider>(
          builder: (context, provider, child) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: provider.comics.length,
              itemBuilder: (context, index) {
                final comic = provider.comics[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DrawingPage(
                          comic: comic,
                          comicIndex: index,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: comic.coverImage.isNotEmpty
                              ? Image.asset(
                                  comic.coverImage,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.white,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            comic.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Страниц: ${comic.pageCount}'),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditComicDialog(context, comic, index);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                provider.removeComic(index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      )
    );
  }
}