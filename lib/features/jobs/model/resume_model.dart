// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResumeModel {
  final String id;
  final String role;
  final String description;
  final int yearsOfExperience;
  final String skills;
  final String achievements;
  ResumeModel({
    required this.id,
    required this.role,
    required this.description,
    required this.yearsOfExperience,
    required this.skills,
    required this.achievements,
  });


  ResumeModel.defaultResume()
      : id = "",
        role = "",
        description = "",
        yearsOfExperience = 0,
        skills = "",
        achievements = "";

  ResumeModel copyWith({
    String? id,
    String? role,
    String? description,
    int? yearsOfExperience,
    String? skills,
    String? achievements,
  }) {
    return ResumeModel(
      id: id ?? this.id,
      role: role ?? this.role,
      description: description ?? this.description,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      skills: skills ?? this.skills,
      achievements: achievements ?? this.achievements,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'role': role,
      'description': description,
      'years_of_experience': yearsOfExperience,
      'skills': skills,
      'achievements': achievements,
    };
  }

  factory ResumeModel.fromMap(Map<String, dynamic> map) {
    return ResumeModel(
      id: map['id'] as String,
      role: map['role'] as String,
      description: map['description'] as String,
      yearsOfExperience: map['years_of_experience'] as int,
      skills: map['skills'] as String,
      achievements: map['achievements'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResumeModel.fromJson(String source) =>
      ResumeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResumeModel(id: $id, role: $role, description: $description, yearsOfExperience: $yearsOfExperience, skills: $skills, achievements: $achievements)';
  }

  @override
  bool operator ==(covariant ResumeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.role == role &&
        other.description == description &&
        other.yearsOfExperience == yearsOfExperience &&
        other.skills == skills &&
        other.achievements == achievements;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        role.hashCode ^
        description.hashCode ^
        yearsOfExperience.hashCode ^
        skills.hashCode ^
        achievements.hashCode;
  }
}
