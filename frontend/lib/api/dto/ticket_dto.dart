class TicketDto {
  final String prize;
  final DateTime expirationAt;
  final String storeName;
  final double latitude;
  final double longitude;
  final String ticket_id;

  TicketDto({
    required this.prize,
    required this.expirationAt,
    required this.storeName,
    required this.latitude,
    required this.longitude,
    required this.ticket_id,
  });

  factory TicketDto.fromJson(Map<String, dynamic> j) => TicketDto(
    prize: j['prize'] as String? ?? '',
    expirationAt: DateTime.parse(j['expiration_at'] as String).toLocal(),
    storeName: j['store_name'] as String? ?? '',
    latitude: (j['point']?['lat'] as num?)?.toDouble() ?? 0.0,
    longitude: (j['point']?['lng'] as num?)?.toDouble() ?? 0.0,
    ticket_id: j['ticket_id'] as String? ?? '',

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
