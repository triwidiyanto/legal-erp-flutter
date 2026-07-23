import 'package:flutter/material.dart';
import 'package:legal/provider/legal_provider.dart';
import 'package:provider/provider.dart';


class NotificationPage
    extends StatelessWidget {

  const NotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<LegalProvider>();

    final notifications =
        provider.notifications;

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F6FA),

      appBar: AppBar(

        backgroundColor:
            const Color(0xFFD9AE63),

        title: const Text(
          'Legal Notification',
        ),

        actions: [

          TextButton.icon(

            onPressed: () {

              for (var item
                  in notifications) {

                item.isRead = true;
              }

              provider.notifyListeners();
            },

            icon: const Icon(
              Icons.done_all,
              color: Colors.white,
            ),

            label: const Text(

              'Mark All Read',

              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(
          24,
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            /// HEADER
            const Text(

              'Notification Center',

              style: TextStyle(
                fontSize: 36,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(

              'Monitor legal system activities & alerts',

              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            /// STATS
            Row(

              children: [

                buildStatCard(
                  Icons.notifications,
                  Colors.blue,
                  'Total',
                  notifications
                      .length
                      .toString(),
                ),

                const SizedBox(width: 20),

                buildStatCard(
                  Icons.mark_email_unread,
                  Colors.orange,
                  'Unread',
                  notifications
                      .where(
                        (e) =>
                            !e.isRead,
                      )
                      .length
                      .toString(),
                ),

                const SizedBox(width: 20),

                buildStatCard(
                  Icons.warning,
                  Colors.red,
                  'Critical',
                  notifications
                      .where(
                        (e) =>
                            e.type ==
                            'danger',
                      )
                      .length
                      .toString(),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// LIST
            Expanded(

              child:
                  notifications.isEmpty

                      ? const Center(

                          child: Text(
                            'No notification',
                          ),
                        )

                      : ListView.builder(

                          itemCount:
                              notifications
                                  .length,

                          itemBuilder:
                              (
                                context,
                                index,
                              ) {

                            final item =
                                notifications[
                                    index];

                            return Container(

                              margin:
                                  const EdgeInsets.only(
                                bottom: 18,
                              ),

                              padding:
                                  const EdgeInsets.all(
                                20,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white,

                                borderRadius:
                                    BorderRadius.circular(
                                  24,
                                ),

                                boxShadow: [

                                  BoxShadow(
                                    color: Colors
                                        .black
                                        .withOpacity(
                                      0.04,
                                    ),

                                    blurRadius:
                                        10,
                                  ),
                                ],
                              ),

                              child: Row(

                                children: [

                                  /// ICON
                                  Container(

                                    width: 60,
                                    height: 60,

                                    decoration:
                                        BoxDecoration(

                                      color:
                                          getColor(
                                        item.type,
                                      ).withOpacity(
                                        0.15,
                                      ),

                                      shape:
                                          BoxShape.circle,
                                    ),

                                    child: Icon(

                                      getIcon(
                                        item.type,
                                      ),

                                      color:
                                          getColor(
                                        item.type,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 20,
                                  ),

                                  /// TEXT
                                  Expanded(

                                    child:
                                        Column(

                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [

                                        Text(

                                          item.title,

                                          style:
                                              const TextStyle(

                                            fontSize:
                                                18,

                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 5,
                                        ),

                                        Text(

                                          item.message,

                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.grey,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 8,
                                        ),

                                        Text(

                                          item.time,

                                          style:
                                              TextStyle(

                                            color:
                                                getColor(
                                              item.type,
                                            ),

                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// STATUS
                                  if (!item.isRead)

                                    Container(

                                      width: 12,
                                      height: 12,

                                      decoration:
                                          const BoxDecoration(

                                        color:
                                            Colors.red,

                                        shape:
                                            BoxShape.circle,
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

  /// ICON
  IconData getIcon(
    String type,
  ) {

    switch (type) {

      case 'success':
        return Icons.check_circle;

      case 'danger':
        return Icons.warning;

      default:
        return Icons.info;
    }
  }

  /// COLOR
  Color getColor(
    String type,
  ) {

    switch (type) {

      case 'success':
        return Colors.green;

      case 'danger':
        return Colors.red;

      default:
        return Colors.blue;
    }
  }

  /// CARD
  Widget buildStatCard(

    IconData icon,
    Color color,
    String title,
    String value,
  ) {

    return Expanded(

      child: Container(

        padding:
            const EdgeInsets.all(
          24,
        ),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            24,
          ),
        ),

        child: Row(

          children: [

            Container(

              width: 60,
              height: 60,

              decoration: BoxDecoration(

                color:
                    color.withOpacity(
                  0.15,
                ),

                shape:
                    BoxShape.circle,
              ),

              child: Icon(
                icon,
                color: color,
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

                const SizedBox(height: 5),

                Text(

                  value,

                  style: const TextStyle(
                    fontSize: 30,
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