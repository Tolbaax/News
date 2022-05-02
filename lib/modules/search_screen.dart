import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  TextEditingController searchController  =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          defaultFormField(
              validate:  (value) {
                if (value!.isEmpty) {
                  return 'search must not be empty';
                }
                return null;
              },
              controller: searchController,
              type: TextInputType.text,
              prefix: Icons.search,
              label: 'Search'
          ),
        ],
      ),
    );
  }
}
