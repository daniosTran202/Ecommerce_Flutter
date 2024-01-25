import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_app/components/product_card.dart';
import 'package:grocery_app/models/pagination.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/models/product_filter.dart';
import 'package:grocery_app/providers/providers.dart';

class HomeProductsWidget extends ConsumerWidget {
  const HomeProductsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: const Color(0xffF4F7FA),
      child: Column(children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 15),
              child: Text(
                "Top 10 Produts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _productList(ref),
        ),
      ]),
    );
  }

  Widget _productList(WidgetRef ref) {
    final products = ref.watch(
      homeProductsProvider(
        ProductFilterModel(
          paginationModel: PaginationModel(page: 1, pageSize: 10),
        ),
      ),
    );

    return products.when(
      data: (list) {
        if (list != null) {
          return _buildProductsList(list);
        } else {
          // Xử lý khi list là null
          return const Text("List is null");
        }
      },
      error: (item, __) => const Center(
        child: Text("ERROR :"),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),

      // ...
    );
  }

  Widget _buildProductsList(List<Product> products) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var data = products[index];
          return GestureDetector(
            onTap: () {},
            child: ProductCard(
              model: data,
            ),
          );
        },
      ),
    );
  }
}
