import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/features/authentication/controller/auth_controller.dart';
import 'package:myapp/features/authentication/controller/supabase_provider.dart';
import 'package:myapp/features/jobs/model/resume_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResumeService {
  final Ref ref;

  ResumeModel? resumeModel;

  ResumeService({required this.ref});

  Future<ResumeModel?> fetchResume() async {
    // final isLoadingState = ref.watch(authStateNotifierProvider.notifier);
    try {
      // isLoadingState.setIsLoading(true);
      final supabase = ref.watch(supabaseProvider);
      final currentUserUID = supabase.auth.currentUser!.id;
      final data =
          await supabase.from("resume").select().eq("id", currentUserUID);

      if (data.isEmpty) {
        return null;
      }
      final resume = ResumeModel.fromMap(data.first);
      resumeModel = resume;

      return resume;
    } on Exception catch (e) {
      log(e.toString());
    }
    // isLoadingState.setIsLoading(true);
    return null;
  }

  Future<bool> updateResume(ResumeModel resumeModel) async {
    final resumeJson = resumeModel.toMap();
    final isLoadingState = ref.watch(authStateNotifierProvider.notifier);
    final supabase = ref.watch(supabaseProvider);
    final currentUserUID = supabase.auth.currentUser!.id;

    try {
      isLoadingState.setIsLoading(true);

      // Check if the user exists
      // final response = await supabase
      //     .from('resume')
      //     .select()
      //     .eq('id', currentUserUID)
      //     .single(); // This returns one row if user exists

      // log(response.toString(), name: "User Exists");

      await supabase.from("resume").upsert(resumeJson);
      return true;
    } catch (e) {
      // rethrow;
      // if (e.code == "23502") {
      //   log("user's resume profile does not exist",
      //       name: "Update Resume Error");
      //   log("Creating new resume profile ...");

      //   await supabase.from('resume').insert(resumeJson);
      //   log('New user inserted successfully', name: "Success 🤌");
      // }
      // log(e.runtimeType.toString(), name: "Update Resume Error runtimetype");
      log(e.toString(), name: "Update Resume Error");
      return false;
    } finally {
      isLoadingState.setIsLoading(false);
    }
  }

  Future<void> uploadResumeFile(File file) async {
    //TODO: Update resume
  }
}

final resumeServiceProvider = Provider<ResumeService>((ref) {
  return ResumeService(ref: ref);
});

final getResumeFutureProvider =
    FutureProvider.autoDispose<ResumeModel?>((ref) async {
  return ref.read(resumeServiceProvider).fetchResume();
});
