import 'dart:convert';

class Pagination {
  Pagination({
    required this.xPaginatedBy,
    required this.xPaginationCount,
    required this.xPaginationCurrent,
  });

  final int xPaginatedBy;
  final int xPaginationCount;
  final int xPaginationCurrent;

  Map<String, dynamic> toMap() {
    return {
      'x-paginated-by': xPaginatedBy,
      'x-pagination-count': xPaginationCount,
      'x-pagination-current': xPaginationCurrent,
    };
  }

  factory Pagination.fromMap(Map<String, dynamic> map) {
    return Pagination(
      xPaginatedBy: int.parse(map['x-paginated-by']?.toString() ?? '0'),
      xPaginationCount: int.parse(map['x-pagination-count']?.toString() ?? '0'),
      xPaginationCurrent:
          int.parse(map['x-pagination-current']?.toString() ?? '0'),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pagination.fromJson(String source) =>
      Pagination.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pagination &&
        other.xPaginatedBy == xPaginatedBy &&
        other.xPaginationCount == xPaginationCount &&
        other.xPaginationCurrent == xPaginationCurrent;
  }

  @override
  int get hashCode {
    return xPaginatedBy.hashCode ^
        xPaginationCount.hashCode ^
        xPaginationCurrent.hashCode;
  }
}
