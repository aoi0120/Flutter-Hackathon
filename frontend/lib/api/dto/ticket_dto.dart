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
    prize: j['prize'] as String? ?? '',
    expirationAt: j['expiration_at']?.toString() ?? '',
    storeName: j['store_name'] as String? ?? '',
    latitude: (j['point']?['lat'] as num?)?.toDouble() ?? 0.0,
    longitude: (j['point']?['lng'] as num?)?.toDouble() ?? 0.0,
  );

}

class TicketsResponse {
  final String message;
  final Map<String, dynamic> ticketsInfo;

  TicketsResponse({required this.message, required this.ticketsInfo});

  factory TicketsResponse.fromJson(Map<String, dynamic> j) => TicketsResponse(
    message: j['message'] as String,
    ticketsInfo: j['ticketsInfo'] as Map<String, dynamic>,
  );
}
