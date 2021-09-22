// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Driver _$DriverFromJson(Map<String, dynamic> json) => Driver(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      licence: json['licence'] as String? ?? '',
      working_route: json['working_route'] as String? ?? '',
      driver_type: json['driver_type'] as int? ?? 0,
      car_owner: json['car_owner'] as int? ?? 0,
      created_at: json['created_at'] as String? ?? '',
    );

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'licence': instance.licence,
      'working_route': instance.working_route,
      'driver_type': instance.driver_type,
      'car_owner': instance.car_owner,
      'created_at': instance.created_at,
    };
