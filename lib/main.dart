import 'package:breshop/components/category_carousel.dart';
import 'package:breshop/components/custom_app_bar.dart';
import 'package:breshop/components/custom_bottom_navigation_bar.dart';
import 'package:breshop/components/item_card.dart';
import 'package:breshop/data/database_provider.dart';
import 'package:breshop/data/models/item.dart';
import 'package:breshop/data/repositories/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await DatabaseProvider().database;

  runApp(const BreshopApp());
}

class BreshopApp extends StatelessWidget {
  const BreshopApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Breshop'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchItems(null);
  }

  void _fetchItems(categoryId) async {
    if (categoryId == null) {
      _items = await ItemRepository.getAllItems();
    } else {
      _items = await ItemRepository.getItemsByCategoryId(categoryId);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: Column(
        children: [
          CategoryCarousel(onCategorySelected: _fetchItems),
          const SizedBox(height: 8),
          Text(
            '${_items.length} items found',
            style: TextStyle(
              fontSize: 9,
              fontStyle: FontStyle.italic,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ItemCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
