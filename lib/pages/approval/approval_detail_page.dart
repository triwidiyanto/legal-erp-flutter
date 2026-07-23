import 'package:flutter/material.dart';

class ApprovalDetailPage extends StatefulWidget {

  const ApprovalDetailPage({
    super.key,
  });

  @override
  State<ApprovalDetailPage> createState() =>
      _ApprovalDetailPageState();
}

class _ApprovalDetailPageState
    extends State<ApprovalDetailPage> {

  final notesController =
      TextEditingController();

  String approvalStatus = 'Pending';

  void approveDocument() {

    setState(() {
      approvalStatus = 'Approved';
    });

    showMessage(
      'Document approved successfully',
    );
  }

  void rejectDocument() {

    if (notesController.text.isEmpty) {

      showMessage(
        'Rejection reason required',
      );

      return;
    }

    setState(() {
      approvalStatus = 'Rejected';
    });

    showMessage(
      'Document rejected',
    );
  }

  void showMessage(String message) {

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F6FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            const Color(0xFFD9AE63),

        title: const Text(
          'Approval Detail',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            /// DOCUMENT INFO
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(28),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const Text(
                    'Vendor Agreement PT Maju Jaya',

                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  detailRow(
                    'Document ID',
                    'LGL-001',
                  ),

                  detailRow(
                    'Category',
                    'Vendor Agreement',
                  ),

                  detailRow(
                    'Priority',
                    'High',
                  ),

                  detailRow(
                    'Status',
                    approvalStatus,
                  ),

                  detailRow(
                    'Created By',
                    'Administrator',
                  ),

                  detailRow(
                    'Created Date',
                    '20 Mei 2026',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// APPROVAL NOTES
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(28),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const Text(
                    'Approval Notes',

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller:
                        notesController,

                    maxLines: 6,

                    decoration:
                        InputDecoration(
                      hintText:
                          'Input approval/rejection notes',

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// APPROVAL HISTORY
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(28),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const Text(
                    'Approval History',

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 24),

                  historyItem(
                    'Legal Staff',
                    'Review Document',
                    '20 Mei 2026',
                  ),

                  historyItem(
                    'Manager Legal',
                    'Waiting Approval',
                    '21 Mei 2026',
                  ),

                  historyItem(
                    'Director',
                    approvalStatus,
                    '22 Mei 2026',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// ACTION BUTTON
            Row(
              children: [

                Expanded(
                  child:
                      ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green,

                      padding:
                          const EdgeInsets.all(
                        20,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),
                    ),

                    onPressed:
                        approveDocument,

                    icon: const Icon(
                      Icons.check,
                    ),

                    label: const Text(
                      'APPROVE',
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                Expanded(
                  child:
                      ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.red,

                      padding:
                          const EdgeInsets.all(
                        20,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),
                    ),

                    onPressed:
                        rejectDocument,

                    icon: const Icon(
                      Icons.close,
                    ),

                    label: const Text(
                      'REJECT',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget detailRow(
    String title,
    String value,
  ) {

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 18),

      child: Row(
        children: [

          SizedBox(
            width: 180,

            child: Text(
              title,

              style: const TextStyle(
                fontWeight:
                    FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,

              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget historyItem(
    String user,
    String status,
    String date,
  ) {

    return Container(
      margin:
          const EdgeInsets.only(bottom: 18),

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,

        borderRadius:
            BorderRadius.circular(16),
      ),

      child: Row(
        children: [

          CircleAvatar(
            backgroundColor:
                const Color(0xFFD9AE63),

            child: Text(
              user[0],
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(
                  user,

                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(status),
              ],
            ),
          ),

          Text(
            date,

            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}