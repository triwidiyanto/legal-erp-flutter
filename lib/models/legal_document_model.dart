import 'dart:typed_data';

class LegalDocumentModel {

  final String id;

  final String title;

  final String description;

  final String vendor;

  final String category;

  final String status;

  final String priority;

  final String expiredDate;

  final String createdBy;

  final DateTime createdAt;

  /// Web / Mobile
  final String filePath;

  final String fileName;

  /// PDF Memory
  final Uint8List? pdfBytes;

  const LegalDocumentModel({

    required this.id,

    required this.title,

    required this.description,

    required this.vendor,

    required this.category,

    required this.status,

    required this.priority,

    required this.expiredDate,

    required this.createdBy,

    required this.createdAt,

    required this.filePath,

    required this.fileName,

    this.pdfBytes,
  });

  /// ===============================
  /// COPY WITH
  /// ===============================
  LegalDocumentModel copyWith({

    String? id,

    String? title,

    String? description,

    String? vendor,

    String? category,

    String? status,

    String? priority,

    String? expiredDate,

    String? createdBy,

    DateTime? createdAt,

    String? filePath,

    String? fileName,

    Uint8List? pdfBytes,
  }) {

    return LegalDocumentModel(

      id: id ?? this.id,

      title: title ?? this.title,

      description: description ?? this.description,

      vendor: vendor ?? this.vendor,

      category: category ?? this.category,

      status: status ?? this.status,

      priority: priority ?? this.priority,

      expiredDate: expiredDate ?? this.expiredDate,

      createdBy: createdBy ?? this.createdBy,

      createdAt: createdAt ?? this.createdAt,

      filePath: filePath ?? this.filePath,

      fileName: fileName ?? this.fileName,

      pdfBytes: pdfBytes ?? this.pdfBytes,
    );
  }
}