import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/pagination.dart';
import 'package:grocery_app/models/product_filter.dart';
import 'package:grocery_app/providers/providers.dart';

class HomeCategoriesWidget extends ConsumerWidget {
  const HomeCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "All Categories",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _categoriesList(ref),
        )
      ],
    );
  }

  Widget _categoriesList(WidgetRef ref) {
    final categories = ref.watch(
      homeCategoriesProvider(
        PaginationModel(page: 1, pageSize: 10),
      ),
    );

    // return categories.when(
    //   data: (list) {
    //     if (list != null) {
    //       return _buildCategoriesList(list!);
    //     } else {
    //       // Xử lý khi list là null
    //       return const Text("List is null");
    //     }
    //   },
    //   error: (item, __) => const Center(
    //     child: Text("ERROR :"),
    //   ),
    //   loading: () => const Center(child: CircularProgressIndicator()),

    //   // ...
    // );

    return categories.when(
      data: (list) {
        return _buildCategoriesList(list!, ref);
      },
      error: (item, __) => const Center(
        child: Text("ERROR :"),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildCategoriesList(List<Category> categories, WidgetRef ref) {
    return Container(
        height: 100,
        alignment: Alignment.center,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            var data = categories[index];
            return GestureDetector(
                onTap: () {
                  ProductFilterModel filterModel = ProductFilterModel(
                    paginationModel: PaginationModel(page: 1, pageSize: 10),
                    categoryId: data.categoryId,
                  );

                  ref
                      .read(productsFilterProvider.notifier)
                      .setProductFilter(filterModel);
                  ref.read(productsNotifierProvider.notifier).getProducts();

                  Navigator.of(context).pushNamed(
                    "/products",
                    arguments: {
                      'categoryId': data.categoryId,
                      'categoryName': data.categoryName,
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        child: Image.network(
                          data.fullImagePath,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            data.categoryName,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            size: 13,
                          )
                        ],
                      )
                    ],
                  ),
                ));
          },
        ));
  }
}
