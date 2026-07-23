import 'package:legal/utils/download_helper_stub.dart'
    if (dart.library.html) 'package:legal/utils/download_helper_web.dart'
    if (dart.library.io) 'package:legal/utils/download_helper_io.dart';

import 'package:flutter/material.dart';
import 'package:legal/models/legal_document_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LegalDocumentDetailPage extends StatelessWidget {
  final LegalDocumentModel document;

  const LegalDocumentDetailPage({
    super.key,
    required this.document,
  });

  Future<void> downloadPdf(BuildContext context) async {
    if (document.pdfBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF tidak tersedia'),
        ),
      );
      return;
    }

    downloadFile(
      document.pdfBytes!,
      document.fileName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFD9AE63),
        elevation: 0,

        title: Text(
          document.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => downloadPdf(context),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// DETAIL DOCUMENT
            Card(
              elevation: 3,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                    detailItem("ID", document.id),
                    detailItem("Title", document.title),
                    detailItem("Vendor", document.vendor),
                    detailItem("Category", document.category),
                    detailItem("Priority", document.priority),
                    detailItem("Status", document.status),
                    detailItem("Expired Date", document.expiredDate),
                    detailItem("PDF File", document.fileName),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// PDF PREVIEW
            Expanded(
              child: Card(
                elevation: 3,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),

                      decoration: const BoxDecoration(
                        color: Color(0xFFD9AE63),

                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),

                      child: const Row(
                        children: [

                          Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          ),

                          SizedBox(width: 10),

                          Text(
                            'PDF Preview',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),

                    Expanded(
                      child: document.pdfBytes == null

                          ? const Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [

                                  Icon(
                                    Icons.picture_as_pdf,
                                    size: 80,
                                    color: Colors.grey,
                                  ),

                                  SizedBox(height: 20),

                                  Text(
                                    'PDF tidak tersedia',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),

                                ],
                              ),
                            )

                          : SfPdfViewer.memory(
                              document.pdfBytes!,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailItem(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          SizedBox(
            width: 130,

            child: Text(
              title,

              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Text(": "),

          Expanded(
            child: Text(value),
          ),

        ],
      ),
    );
  }
}