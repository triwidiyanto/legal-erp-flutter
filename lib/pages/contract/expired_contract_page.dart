import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/legal_provider.dart';
import '../document/document_detail_page.dart';

class ExpiredContractPage extends StatelessWidget {
  const ExpiredContractPage({super.key});

  /// ==========================
  /// HITUNG SISA HARI REALTIME
  /// ==========================
  int getRemainingDays(String expiredDate) {
    try {
      final split = expiredDate.split('/');

      final expired = DateTime(
        int.parse(split[2]),
        int.parse(split[1]),
        int.parse(split[0]),
      );

      final now = DateTime.now();

      final today = DateTime(
        now.year,
        now.month,
        now.day,
      );

      return expired.difference(today).inDays;
    } catch (e) {
      return 0;
    }
  }

  Color priorityColor(String priority) {
    switch (priority) {
      case "High":
        return Colors.red;

      case "Medium":
        return Colors.orange;

      default:
        return Colors.green;
    }
  }

  Color statusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;

      case "Rejected":
        return Colors.red;

      default:
        return Colors.orange;
    }
  }

  Color remainingColor(int day) {
    if (day < 0) {
      return Colors.red;
    }

    if (day <= 30) {
      return Colors.orange;
    }

    return Colors.green;
  }

  String remainingText(int day) {
    if (day < 0) {
      return "${day.abs()} Days Ago";
    }

    return "$day Days";
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<LegalProvider>();

    final documents =
        provider.documents;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F6FA),

      appBar: AppBar(
        elevation: 0,

        backgroundColor:
            const Color(0xFFD9AE63),

        title: const Text(
          "Expired Contract",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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

            /// =========================
            /// HEADER
            /// =========================

            const Text(
              "Contract Monitoring",

              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Realtime contract monitoring system",

              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            /// =========================
            /// SUMMARY
            /// =========================

            Wrap(
              spacing: 20,
              runSpacing: 20,

              children: [

                summaryCard(
                  "Total Contract",
                  provider.totalDocument.toString(),
                  Colors.blue,
                  Icons.description,
                ),

                summaryCard(
                  "Approved",
                  provider.approvedDocument.toString(),
                  Colors.green,
                  Icons.check_circle,
                ),

                summaryCard(
                  "Pending",
                  provider.pendingDocument.toString(),
                  Colors.orange,
                  Icons.pending,
                ),

                summaryCard(
                  "Rejected",
                  provider.rejectedDocument.toString(),
                  Colors.red,
                  Icons.cancel,
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// =========================
            /// TABLE HEADER
            /// =========================
                        Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xFFD9AE63),
                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: const Row(
                children: [

                  Expanded(
                    flex: 2,
                    child: Text(
                      "ID",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    flex: 5,
                    child: Text(
                      "Contract",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    flex: 2,
                    child: Text(
                      "Priority",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    flex: 3,
                    child: Text(
                      "Expired Date",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    flex: 2,
                    child: Text(
                      "Remaining",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    flex: 3,
                    child: Text(
                      "Status",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(width: 15),

                  Expanded(
                    flex: 2,
                    child: Text(
                      "Action",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: documents.isEmpty

                  ? const Center(
                      child: Text(
                        "No Contract Available",
                      ),
                    )

                  : ListView.builder(

                      itemCount:
                          documents.length,

                      itemBuilder:
                          (context, index) {

                        final doc =
                            documents[index];

                        final remaining =
                            getRemainingDays(
                          doc.expiredDate,
                        );

                        return Container(

                          margin:
                              const EdgeInsets.only(
                            bottom: 14,
                          ),

                          padding:
                              const EdgeInsets.all(
                            18,
                          ),

                          decoration:
                              BoxDecoration(

                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),

                            boxShadow: [

                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(
                                  0.04,
                                ),
                                blurRadius: 8,
                              ),
                            ],
                          ),

                          child: Row(
                            children: [
                              /// =========================
              /// ID
              /// =========================

              Expanded(
                flex: 2,
                child: Text(
                  doc.id,
                ),
              ),

              const SizedBox(width: 15),

              /// =========================
              /// CONTRACT
              /// =========================

              Expanded(
                flex: 5,
                child: Text(
                  doc.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 15),

              /// =========================
              /// PRIORITY
              /// =========================

              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor(
                      doc.priority,
                    ).withOpacity(0.15),
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                  child: Text(
                    doc.priority,
                    style: TextStyle(
                      color: priorityColor(
                        doc.priority,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              /// =========================
              /// EXPIRED DATE
              /// =========================

              Expanded(
                flex: 3,
                child: Text(
                  doc.expiredDate,
                ),
              ),

              const SizedBox(width: 15),

              /// =========================
              /// REMAINING DAYS
              /// =========================

              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: remainingColor(
                      remaining,
                    ).withOpacity(0.15),
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                  child: Text(
                    remainingText(
                      remaining,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: remainingColor(
                        remaining,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              /// =========================
              /// STATUS
              /// =========================

              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor(
                      doc.status,
                    ).withOpacity(0.15),
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                  child: Text(
                    doc.status,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: statusColor(
                        doc.status,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              /// =========================
              /// ACTION
              /// =========================

              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFD9AE63),
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
                            LegalDocumentDetailPage(
                          document: doc,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Detail",
                  ),
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

  /// =========================
  /// SUMMARY CARD
  /// =========================

  Widget summaryCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.05,
            ),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 26,
            backgroundColor:
                color.withOpacity(0.15),

            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}