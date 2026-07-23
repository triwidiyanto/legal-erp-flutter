import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/category_provider.dart';
import 'add_category_page.dart';
import 'edit_category_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CategoryProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFD9AE63),
        elevation: 0,
        title: const Text(
          'Master Category',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// HEADER
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      'Master Category',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      'Manage Legal Document Categories',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFD9AE63),
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const AddCategoryPage(),
                      ),
                    );
                  },

                  icon: const Icon(Icons.add),

                  label: const Text(
                    'Add Category',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// TABLE HEADER
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),

              decoration: BoxDecoration(
                color: const Color(0xFFD9AE63),
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: const Row(
                children: [

                  Expanded(
                    flex: 2,
                    child: Text(
                      'ID',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    flex: 4,
                    child: Text(
                      'Category',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    flex: 5,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    flex: 2,
                    child: Text(
                      'Status',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    flex: 3,
                    child: Text(
                      'Action',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount:
                    provider.categories.length,

                itemBuilder:
                    (context, index) {

                  final category =
                      provider.categories[index];

                  return Container(
                    margin:
                        const EdgeInsets.only(
                      bottom: 12,
                    ),

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),

                      boxShadow: [

                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [
                                                /// ID
                        Expanded(
                          flex: 2,
                          child: Text(
                            category.id,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),

                        /// CATEGORY
                        Expanded(
                          flex: 4,
                          child: Text(
                            category.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),

                        /// DESCRIPTION
                        Expanded(
                          flex: 5,
                          child: Text(
                            category.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),

                        const SizedBox(width: 20),

                        /// STATUS
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: category.active
                                    ? Colors.green.shade100
                                    : Colors.red.shade100,
                                borderRadius:
                                    BorderRadius.circular(30),
                              ),
                              child: Text(
                                category.active
                                    ? 'Active'
                                    : 'Inactive',
                                style: TextStyle(
                                  color: category.active
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),

                        /// ACTION
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [

                              /// EDIT
                              IconButton(
                                tooltip: 'Edit',
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          EditCategoryPage(
                                        category: category,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              /// DELETE
                              IconButton(
                                tooltip: 'Delete',
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {

                                  final result =
                                      await showDialog<bool>(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Delete Category',
                                        ),

                                        content: Text(
                                          'Delete "${category.name}" ?',
                                        ),

                                        actions: [

                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                context,
                                                false,
                                              );
                                            },
                                            child: const Text(
                                              'Cancel',
                                            ),
                                          ),

                                          ElevatedButton(
                                            style:
                                                ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.red,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(
                                                context,
                                                true,
                                              );
                                            },
                                            child: const Text(
                                              'Delete',
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (result == true) {

                                    provider.delete(
                                      category.id,
                                    );

                                    ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${category.name} deleted successfully',
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}