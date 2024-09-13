import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/features/authentication/controller/supabase_provider.dart';
import 'package:myapp/features/authentication/view/widget/input_field_widget.dart';
import 'package:myapp/features/jobs/controller/resume_controller.dart';
import 'package:myapp/features/jobs/model/resume_model.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/shared/error_view.dart';
import 'package:myapp/utils/toast/toast_manager.dart';

class EditResumeView extends ConsumerStatefulWidget {
  const EditResumeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditResumeViewState();
}

class _EditResumeViewState extends ConsumerState<EditResumeView> {
  late TextEditingController _roleController;
  late TextEditingController _descriptionController;
  late TextEditingController _yearsOfExperienceController;
  late TextEditingController _skillsController;
  late TextEditingController _achievementsController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _roleController = TextEditingController();
    _descriptionController = TextEditingController();
    _yearsOfExperienceController = TextEditingController();
    _skillsController = TextEditingController();
    _achievementsController = TextEditingController();
  }

  @override
  void dispose() {
    _roleController.dispose();
    _descriptionController.dispose();
    _yearsOfExperienceController.dispose();
    _skillsController.dispose();
    _achievementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final supabase = ref.watch(supabaseProvider);
    final currentUserUID = supabase.auth.currentUser!.id;
    final resumeDetails = ref.watch(getResumeFutureProvider);

    return resumeDetails.when(
      data: (data) {
        // Populate the TextEditingControllers once data is available

        _roleController.text = data?.role ?? '';
        _descriptionController.text = data?.description ?? '';
        _yearsOfExperienceController.text =
            data?.yearsOfExperience.toString() ?? '';
        _skillsController.text = data?.skills ?? '';
        _achievementsController.text = data?.achievements ?? '';
        return Scaffold(
          appBar: AppBar(
            title: const HeaderWidget("Edit Resume"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: Constant.scaffoldPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputField(formName: "Role", controller: _roleController),
                    SpacerConstant.sizedBox16,
                    InputField(
                        formName: "Description",
                        controller: _descriptionController),
                    SpacerConstant.sizedBox16,
                    InputField(
                        formName: "Years of Experience",
                        controller: _yearsOfExperienceController,
                        keyboardType: TextInputType.number),
                    SpacerConstant.sizedBox16,
                    InputField(
                        formName: "Skills", controller: _skillsController),
                    SpacerConstant.sizedBox16,
                    InputField(
                        formName: "Achievements",
                        controller: _achievementsController),
                    SpacerConstant.sizedBox32,
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          log("Form validated");
                          final resume = ResumeModel(
                            id: currentUserUID,
                            role: _roleController.text.trim(),
                            description: _descriptionController.text.trim(),
                            yearsOfExperience: int.parse(
                                _yearsOfExperienceController.text.trim()),
                            skills: _skillsController.text.trim(),
                            achievements: _achievementsController.text.trim(),
                          );
                          final updateSuccess = await ref
                              .read(resumeServiceProvider)
                              .updateResume(resume)
                              .then((value) {
                            if (value) {
                              ToastManager().showToast(
                                  context, "Resume updated successfully 🎉");
                            }
                          });
                          log("Update success: $updateSuccess");
                          ref.invalidate(getResumeFutureProvider);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Save",
                        style: Constant.underlineStyle(context),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      error: (e, _) {
        log(e.toString());
        return ErrorView(
          errorMessage: e.toString(),
          providerClass: getResumeFutureProvider,
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
