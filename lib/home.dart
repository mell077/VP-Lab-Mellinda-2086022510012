// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Make a collection of cards (102)
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
    );

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          // TODO: Center items on the card (103)
          crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 앞 가장자리에 정렬
          children: [
            AspectRatio(
              // AspectRatio 위젯은 제공되는 이미지의 종류와 상관없이 이미지의 모양을 결정
              aspectRatio: 18.0 / 11.0,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                // Adjust the box size (102)
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  // TODO: Align labels to the bottom and center (103)
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // TODO: Change innermost Column (103)
                  children: [
                    // TODO: Handle overflowing labels (103)
                    Text(
                      product.name,
                      style: theme.textTheme.titleLarge,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      // Add app bar (102)
      appBar: AppBar(
        // Add buttons and title (102)
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu button');
          },
        ),
        title: const Text('SHRINE'),
        actions: [
          IconButton(
            onPressed: () {
              print('Search button');
            },
            icon: const Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
          ),
          IconButton(
            onPressed: () {
              print('Filter button');
            },
            icon: const Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
          ),
        ],
      ),
      // Add a grid view (102)
      body: GridView.count(
        crossAxisCount: 2, // 전체 항목 수
        padding: const EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        // Build a grid of cards (102)
        children: _buildGridCards(context),
      ),
      // Set resizeToAvoidBottomInset (101)
      // 키보드의 모양으로 홈페이지나 홈페이지 위젯의 크기가 변경되지 않도록 설정
      resizeToAvoidBottomInset: false,
    );
  }
}
