import 'package:comicsstudio/features/home/providers/comic_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../../../home/domain/models/comic.dart';
import '../../domain/models/drawing_point.dart';
import '../../domain/models/text_object.dart';
import '../widgets/drawing_painter.dart';


class DrawingPage extends StatefulWidget {
  const DrawingPage({
    super.key,
    required this.comic,
    required this.comicIndex,
  });
  final Comic comic;
  final int comicIndex;

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  late ComicProvider _comicProvider;
  late List<List<DrawingPoint?>> _pages;
  final List<TextObject> _texts = [];
  int _currentPage = 0;
  Color _currentColor = Colors.black;
  double _strokeWidth = 5.0;
  final List<DrawingPoint?> _undoStack = [];
  final List<DrawingPoint?> _redoStack = [];
  Color _backgroundColor = Colors.white;
  bool _isEraser = false;
  String _currentBrush = 'pen'; // (pen, pencil, thick)


  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _pages[_currentPage].add(DrawingPoint(
        point: details.localPosition,
        color: _isEraser ? _backgroundColor : _currentColor,
        strokeWidth: _strokeWidth,
        brushType: _currentBrush,
      ));
      _undoStack.add(_pages[_currentPage].last);
      _redoStack.clear();
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _pages[_currentPage].add(null);
    });
  }

  void _onTapDown(TapDownDetails details) { }

  void _addPage() {
    setState(() {
      _pages.add([]);
      _currentPage = _pages.length - 1;
    });
  }

  void _prevPage() {
    if (_currentPage > 0) setState(() => _currentPage--);
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) setState(() => _currentPage++);
  }

  void _toggleEraser() {
    setState(() {
      _isEraser = !_isEraser;
    });
  }

  void _pickColor() {
    Color selectedColor = _currentColor;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите цвет'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (color) => selectedColor = color,
              labelTypes: const [],
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _currentColor = selectedColor;
                  _isEraser = false;
                });
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _pickStrokeWidth() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите толщину кисти'),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    min: 1.0,
                    max: 10.0,
                    value: _strokeWidth,
                    onChanged: (value) {
                      setStateDialog(() => _strokeWidth = value);
                      setState(() {});
                    },
                  ),
                  Text('${_strokeWidth.toStringAsFixed(1)} px'),
                ],
              );
            },
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
        );
      },
    );
  }

  void _fillCanvas() {
    showDialog(
      context: context,
      builder: (context) {
        Color selectedColor = _backgroundColor;
        return AlertDialog(
          title: const Text('Выберите цвет заливки'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _backgroundColor,
              onColorChanged: (color) => selectedColor = color,
              labelTypes: const [],
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _backgroundColor = selectedColor;
                });
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _changeBrush() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите кисть'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Обычная кисть'),
                onTap: () {
                  setState(() {
                    _currentBrush = 'pen';
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                title: const Text('Карандаш'),
                onTap: () {
                  setState(() {
                    _currentBrush = 'pencil';
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                title: const Text('Толстая кисть'),
                onTap: () {
                  setState(() {
                    _currentBrush = 'thick';
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _undo() {
    if (_undoStack.isNotEmpty) {
      setState(() {
        _redoStack.add(_undoStack.removeLast());
        _pages[_currentPage].removeLast();
      });
    }
  }

  void _redo() {
    if (_redoStack.isNotEmpty) {
      setState(() {
        _pages[_currentPage].add(_redoStack.removeLast());
        _undoStack.add(_pages[_currentPage].last);
      });
    }
  }

  void _deletePage() {
    if (_pages.length > 1) {
      setState(() {
        _pages.removeAt(_currentPage);
        if (_currentPage > 0) {
          _currentPage--;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Нельзя удалить последнюю страницу.')),
      );
    }
  }

  void _addText() {
    showDialog(
      context: context,
      builder: (context) {
        String text = '';
        return AlertDialog(
          title: const Text('Введите текст'),
          content: TextField(
            onChanged: (value) {
              text = value;
            },
            decoration: const InputDecoration(hintText: 'Введите текст...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _texts.add(TextObject(
                    text: text,
                    position: const Offset(100, 100),
                    color: _currentColor,
                  ));
                });
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _editText(TextObject text) {
    showDialog(
      context: context,
      builder: (context) {
        String newText = text.text;
        return AlertDialog(
          title: const Text('Редактировать текст'),
          content: TextField(
            controller: TextEditingController(text: text.text),
            onChanged: (value) {
              newText = value;
            },
            decoration: const InputDecoration(hintText: 'Введите новый текст...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  text.text = newText;
                });
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _deleteText(TextObject text) {
    setState(() {
      _texts.remove(text);
    });
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _comicProvider = Provider.of<ComicProvider>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    _pages = widget.comic.drawingPages.isNotEmpty
        ? widget.comic.drawingPages
        : [[]];

    if (_pages.isNotEmpty) {
      _currentPage = 0;
    }
  }

  @override
  void dispose() {
    _comicProvider.saveComic(widget.comicIndex, _pages);
    // widget.comic.savePages(null, _pages);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Рисование комикса'),
        actions: [
          IconButton(icon: const Icon(Icons.undo), onPressed: _undo),
          IconButton(icon: const Icon(Icons.redo), onPressed: _redo),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deletePage,
            tooltip: 'Удалить страницу',
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        onTapDown: _onTapDown,
        child: Stack(
          children: [
            Container(color: _backgroundColor),
            CustomPaint(
              painter: DrawingPainter(points: _pages[_currentPage]),
              size: Size.infinite,
            ),
            ..._texts.map((text) => Positioned(
              left: text.position.dx,
              top: text.position.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    text.position = details.localPosition;
                  });
                },
                onTap: () {
                  _editText(text); // Редактирование текста при нажатии
                },
                onLongPress: () {
                  _deleteText(text); // Удаление текста при долгом нажатии
                },
                child: Text(
                  text.text,
                  style: TextStyle(
                    color: text.color,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
            Positioned(
              bottom: 20,
              left: 20,
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.arrow_back), onPressed: _prevPage),
                  Text("Стр. ${_currentPage + 1} / ${_pages.length}"),
                  IconButton(icon: const Icon(Icons.arrow_forward), onPressed: _nextPage),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.color_lens),
                onPressed: _pickColor,
                tooltip: 'Выбрать цвет',
              ),
              IconButton(
                icon: const Icon(Icons.brush),
                onPressed: _pickStrokeWidth,
                tooltip: 'Выбрать толщину кисти',
              ),
              IconButton(
                icon: const Icon(Icons.format_paint),
                onPressed: _fillCanvas,
                tooltip: 'Выбрать цвет фона',
              ),
              IconButton(
                icon: Icon(_isEraser ? Icons.create : Icons.clear),
                onPressed: _toggleEraser,
                tooltip: 'Переключить ластик',
              ),
              IconButton(
                icon: const Icon(Icons.pages),
                onPressed: _addPage,
                tooltip: 'Добавить страницу',
              ),
              IconButton(
                icon: const Icon(Icons.text_fields),
                onPressed: _addText,
                tooltip: 'Добавить текст',
              ),
              // IconButton(
              //   icon: const Icon(Icons.chat_bubble),
              //   onPressed: _showCloudPicker,
              //   tooltip: 'Выбрать облачко',
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeBrush,
        tooltip: 'Выбрать кисть',
        child: const Icon(Icons.brush),
      ),
    );
  }
}


  // import '../../domain/models/bubble.dart';

  // final List<Bubble> _bubbles = [];
  // final List<String> _bubbleImages = ['bubble1', 'bubble2', 'bubble3'];
  // String _selectedCloud = 'bubble1';

  // void _showCloudPicker() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Выберите облачко'),
  //         content: DropdownButton<String>(
  //           value: _selectedCloud,
  //           items: _bubbleImages.map((cloud) {
  //             return DropdownMenuItem<String>(
  //               value: cloud,
  //               child: Text(cloud),
  //             );
  //           }).toList(),
  //           onChanged: (value) {
  //             setState(() {
  //               _selectedCloud = value!;
  //             });
  //             Navigator.pop(context);
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _addCloud() {
  //   setState(() {
  //     _bubbles.add(Bubble(
  //       image: AssetImage('assets/images/bubbles/$_selectedCloud.png'),
  //       position: const Offset(200, 200),
  //       width: 200,
  //       height: 100,
  //     ));
  //   });
  // }

  // void _editBubbleText(Bubble bubble) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       String newText = '';
  //       return AlertDialog(
  //         title: const Text('Измените текст'),
  //         content: TextField(
  //           onChanged: (value) {
  //             newText = value;
  //           },
  //           decoration: const InputDecoration(hintText: 'Введите новый текст...'),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               setState(() {
  //                 bubble.text = newText;
  //               });
  //               Navigator.pop(context);
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }