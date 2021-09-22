// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: json['id'] as int? ?? 0,
      starting_point: json['starting_point'] as String? ?? '',
      destination: json['destination'] as String? ?? '',
      amount: json['amount'] as String? ?? '',
      driver_id: json['driver_id'] as int? ?? 0,
      canceled: json['canceled'] as int? ?? 0,
      created_at: json['created_at'] as String? ?? '',
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'starting_point': instance.starting_point,
      'destination': instance.destination,
      'amount': instance.amount,
      'canceled': instance.canceled,
      'driver_id': instance.driver_id,
      'created_at': instance.created_at,
    };
