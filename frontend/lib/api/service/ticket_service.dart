import '../client.dart';
import '../dto/ticket_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketsService {
  TicketsService(this.api);
  final ApiClient api;

  Future<List<TicketDto>> fetchTickets() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt');

    final headers = <String, String>{};
    if (jwt != null) {
      headers['Authorization'] = 'Bearer $jwt';
    }

    final json = await api.getJson('', headers: headers);
    final response = TicketsResponse.fromJson(json);

    if (response.ticketsInfo.containsKey('haveTicketsInfo')) {
      final ticketsMap =
          response.ticketsInfo['haveTicketsInfo'] as Map<String, dynamic>;
      final tickets = <TicketDto>[];

      for (final ticketData in ticketsMap.values) {
        if (ticketData is Map<String, dynamic>) {
          tickets.add(TicketDto.fromJson(ticketData));
        }
      }

      return tickets;
    }

    return [];
  }
}
