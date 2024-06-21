import 'package:breshop/data/models/category.dart';
import 'package:breshop/data/repositories/category_repository.dart';
import 'package:flutter/material.dart';

class CategoryCarousel extends StatefulWidget {
  final Function(int?) onCategorySelected;

  const CategoryCarousel({super.key, required this.onCategorySelected});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryCarouselState createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends State<CategoryCarousel> {
  late Future<List<Category>> _categoriesFuture;
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryRepository.getAllCategories();
    _selectedCategoryId = null;
  }

  void _onCategoryTap(int? categoryId) {
    if (categoryId == _selectedCategoryId) {
      categoryId = null;
    }

    setState(() {
      _selectedCategoryId = categoryId;
    });
    widget.onCategorySelected(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching categories'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No categories found'));
        }

        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final category = snapshot.data![index];
              final isSelected = category.id == _selectedCategoryId;

              return Container(
                margin: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 4,
                  right: 4,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    backgroundColor: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    foregroundColor: isSelected ? Colors.white : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _onCategoryTap(category.id);
                  },
                  child: Text(category.name),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
