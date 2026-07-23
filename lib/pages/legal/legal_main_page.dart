import 'package:flutter/material.dart';

import '../approval/legal_approval_page.dart';
import '../contract/expired_contract_page.dart';
import '../dashboard/dashboard_page.dart';
import '../document/document_list_page.dart';
import '../master/category/category_page.dart';
import '../notification/notification_page.dart';

class LegalMainPage extends StatefulWidget {
  const LegalMainPage({super.key});

  @override
  State<LegalMainPage> createState() => _LegalMainPageState();
}

class _LegalMainPageState extends State<LegalMainPage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    LegalDashboardPage(),
    CategoryPage(),
    LegalDocumentListPage(),
    LegalApprovalPage(),
    ExpiredContractPage(),
    NotificationPage(),
  ];

  final List<Map<String, dynamic>> menus = [
    {
      'title': 'Dashboard',
      'icon': Icons.dashboard,
    },
    {
      'title': 'Master Category',
      'icon': Icons.category,
    },
    {
      'title': 'Legal Document',
      'icon': Icons.description,
    },
    {
      'title': 'Approval',
      'icon': Icons.approval,
    },
    {
      'title': 'Expired Contract',
      'icon': Icons.warning_amber_rounded,
    },
    {
      'title': 'Notification',
      'icon': Icons.notifications,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      body: Row(
        children: [
          /// ==========================
          /// SIDEBAR
          /// ==========================
          Container(
            width: 270,
            color: const Color(0xFF1E293B),

            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),

                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xFFD9AE63),
                        child: Icon(
                          Icons.gavel,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),

                      SizedBox(width: 15),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LEGAL ERP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Management System",
                            style: TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(color: Colors.white24),

                Expanded(
                  child: ListView.builder(
                    itemCount: menus.length,

                    itemBuilder: (context, index) {
                      final menu = menus[index];
                      final selected = selectedIndex == index;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),

                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },

                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),

                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 16,
                            ),

                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xFFD9AE63)
                                  : Colors.transparent,

                              borderRadius: BorderRadius.circular(14),
                            ),

                            child: Row(
                              children: [
                                Icon(
                                  menu["icon"],
                                  color: Colors.white,
                                ),

                                const SizedBox(width: 16),

                                Expanded(
                                  child: Text(
                                    menu["title"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// FOOTER
                Container(
                  padding: const EdgeInsets.all(20),

                  child: Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: const Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xFFD9AE63),

                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          "Administrator",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Legal Department",
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// ==========================
          /// CONTENT
          /// ==========================
          Expanded(
            child: pages[selectedIndex],
          ),
        ],
      ),
    );
  }
}