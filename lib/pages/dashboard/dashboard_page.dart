import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/legal_provider.dart';

class LegalDashboardPage extends StatelessWidget {
  const LegalDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LegalProvider>();

    final notifications =
        provider.notifications.take(5).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

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
                      'Legal Dashboard',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Realtime legal management system',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(18),
                  ),

                  child: const Row(
                    children: [

                      Icon(
                        Icons.gavel,
                        size: 18,
                      ),

                      SizedBox(width: 10),

                      Text(
                        'Legal ERP',
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// SUMMARY CARD
            Wrap(
              spacing: 20,
              runSpacing: 20,

              children: [

                dashboardCard(
                  'Total Document',
                  provider.totalDocument
                      .toString(),
                  Icons.description,
                  Colors.blue,
                ),

                dashboardCard(
                  'Approved',
                  provider.approvedDocument
                      .toString(),
                  Icons.check_circle,
                  Colors.green,
                ),

                dashboardCard(
                  'Pending',
                  provider.pendingDocument
                      .toString(),
                  Icons.pending,
                  Colors.orange,
                ),

                dashboardCard(
                  'Rejected',
                  provider.rejectedDocument
                      .toString(),
                  Icons.cancel,
                  Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 30),

            LayoutBuilder(
              builder: (context, constraints) {

                final isMobile =
                    constraints.maxWidth < 1000;

                return isMobile

                    ? Column(
                        children: [

                          leftContent(
                            provider,
                            notifications,
                          ),

                          const SizedBox(height: 24),

                          rightContent(
                            provider,
                          ),
                        ],
                      )

                    : Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Expanded(
                            flex: 2,

                            child: leftContent(
                              provider,
                              notifications,
                            ),
                          ),

                          const SizedBox(width: 24),

                          Expanded(
                            child: rightContent(
                              provider,
                            ),
                          ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget leftContent(
    LegalProvider provider,
    dynamic notifications,
  ) {

    return Column(
      children: [

        /// RECENT ACTIVITY
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(24),
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              notifications.isEmpty

                  ? const Center(
                      child: Padding(
                        padding:
                            EdgeInsets.all(20),
                        child: Text(
                          'No activity yet',
                        ),
                      ),
                    )

                  : Column(
                      children:
                          notifications.map<Widget>(
                        (item) {

                          return activityItem(
                            item.type ==
                                    'success'

                                ? Icons.check_circle

                                : item.type ==
                                        'danger'

                                    ? Icons.warning

                                    : Icons.notifications,

                            item.type ==
                                    'success'

                                ? Colors.green

                                : item.type ==
                                        'danger'

                                    ? Colors.red

                                    : Colors.blue,

                            item.title,
                            item.time,
                          );
                        },
                      ).toList(),
                    ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        /// DOCUMENT STATUS
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(24),
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                'Document Status',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              statusProgress(
                'Approved',
                provider.approvedDocument,
                provider.totalDocument,
                Colors.green,
              ),

              const SizedBox(height: 20),

              statusProgress(
                'Pending',
                provider.pendingDocument,
                provider.totalDocument,
                Colors.orange,
              ),

              const SizedBox(height: 20),

              statusProgress(
                'Rejected',
                provider.rejectedDocument,
                provider.totalDocument,
                Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget rightContent(
    LegalProvider provider,
  ) {

    return Column(
      children: [

        /// QUICK MENU
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(24),
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                'Quick Menu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              quickMenu(
                Icons.upload_file,
                'Upload Document',
              ),

              quickMenu(
                Icons.approval,
                'Approval Workflow',
              ),

              quickMenu(
                Icons.warning,
                'Expired Contract',
              ),

              quickMenu(
                Icons.notifications,
                'Notification Center',
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        /// SUMMARY
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(24),
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(
                'Legal Summary',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              summaryRow(
                'Active Contract',
                provider.approvedDocument
                    .toString(),
              ),

              summaryRow(
                'Pending Approval',
                provider.pendingDocument
                    .toString(),
              ),

              summaryRow(
                'Rejected Document',
                provider.rejectedDocument
                    .toString(),
              ),

              summaryRow(
                'Total Document',
                provider.totalDocument
                    .toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget dashboardCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {

    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 28,
            backgroundColor:
                color.withOpacity(0.15),

            child: Icon(
              icon,
              color: color,
              size: 28,
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
    );
  }

  Widget activityItem(
    IconData icon,
    Color color,
    String title,
    String time,
  ) {

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 20),

      child: Row(
        children: [

          CircleAvatar(
            backgroundColor:
                color.withOpacity(0.15),

            child: Icon(
              icon,
              color: color,
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
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget statusProgress(
    String title,
    int value,
    int total,
    Color color,
  ) {

    double progress = 0;

    if (total > 0) {
      progress = value / total;
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

          children: [

            Text(title),

            Text('$value / $total'),
          ],
        ),

        const SizedBox(height: 10),

        LinearProgressIndicator(
          value: progress,
          color: color,
          minHeight: 10,
          borderRadius:
              BorderRadius.circular(20),
        ),
      ],
    );
  }

  Widget quickMenu(
    IconData icon,
    String title,
  ) {

    return Container(
      margin:
          const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Row(
        children: [

          Icon(icon),

          const SizedBox(width: 16),

          Text(
            title,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget summaryRow(
    String title,
    String value,
  ) {

    return Padding(
      padding:
          const EdgeInsets.only(bottom: 18),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}