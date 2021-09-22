import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Ticket {
  int id;
  String starting_point;
  String destination;
  String amount;
  int canceled;
  int driver_id;
  String created_at;

  Ticket(
      {this.id = 0,
      this.starting_point = '',
      this.destination = '',
      this.amount = '',
      this.driver_id = 0,
      this.canceled = 0,
      this.created_at = ''});

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}


  // 'starting_point': starting_point,
  //         'destination': destination,
  //         'amount': amount,
  //         'driver_id': driver_id,
  //         'canceled': canceled