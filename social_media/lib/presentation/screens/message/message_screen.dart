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

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: constPadding.copyWith(left: 10.sm, right: 10.sm),
          child: Column(
            children: [
              UserSearchInMessageWidget(),
              Gap(H: 10.sm),
              ChatBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: List.generate(10, (index) {
          return ChatTilesWidget(
            key: ValueKey(index),
          );
        }),
      ),
    );
  }
}

class ChatTilesWidget extends StatelessWidget {
  const ChatTilesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 18.sm,
        backgroundColor: secondaryBlue,
      ),
      trailing: CircleAvatar(
        backgroundColor: primaryBlue,
        radius: 5.sm,
      ),
      title: Text(
        "hello",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: 16.sm, fontWeight: FontWeight.normal),
      ),
    );
  }
}

class UserSearchInMessageWidget extends StatelessWidget {
  UserSearchInMessageWidget({
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
          controller: SearchInMessageTextControllers.userSearch,
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
