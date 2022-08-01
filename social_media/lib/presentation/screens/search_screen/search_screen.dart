import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/others_profile/others_profile_bloc.dart';
import 'package:social_media/application/search/search_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/core/controllers/text_controllers.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/presentation/screens/home/home_screen.dart';
import 'package:social_media/presentation/util/functions/debounce.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: constPadding.copyWith(left: 10.sm, right: 10.sm),
          child: Column(
            children: [
              SearchUserTextFieldWidget(),
              Gap(H: 10.sm),
              SearchResultWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchIdle) {
          return const Center(
            child: Text("Search Somethinhg"),
          );
        } else if (state is SearchLoading) {
          return const Center(
            child: Text("Loading"),
          );
        } else if (state is SearchSuccess) {
          return Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final currentUser = state.results[index];
                  return ListTile(
                    onTap: () async {
                      if (currentUser.userId != Global.USER_DATA.id) {
                        WidgetsBinding.instance.addPostFrameCallback((_) async {
                          context
                              .read<OthersProfileBloc>()
                              .add(GetUserWithId(userId: currentUser.userId));
                          Navigator.of(context).pushNamed('/othersprofile');
                        });
                      } else {
                        gotoProfile();
                      }
                    },
                    dense: true,
                    visualDensity: const VisualDensity(vertical: -2),
                    leading: currentUser.profileImage == null
                        ? CircleAvatar(
                            radius: 18.sm,
                            backgroundImage:
                                const AssetImage("assets/dummy/dummyDP.png"),
                          )
                        : CircleAvatar(
                            radius: 18.sm,
                            backgroundImage:
                                NetworkImage(currentUser.profileImage!),
                          ),
                    title: Text(
                      currentUser.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14.sm, fontWeight: FontWeight.normal),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Gap(H: 5.sm),
                // separatorBuilder: (context, index) =>
                //     Divider(thickness: 0.2.sm),
                itemCount: state.results.length),
          );
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      },
    );
  }
}

class SearchUserTextFieldWidget extends StatelessWidget {
  SearchUserTextFieldWidget({
    Key? key,
  }) : super(key: key);

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.sm),
      child: SizedBox(
        height: 35.sm,
        child: TextField(
          controller: SearchTextControllers.userSearch,
          onChanged: (value) {
            _debouncer.run(() {
              context.read<SearchBloc>().add(SearchUser(
                  query: SearchTextControllers.userSearch.text
                      .replaceAll(" ", "")
                      .trim()));
            });
          },
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 17.sm, fontWeight: FontWeight.normal),
          cursorColor: softBlack,
          decoration: InputDecoration(
            hintText: "Search...",
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 17.sm,
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withOpacity(0.5)),
            // contentPadding: EdgeInsets.symmetric(
            //     vertical: 14.sm, horizontal: 10.sm),
            border: InputBorder.none,
            filled: true,
            fillColor: Color.fromARGB(77, 85, 85, 85),
          ),
        ),
      ),
    );
  }
}
