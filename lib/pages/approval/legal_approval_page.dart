import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/legal_provider.dart';
import '../legal_document/legal_document_detail_page.dart';

class LegalApprovalPage
    extends StatelessWidget {

  const LegalApprovalPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<LegalProvider>();

    final documents =
        provider.documents;

    final pendingDocuments =
        documents.where((e) {

      return e.status == 'Pending' ||
          e.status == 'Review';

    }).toList();

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F6FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            const Color(0xFFD9AE63),

        title: const Text(
          'Approval Legal',

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            /// HEADER
            const Text(
              'Legal Approval Workflow',

              style: TextStyle(
                fontSize: 32,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Approve or reject legal documents',

              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            /// SUMMARY
            Row(
              children: [

                summaryCard(
                  'Pending',
                  pendingDocuments.length
                      .toString(),
                  Colors.orange,
                  Icons.pending,
                ),

                const SizedBox(width: 20),

                summaryCard(
                  'Approved',
                  provider
                      .approvedDocument
                      .toString(),
                  Colors.green,
                  Icons.check_circle,
                ),

                const SizedBox(width: 20),

                summaryCard(
                  'Rejected',
                  provider
                      .rejectedDocument
                      .toString(),
                  Colors.red,
                  Icons.cancel,
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// TABLE HEADER
            Container(
              padding:
                  const EdgeInsets.all(
                18,
              ),

              decoration: BoxDecoration(
                color:
                    const Color(
                  0xFFD9AE63,
                ),

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),

              child: const Row(
                children: [

                  Expanded(
                    flex: 2,
                    child: Text(
                      'ID',

                      style: TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 5,
                    child: Text(
                      'Document',

                      style: TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Text(
                      'Priority',

                      style: TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Text(
                      'Status',

                      style: TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 5,
                    child: Text(
                      'Action',

                      style: TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// LIST
            /// LIST
Expanded(
  child: pendingDocuments.isEmpty

      ? const Center(
          child: Text(
            'No pending approval',
          ),
        )

      : ListView.builder(
          itemCount: pendingDocuments.length,

          itemBuilder: (
            context,
            index,
          ) {

            final doc =
                pendingDocuments[index];

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

                    blurRadius: 10,
                    offset:
                        const Offset(0, 4),
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

                    child: Text(
                      doc.id,

                      maxLines: 2,
                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  /// DOCUMENT
                  Expanded(
                    flex: 4,

                    child: Text(
                      doc.title,

                      maxLines: 2,
                      overflow:
                          TextOverflow
                              .ellipsis,

                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  /// PRIORITY
                  Expanded(
                    flex: 2,

                    child: Text(
                      doc.priority,

                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,

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

                  const SizedBox(width: 20),

                  /// STATUS
                  Expanded(
                    flex: 3,

                    child: Center(
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),

                        decoration:
                            BoxDecoration(
                          color: Colors
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
                              const TextStyle(
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  /// ACTION
                  Expanded(
                    flex: 5,

                    child: Row(
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

                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 14,
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
                                    Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        /// APPROVE
                        Expanded(
                          child:
                              ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.green,

                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 14,
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
                                  .approveDocument(
                                doc.id,
                              );

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(
                                    '${doc.title} approved',
                                  ),
                                ),
                              );
                            },

                            child:
                                const Icon(
                              Icons.check,
                              color:
                                  Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        /// REJECT
                        Expanded(
                          child:
                              ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.red,

                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 14,
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
                                  .rejectDocument(
                                doc.id,
                              );

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(
                                    '${doc.title} rejected',
                                  ),
                                ),
                              );
                            },

                            child:
                                const Icon(
                              Icons.close,
                              color:
                                  Colors.white,
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

  Widget summaryCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {

    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.all(24),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            24,
          ),
        ),

        child: Row(
          children: [

            CircleAvatar(
              radius: 30,
              backgroundColor:
                  color.withOpacity(
                0.15,
              ),

              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),

            const SizedBox(width: 20),

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}