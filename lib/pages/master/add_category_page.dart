import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/category_model.dart';
import '../../provider/category_provider.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() =>
      _AddCategoryPageState();
}

class _AddCategoryPageState
    extends State<AddCategoryPage> {

  final nameController =
      TextEditingController();

  final descController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color(0xFFD9AE63),

        title:
            const Text(
          'Add Category',
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(24),

        child: Column(
          children: [

            TextField(
              controller:
                  nameController,

              decoration:
                  const InputDecoration(
                labelText:
                    'Category Name',
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            TextField(
              controller:
                  descController,

              decoration:
                  const InputDecoration(
                labelText:
                    'Description',
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
              width:
                  double.infinity,

              child:
                  ElevatedButton(

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xFFD9AE63,
                  ),
                ),

                onPressed: () {

                  context
                      .read<
                          CategoryProvider>()
                      .add(
                        CategoryModel(
                          id:
                              'CAT${DateTime.now().millisecondsSinceEpoch}',
                          name:
                              nameController.text,
                          description:
                              descController.text,
                        ),
                      );

                  Navigator.pop(
                    context,
                  );
                },

                child:
                    const Text(
                  'SAVE',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}