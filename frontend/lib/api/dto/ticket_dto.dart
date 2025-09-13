class TicketDto {
  final String prize;       
  final String expirationAt;
  final String storeName;
  final double latitude;
  final double longitude;

  TicketDto({
    required this.prize,
    required this.expirationAt,
    required this.storeName,
    required this.latitude,
    required this.longitude,
  });

  factory TicketDto.fromJson(Map<String, dynamic> j) => TicketDto(
        prize: j['prize'] as String,
        expirationAt: j['expiration_at'] as String,
        storeName: j['store_name'] as String,
        latitude: (j['_latitude'] as num).toDouble(),
        longitude: (j['_longitude'] as num).toDouble(),
      );
}

