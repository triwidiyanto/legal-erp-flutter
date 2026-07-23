import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/legal_document_model.dart';
import '../../provider/category_provider.dart';
import '../../provider/legal_provider.dart';

class UploadDocumentPage extends StatefulWidget {
  const UploadDocumentPage({super.key});

  @override
  State<UploadDocumentPage> createState() =>
      _UploadDocumentPageState();
}

class _UploadDocumentPageState
    extends State<UploadDocumentPage> {

  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final vendorController =
      TextEditingController();

  final expiredDateController =
      TextEditingController();

  /// Dropdown
  String selectedPriority = 'Medium';

  String? selectedCategory;

  /// PDF
  PlatformFile? selectedFile;

  Uint8List? pdfBytes;

  bool isLoading = false;

  /// =========================
  /// PICK PDF
  /// =========================
  Future<void> pickPdf() async {

    final result =
        await FilePicker.platform.pickFiles(

      type: FileType.custom,

      allowedExtensions: ['pdf'],

      withData: true,
    );

    if (result != null) {

      setState(() {

        selectedFile =
            result.files.first;

        pdfBytes =
            result.files.first.bytes;
      });
    }
  }

  /// =========================
  /// PICK DATE
  /// =========================
  Future<void> pickDate() async {

    final pickedDate =
        await showDatePicker(

      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime(2020),

      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {

      expiredDateController.text =
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
    }
  }

  /// =========================
  /// UPLOAD DOCUMENT
  /// =========================
  Future<void> uploadDocument() async {

    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        vendorController.text.isEmpty ||
        selectedCategory == null ||
        expiredDateController.text.isEmpty ||
        selectedFile == null ||
        pdfBytes == null) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            'Please complete all fields',
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final provider =
          Provider.of<LegalProvider>(
        context,
        listen: false,
      );

      final id =
          'LGL-${DateTime.now().millisecondsSinceEpoch}';

      provider.addDocument(

        LegalDocumentModel(

          id: id,

          title: titleController.text,

          description:
              descriptionController.text,

          vendor:
              vendorController.text,

          category:
              selectedCategory!,

          status: 'Pending',

          priority:
              selectedPriority,

          expiredDate:
              expiredDateController.text,

          createdBy:
              'Administrator',

          createdAt:
              DateTime.now(),

          filePath: '',

          fileName:
              selectedFile!.name,

          pdfBytes:
              pdfBytes,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            'Upload success',
          ),
        ),
      );

      /// Reset Form
      titleController.clear();

      descriptionController.clear();

      vendorController.clear();

      expiredDateController.clear();

      setState(() {

        selectedPriority = 'Medium';

        selectedCategory = null;

        selectedFile = null;

        pdfBytes = null;

        isLoading = false;
      });

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(
            'Upload failed : $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
        final categoryProvider =
        context.watch<CategoryProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFD9AE63),
        elevation: 0,
        title: const Text(
          'Upload Legal Document',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 900,
            ),

            child: Card(
              elevation: 4,

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Padding(
                padding:
                    const EdgeInsets.all(24),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Text(
                      'Upload New Document',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Please complete all information before uploading the document.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextField(
                      controller: titleController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Document Title',
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller:
                          descriptionController,
                      maxLines: 3,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Description',
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller:
                          vendorController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Vendor',
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    DropdownButtonFormField<String>(
                      value: selectedCategory,

                      decoration:
                          const InputDecoration(
                        labelText: 'Category',
                        border:
                            OutlineInputBorder(),
                      ),

                      items: categoryProvider
                          .categories
                          .map(
                            (category) =>
                                DropdownMenuItem(
                              value:
                                  category.name,
                              child: Text(
                                category.name,
                              ),
                            ),
                          )
                          .toList(),

                      onChanged: (value) {
                        setState(() {
                          selectedCategory =
                              value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    DropdownButtonFormField<String>(
                      value: selectedPriority,

                      decoration:
                          const InputDecoration(
                        labelText: 'Priority',
                        border:
                            OutlineInputBorder(),
                      ),

                      items: const [

                        DropdownMenuItem(
                          value: 'Low',
                          child: Text('Low'),
                        ),

                        DropdownMenuItem(
                          value: 'Medium',
                          child: Text('Medium'),
                        ),

                        DropdownMenuItem(
                          value: 'High',
                          child: Text('High'),
                        ),
                      ],

                      onChanged: (value) {
                        setState(() {
                          selectedPriority =
                              value!;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller:
                          expiredDateController,
                      readOnly: true,

                      onTap: pickDate,

                      decoration:
                          const InputDecoration(
                        labelText:
                            'Expired Date',
                        border:
                            OutlineInputBorder(),

                        suffixIcon: Icon(
                          Icons.calendar_today,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'PDF Document',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),
                                        Card(
                      elevation: 2,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),

                      child: Padding(
                        padding:
                            const EdgeInsets.all(20),

                        child: Column(
                          children: [

                            SizedBox(
                              width: double.infinity,

                              child: ElevatedButton.icon(
                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(
                                    0xFFD9AE63,
                                  ),

                                  padding:
                                      const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),

                                onPressed: pickPdf,

                                icon: const Icon(
                                  Icons.picture_as_pdf,
                                ),

                                label: const Text(
                                  'Choose PDF',
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            if (selectedFile == null)

                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.all(
                                  40,
                                ),

                                decoration: BoxDecoration(
                                  color:
                                      Colors.grey.shade100,

                                  borderRadius:
                                      BorderRadius.circular(
                                    12,
                                  ),
                                ),

                                child: const Column(
                                  children: [

                                    Icon(
                                      Icons.picture_as_pdf,
                                      size: 60,
                                      color: Colors.grey,
                                    ),

                                    SizedBox(height: 15),

                                    Text(
                                      'No PDF Selected',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )

                            else

                              Container(
                                width: double.infinity,

                                padding:
                                    const EdgeInsets.all(
                                  20,
                                ),

                                decoration: BoxDecoration(
                                  color:
                                      Colors.green.shade50,

                                  borderRadius:
                                      BorderRadius.circular(
                                    12,
                                  ),

                                  border: Border.all(
                                    color:
                                        Colors.green,
                                  ),
                                ),

                                child: Row(
                                  children: [

                                    const Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.red,
                                      size: 40,
                                    ),

                                    const SizedBox(width: 15),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,

                                        children: [

                                          const Text(
                                            'Selected PDF',
                                            style: TextStyle(
                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 5),

                                          Text(
                                            selectedFile!.name,
                                            overflow:
                                                TextOverflow.ellipsis,
                                          ),

                                          const SizedBox(height: 5),

                                          Text(
                                            '${(selectedFile!.size / 1024).toStringAsFixed(2)} KB',
                                            style:
                                                const TextStyle(
                                              color:
                                                  Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            const SizedBox(height: 30),

                            SizedBox(
                              width: double.infinity,

                              height: 55,

                              child: ElevatedButton.icon(

                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(
                                    0xFFD9AE63,
                                  ),
                                ),

                                onPressed: isLoading
                                    ? null
                                    : uploadDocument,

                                icon: isLoading

                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,

                                        child:
                                            CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )

                                    : const Icon(
                                        Icons.cloud_upload,
                                      ),

                                label: Text(

                                  isLoading

                                      ? 'Uploading...'

                                      : 'Upload Document',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}