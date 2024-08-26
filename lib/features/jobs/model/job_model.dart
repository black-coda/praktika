// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class JobModel {
  final String jobTitle;
  final String section;
  final String salaryRange;
  final JobType jobType;
  final JobDuration jobDuration;
  JobModel({
    required this.jobTitle,
    required this.section,
    required this.salaryRange,
    required this.jobType,
    required this.jobDuration,
  });

  

  JobModel copyWith({
    String? jobTitle,
    String? section,
    String? salaryRange,
    JobType? jobType,
    JobDuration? jobDuration,
  }) {
    return JobModel(
      jobTitle: jobTitle ?? this.jobTitle,
      section: section ?? this.section,
      salaryRange: salaryRange ?? this.salaryRange,
      jobType: jobType ?? this.jobType,
      jobDuration: jobDuration ?? this.jobDuration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobTitle': jobTitle,
      'section': section,
      'salaryRange': salaryRange,
      'jobType': jobType,
      'jobDuration': jobDuration,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      jobTitle: map['jobTitle'] as String,
      section: map['section'] as String,
      salaryRange: map['salaryRange'] as String,
      jobType: map['jobType'] as JobType,
      jobDuration: map['jobDuration'] as JobDuration,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) => JobModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobModel(jobTitle: $jobTitle, section: $section, salaryRange: $salaryRange, jobType: $jobType, jobDuration: $jobDuration)';
  }

  @override
  bool operator ==(covariant JobModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.jobTitle == jobTitle &&
      other.section == section &&
      other.salaryRange == salaryRange &&
      other.jobType == jobType &&
      other.jobDuration == jobDuration;
  }

  @override
  int get hashCode {
    return jobTitle.hashCode ^
      section.hashCode ^
      salaryRange.hashCode ^
      jobType.hashCode ^
      jobDuration.hashCode;
  }
}

enum JobType{
  remote,
  hybrid,
}

enum JobDuration{
  fullTime,
  partTime,
  contract,
  internship,
}