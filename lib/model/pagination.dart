import 'dart:convert';

class Pagination {
  Pagination({
    required this.xPaginated,
    required this.xPaginatedBy,
    required this.xPaginatedCount,
    required this.xPaginatedCurrent,
  });

  final bool xPaginated;
  final int xPaginatedBy;
  final int xPaginatedCount;
  final int xPaginatedCurrent;

  Map<String, dynamic> toMap() {
    return {
      'x-paginated': xPaginated,
      'x-paginated-by': xPaginatedBy,
      'x-paginated-count': xPaginatedCount,
      'x-paginated-current': xPaginatedCurrent,
    };
  }

  factory Pagination.fromMap(Map<String, dynamic> map) {
    return Pagination(
      xPaginated: map['x-paginated'] ?? false,
      xPaginatedBy: map['x-paginated-by']?.toInt() ?? 0,
      xPaginatedCount: map['x-paginated-count']?.toInt() ?? 0,
      xPaginatedCurrent: map['x-paginated-current']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pagination.fromJson(String source) =>
      Pagination.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pagination &&
        other.xPaginated == xPaginated &&
        other.xPaginatedBy == xPaginatedBy &&
        other.xPaginatedCount == xPaginatedCount &&
        other.xPaginatedCurrent == xPaginatedCurrent;
  }

  @override
  int get hashCode {
    return xPaginated.hashCode ^
        xPaginatedBy.hashCode ^
        xPaginatedCount.hashCode ^
        xPaginatedCurrent.hashCode;
  }
}
