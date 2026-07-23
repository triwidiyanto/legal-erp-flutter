import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/category_model.dart';
import '../../../provider/category_provider.dart';

class EditCategoryPage extends StatefulWidget {
  final CategoryModel category;

  const EditCategoryPage({
    super.key,
    required this.category,
  });

  @override
  State<EditCategoryPage> createState() =>
      _EditCategoryPageState();
}

class _EditCategoryPageState
    extends State<EditCategoryPage> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  bool active = true;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.category.name,
    );

    descriptionController = TextEditingController(
      text: widget.category.description,
    );

    active = widget.category.active;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFD9AE63),
        title: const Text(
          "Edit Category",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: SizedBox(
          width: 650,

          child: Card(
            elevation: 3,

            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: Padding(
              padding:
                  const EdgeInsets.all(30),

              child: Column(
                mainAxisSize:
                    MainAxisSize.min,

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Edit Category",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Category ID",
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                                12),
                      ),
                    ),
                    controller:
                        TextEditingController(
                      text: widget.category.id,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Category",
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                                12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller:
                        descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Description",
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                                12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SwitchListTile(
                    value: active,

                    activeColor:
                        const Color(0xFFD9AE63),

                    title: const Text(
                      "Active",
                    ),

                    onChanged: (value) {
                      setState(() {
                        active = value;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,

                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: const Text(
                          "Cancel",
                        ),
                      ),

                      const SizedBox(width: 15),

                      ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(
                                  0xFFD9AE63),

                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 16,
                          ),
                        ),

                        onPressed: () {
                          context
                              .read<
                                  CategoryProvider>()
                              .update(
                                CategoryModel(
                                  id:
                                      widget.category.id,
                                  name:
                                      nameController
                                          .text,
                                  description:
                                      descriptionController
                                          .text,
                                  active:
                                      active,
                                ),
                              );

                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Category updated successfully"),
                            ),
                          );

                          Navigator.pop(context);
                        },

                        child: const Text(
                          "Save Changes",
                          style: TextStyle(
                            color:
                                Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}