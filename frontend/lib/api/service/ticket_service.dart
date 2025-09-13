import '../client.dart';
import '../dto/ticket_dto.dart';

class TicketsService {
  TicketsService(this.api);
  final ApiClient api;

  Future<TicketDto> fetchNextTicket() async {
    final json = await api.getJson('next');
    return TicketDto.fromJson(json);
  }
}

