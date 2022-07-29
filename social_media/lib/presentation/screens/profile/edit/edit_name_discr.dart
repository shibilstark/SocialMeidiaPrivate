import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/controllers/text_controllers.dart';
import 'package:social_media/domain/models/local_models/name_and_disc.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/widgets/gap.dart';

showEditNameAndDiscSheet(context) {
  showBottomSheet(
      context: context,
      builder: (ctx) => EditNameAndDiscSheet(),
      enableDrag: true);
}

class EditNameAndDiscSheet extends StatelessWidget {
  EditNameAndDiscSheet({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var underlineInputBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).splashColor));
    return Container(
      height: 220.sm,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(10.sm),
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              UserModel model = (state as ProfileSuccess).profileModel.user;
              EditProfileTextEditingControllers.name.text = model.name;
              if (model.discription != null) {
                EditProfileTextEditingControllers.discription.text =
                    model.discription!;
              }

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        if (val == null || val.length <= 3) {
                          return "Can't be empty or less than 3";
                        }
                        return null;
                      },
                      controller: EditProfileTextEditingControllers.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16.sm),
                      decoration: InputDecoration(
                        hintStyle:
                            TextStyle(color: smoothWhite.withOpacity(0.4)),
                        hintText: "Name",
                        enabledBorder: underlineInputBorder,
                        focusedBorder: underlineInputBorder,
                        disabledBorder: underlineInputBorder,
                        errorBorder: underlineInputBorder,
                        border: underlineInputBorder,
                      ),
                    ),
                    Gap(H: 15.sm),
                    TextFormField(
                      controller: EditProfileTextEditingControllers.discription,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16.sm),
                      decoration: InputDecoration(
                        hintText: "Discription",
                        hintStyle:
                            TextStyle(color: smoothWhite.withOpacity(0.4)),
                        enabledBorder: underlineInputBorder,
                        focusedBorder: underlineInputBorder,
                        disabledBorder: underlineInputBorder,
                        errorBorder: underlineInputBorder,
                        border: underlineInputBorder,
                      ),
                    ),
                    Gap(H: 30.sm),
                    SizedBox(
                        height: 35.sm,
                        child: MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (EditProfileTextEditingControllers
                                          .discription.text
                                          .trim() ==
                                      model.discription &&
                                  EditProfileTextEditingControllers.name.text
                                          .trim() ==
                                      model.name) {
                                Navigator.of(context).pop();
                              } else {
                                NameAndDisc obj = NameAndDisc(
                                    disc: EditProfileTextEditingControllers
                                            .discription.text
                                            .trim()
                                            .isEmpty
                                        ? null
                                        : EditProfileTextEditingControllers
                                            .discription.text
                                            .trim(),
                                    name: EditProfileTextEditingControllers
                                        .name.text
                                        .trim());

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  context
                                      .read<EditProfileBloc>()
                                      .add(ChangeNameAndDisc(obj));
                                });

                                Navigator.of(context).pop();
                              }
                            }
                          },
                          color: primaryBlue,
                          child: Text(
                            "Update",
                            style: TextStyle(color: pureWhite, fontSize: 15.sm),
                          ),
                        ))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
