import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ super.key });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

    final List<String> _items = [
    'Apple', 'Banana', 'Cherry', 'Date', 'Fig', 'Grape', 'Mango', 'Orange'
  ];
  List<String> _filteredItems = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = _items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  
 
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterItems,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverGrid(
            delegate: SliverChildListDelegate([
              _buildImageButton(''),
              _buildImageButton(''),
              _buildImageButton(''),
              _buildImageButton(''),
              _buildImageButton(''),
              
            ]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // По умолчанию 2 в ряд
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverGrid(
            delegate: SliverChildListDelegate([
              _buildImageButton(''),
            ]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // В этой строке 1 кнопка
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverGrid(
            delegate: SliverChildListDelegate([
              _buildImageButton(''),
              _buildImageButton(''),
              _buildImageButton(''),
            ]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // В этой строке 3 кнопки
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildImageButton(String imagePath) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    child: Image.asset(imagePath, fit: BoxFit.cover),
  );
}