import 'package:flutter/material.dart';

import '../models/legal_document_model.dart';
import '../models/legal_notification_model.dart';

class LegalProvider extends ChangeNotifier {

  /// ==========================================
  /// DOCUMENT
  /// ==========================================

  final List<LegalDocumentModel> _documents = [];

  List<LegalDocumentModel> _filteredDocuments = [];

  /// ==========================================
  /// NOTIFICATION
  /// ==========================================

  final List<LegalNotificationModel> _notifications = [];

  /// ==========================================
  /// LOADING
  /// ==========================================

  bool isLoading = false;

  /// ==========================================
  /// CONSTRUCTOR
  /// ==========================================

  LegalProvider() {
    _filteredDocuments = List.from(_documents);
  }

  /// ==========================================
  /// GETTER
  /// ==========================================

  List<LegalDocumentModel> get documents =>
      _filteredDocuments;

  List<LegalNotificationModel> get notifications =>
      _notifications;

  /// ==========================================
  /// DASHBOARD
  /// ==========================================

  int get totalDocument =>
      _documents.length;

  int get approvedDocument =>
      _documents
          .where(
            (e) =>
                e.status == 'Approved',
          )
          .length;

  int get pendingDocument =>
      _documents
          .where(
            (e) =>
                e.status == 'Pending' ||
                e.status == 'Review',
          )
          .length;

  int get rejectedDocument =>
      _documents
          .where(
            (e) =>
                e.status == 'Rejected',
          )
          .length;

  /// ==========================================
  /// EXPIRED REALTIME
  /// ==========================================

  int get expiredDocument {

    final today = DateTime.now();

    return _documents.where((doc) {

      try {

        final split =
            doc.expiredDate.split('/');

        final expiredDate =
            DateTime(

          int.parse(split[2]),

          int.parse(split[1]),

          int.parse(split[0]),
        );

        return expiredDate.isBefore(

          DateTime(
            today.year,
            today.month,
            today.day,
          ),
        );

      } catch (_) {

        return false;
      }

    }).length;
  }

  /// ==========================================
  /// EXPIRE TODAY
  /// ==========================================

  int get expireToday {

    final today = DateTime.now();

    return _documents.where((doc) {

      try {

        final split =
            doc.expiredDate.split('/');

        final date =
            DateTime(

          int.parse(split[2]),

          int.parse(split[1]),

          int.parse(split[0]),
        );

        return date.year ==
                today.year &&
            date.month ==
                today.month &&
            date.day ==
                today.day;

      } catch (_) {

        return false;
      }

    }).length;
  }

  /// ==========================================
  /// EXPIRE 7 DAYS
  /// ==========================================

  int get expire7Days {

    final today = DateTime.now();

    return _documents.where((doc) {

      try {

        final split =
            doc.expiredDate.split('/');

        final date =
            DateTime(

          int.parse(split[2]),

          int.parse(split[1]),

          int.parse(split[0]),
        );

        final diff =
            date
                .difference(today)
                .inDays;

        return diff >= 0 &&
            diff <= 7;

      } catch (_) {

        return false;
      }

    }).length;
  }

  /// ==========================================
  /// EXPIRE 30 DAYS
  /// ==========================================

  int get expire30Days {

    final today = DateTime.now();

    return _documents.where((doc) {

      try {

        final split =
            doc.expiredDate.split('/');

        final date =
            DateTime(

          int.parse(split[2]),

          int.parse(split[1]),

          int.parse(split[0]),
        );

        final diff =
            date
                .difference(today)
                .inDays;

        return diff >= 0 &&
            diff <= 30;

      } catch (_) {

        return false;
      }

    }).length;
  }

  /// ==========================================
  /// LOAD DOCUMENT
  /// ==========================================

  Future<void> loadDocuments()
  async {

    isLoading = true;

    notifyListeners();

    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );

    _filteredDocuments =
        List.from(_documents);

    isLoading = false;

    notifyListeners();
  }
    /// ==========================================
  /// ADD DOCUMENT
  /// ==========================================

  void addDocument(
    LegalDocumentModel document,
  ) {

    _documents.insert(
      0,
      document,
    );

    _filteredDocuments =
        List.from(_documents);

    _notifications.insert(

      0,

      LegalNotificationModel(

        title: 'New Document',

        message:
            '${document.title} uploaded successfully.',

        time: 'Just now',

        type: 'info',
      ),
    );

    notifyListeners();
  }

  /// ==========================================
  /// UPDATE DOCUMENT
  /// ==========================================

  void updateDocument(
    LegalDocumentModel document,
  ) {

    final index =
        _documents.indexWhere(
      (e) => e.id == document.id,
    );

    if (index == -1) return;

    _documents[index] = document;

    _filteredDocuments =
        List.from(_documents);

    _notifications.insert(

      0,

      LegalNotificationModel(

        title: 'Document Updated',

        message:
            '${document.title} updated successfully.',

        time: 'Just now',

        type: 'info',
      ),
    );

    notifyListeners();
  }

  /// ==========================================
  /// APPROVE DOCUMENT
  /// ==========================================

  void approveDocument(
    String id,
  ) {

    final index =
        _documents.indexWhere(
      (e) => e.id == id,
    );

    if (index == -1) return;

    final doc =
        _documents[index];

    _documents[index] =
        doc.copyWith(
      status: 'Approved',
    );

    _filteredDocuments =
        List.from(_documents);

    _notifications.insert(

      0,

      LegalNotificationModel(

        title: 'Document Approved',

        message:
            '${doc.title} has been approved.',

        time: 'Just now',

        type: 'success',
      ),
    );

    notifyListeners();
  }
    /// ==========================================
  /// REJECT DOCUMENT
  /// ==========================================

  void rejectDocument(
    String id,
  ) {

    final index =
        _documents.indexWhere(
      (e) => e.id == id,
    );

    if (index == -1) return;

    final doc =
        _documents[index];

    _documents[index] =
        doc.copyWith(
      status: 'Rejected',
    );

    _filteredDocuments =
        List.from(_documents);

    _notifications.insert(

      0,

      LegalNotificationModel(

        title: 'Document Rejected',

        message:
            '${doc.title} has been rejected.',

        time: 'Just now',

        type: 'danger',
      ),
    );

    notifyListeners();
  }

  /// ==========================================
  /// DELETE DOCUMENT
  /// ==========================================

  void deleteDocument(
    String id,
  ) {

    final index =
        _documents.indexWhere(
      (e) => e.id == id,
    );

    if (index == -1) return;

    final doc =
        _documents[index];

    _documents.removeAt(index);

    _filteredDocuments =
        List.from(_documents);

    _notifications.insert(

      0,

      LegalNotificationModel(

        title: 'Document Deleted',

        message:
            '${doc.title} has been deleted.',

        time: 'Just now',

        type: 'danger',
      ),
    );

    notifyListeners();
  }

  /// ==========================================
  /// SEARCH DOCUMENT
  /// ==========================================

  void searchDocument(
    String keyword,
  ) {

    if (keyword.trim().isEmpty) {

      _filteredDocuments =
          List.from(_documents);

    } else {

      final search =
          keyword.toLowerCase();

      _filteredDocuments =
          _documents.where((doc) {

        return

            doc.id
                .toLowerCase()
                .contains(search) ||

            doc.title
                .toLowerCase()
                .contains(search) ||

            doc.vendor
                .toLowerCase()
                .contains(search) ||

            doc.category
                .toLowerCase()
                .contains(search) ||

            doc.priority
                .toLowerCase()
                .contains(search) ||

            doc.status
                .toLowerCase()
                .contains(search);

      }).toList();
    }

    notifyListeners();
  }
}