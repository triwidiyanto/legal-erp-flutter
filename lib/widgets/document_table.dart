import 'package:flutter/material.dart';
import '../services/legal_service.dart';

class LegalDocumentTable extends StatelessWidget {
  const LegalDocumentTable({super.key});

  @override
  Widget build(BuildContext context) {
    final documents = LegalService.getDocuments();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Document')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Priority')),
            DataColumn(label: Text('Expired')),
          ],
          rows: documents.map((doc) {
            return DataRow(
              cells: [
                DataCell(Text(doc.id)),
                DataCell(Text(doc.title)),
                DataCell(Text(doc.status)),
                DataCell(Text(doc.priority)),
                DataCell(Text(doc.expiredDate)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}