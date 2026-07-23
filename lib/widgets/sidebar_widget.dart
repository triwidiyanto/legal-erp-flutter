import 'package:flutter/material.dart';

class LegalSidebarWidget extends StatelessWidget {
  final Function(int) onSelected;
  final int selectedIndex;

  const LegalSidebarWidget({
    super.key,
    required this.onSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final menus = [
      'Dashboard',
      'Legal Document',
      'Approval Legal',
      'Upload Document',
      'Expired Contract',
    ];
    final icons = [
      Icons.dashboard,
      Icons.description,
      Icons.approval,
      Icons.upload_file,
      Icons.warning,
    ];
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFD9AE63),
            Color(0xFFC89A4B),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
       child: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'LEGAL',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
           const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final selected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => onSelected(index),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: selected
                            ? Colors.black.withOpacity(0.2)
                            : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            icons[index],
                            color: Colors.white,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            menus[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
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
        ],
      ),
    );
  }
}