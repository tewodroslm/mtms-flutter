import 'package:json_annotation/json_annotation.dart';

part 'driver.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Driver {
  int id;
  String name;
  String licence;
  String working_route;
  int driver_type;
  int car_owner;
  String created_at;

  Driver(
      {this.id = 0,
      this.name = '',
      this.licence = '',
      this.working_route = '',
      this.driver_type = 0,
      this.car_owner = 0,
      this.created_at = ''});

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);
}


//  "driver": {
//     "id": 1,
//     "name": "driver1",
//     "licence": "driver111",
//     "working_route": "Bishoftu",
//     "driver_type": 1,
//     "car_owner": null,
//     "created_at": "2021-09-13T17:58:29.000000Z",
//     "updated_at": "2021-09-13T17:58:29.000000Z"
//   },