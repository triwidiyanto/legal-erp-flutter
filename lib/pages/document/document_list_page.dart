import 'package:flutter/material.dart';
import 'package:legal/pages/document/document_detail_page.dart';
import 'package:legal/pages/document/upload_document_page.dart';
import 'package:legal/provider/legal_provider.dart';
import 'package:provider/provider.dart';

class LegalDocumentListPage extends StatefulWidget {
  const LegalDocumentListPage({super.key});

  @override
  State<LegalDocumentListPage> createState() =>
      _LegalDocumentListPageState();
}

class _LegalDocumentListPageState
    extends State<LegalDocumentListPage> {
  final TextEditingController searchController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LegalProvider>();
    final documents = provider.documents;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFD9AE63),

        title: const Text(
          'Legal Document',
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
                      'Legal Documents',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      'Management legal document & contract',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFD9AE63),

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 16,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const UploadDocumentPage(),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),

                  label: const Text(
                    'Add Document',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// SEARCH
            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(18),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: TextField(
                controller: searchController,

                onChanged: (value) {
                  provider.searchDocument(
                    value,
                  );
                },

                decoration:
                    const InputDecoration(
                  border: InputBorder.none,

                  icon: Icon(Icons.search),

                  hintText:
                      'Search legal document...',
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// TABLE HEADER
            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),

              decoration: BoxDecoration(
                color: const Color(0xFFD9AE63),

                borderRadius:
                    BorderRadius.circular(20),
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

                  Expanded(
                    flex: 5,
                    child: Text(
                      'Document',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Text(
                      'Status',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Text(
                      'Priority',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Text(
                      'Expired',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        'Action',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// DOCUMENT LIST
            Expanded(
              child: documents.isEmpty

                  ? const Center(
                      child: Text(
                        'No legal document found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )

                  : ListView.builder(
                      itemCount:
                          documents.length,

                      itemBuilder:
                          (context, index) {

                        final doc =
                            documents[index];

                        return Container(
                          margin:
                              const EdgeInsets.only(
                            bottom: 16,
                          ),

                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),

                          decoration:
                              BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(
                                  0.04,
                                ),

                                blurRadius: 8,
                                offset:
                                    const Offset(
                                  0,
                                  4,
                                ),
                              ),
                            ],
                          ),

                          child: Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.center,

                            children: [

                             /// ID
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    doc.id,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),

                              /// TITLE
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text(
                                    doc.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              /// STATUS
                              Expanded(
                                flex: 3,

                                child: Align(
                                  alignment:
                                      Alignment.centerLeft,

                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),

                                    decoration:
                                        BoxDecoration(

                                      color:
                                          doc.status ==
                                                  'Approved'

                                              ? Colors
                                                  .green
                                                  .shade100

                                              : doc.status ==
                                                      'Rejected'

                                                  ? Colors
                                                      .red
                                                      .shade100

                                                  : Colors
                                                      .orange
                                                      .shade100,

                                      borderRadius:
                                          BorderRadius.circular(
                                        30,
                                      ),
                                    ),

                                    child: Text(
                                      doc.status,

                                      style:
                                          TextStyle(
                                        color:
                                            doc.status ==
                                                    'Approved'

                                                ? Colors
                                                    .green

                                                : doc.status ==
                                                        'Rejected'

                                                    ? Colors
                                                        .red

                                                    : Colors
                                                        .orange,

                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              /// PRIORITY
                              Expanded(
                                flex: 2,

                                child: Text(
                                  doc.priority,

                                  style:
                                      TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .bold,

                                    color:
                                        doc.priority ==
                                                'High'

                                            ? Colors.red

                                            : doc.priority ==
                                                    'Medium'

                                                ? Colors.orange

                                                : Colors.green,
                                  ),
                                ),
                              ),

                              /// EXPIRED DATE
                              Expanded(
                                flex: 3,

                                child: Text(
                                  doc.expiredDate,
                                ),
                              ),

                              /// ACTION
                              Expanded(
                                flex: 3,

                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,

                                  children: [

                                    /// DETAIL
                                    Expanded(
                                      child:
                                          ElevatedButton(
                                        style:
                                            ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(
                                            0xFFD9AE63,
                                          ),

                                          elevation: 0,

                                          padding:
                                              const EdgeInsets.symmetric(
                                            vertical:
                                                14,
                                          ),

                                          shape:
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),

                                        onPressed:
                                            () {
                                          Navigator.push(
                                            context,

                                            MaterialPageRoute(
                                              builder:
                                                  (_) =>
                                                      LegalDocumentDetailPage(
                                                document:
                                                    doc,
                                              ),
                                            ),
                                          );
                                        },

                                        child:
                                            const Text(
                                          'Detail',

                                          style:
                                              TextStyle(
                                            color:
                                                Colors
                                                    .white,

                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),

                                    /// DELETE
                                    Expanded(
                                      child:
                                          ElevatedButton(
                                        style:
                                            ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors
                                                  .red,

                                          elevation: 0,

                                          padding:
                                              const EdgeInsets.symmetric(
                                            vertical:
                                                14,
                                          ),

                                          shape:
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),

                                        onPressed:
                                            () {
                                          provider
                                              .deleteDocument(
                                            doc.id,
                                          );

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text(
                                                'Document deleted',
                                              ),
                                            ),
                                          );
                                        },

                                        child:
                                            const Icon(
                                          Icons.delete,
                                          color:
                                              Colors.white,
                                          size: 18,
                                        ),
                                      ),
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