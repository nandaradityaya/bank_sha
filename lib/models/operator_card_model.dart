import 'package:bank_sha/models/data_plan_model.dart';

class OperatorCardModel {
  final int? id;
  final String? name;
  final String? status;
  final String? thumbnail;
  final List<DataPlanModel>? dataplans; // kasih tanda tanya bair nullable

  OperatorCardModel({
    this.id,
    this.name,
    this.status,
    this.thumbnail,
    this.dataplans,
  });

  factory OperatorCardModel.fromJson(Map<String, dynamic> json) =>
      OperatorCardModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        thumbnail: json['thumbnail'],
        // ini panjang karna kita pake object di dalam object
        dataplans: json['data_plans'] == null
            ? null
            : (json['data_plans'] as List)
                .map((dataPlan) => DataPlanModel.fromJson(dataPlan))
                .toList(),
      );
}
