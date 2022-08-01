import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/others_profile/others_profile_bloc.dart';
import 'package:social_media/application/search/search_bloc.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/core/controllers/text_controllers.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/notification/notification_model.dart';
import 'package:social_media/presentation/screens/home/home_screen.dart';
import 'package:social_media/presentation/util/functions/debounce.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: NotificationsAppBar(),
        preferredSize: appBarHeight,
      ),
      body: Container(
        child: Padding(
            padding: constPadding.copyWith(left: 10.sm, right: 10.sm),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection(Collections.users)
                  .doc(Global.USER_DATA.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  log("${snapshot.connectionState}");
                  return Center(
                    child: Text("Loading"),
                  );
                } else if (snapshot.connectionState == ConnectionState.active) {
                  log("${snapshot.connectionState}");

                  if (snapshot.hasData) {
                    if ((snapshot.data!.data()!['notifications']
                            as List<dynamic>)
                        .isEmpty) {
                      return Center(
                        child: Text("Empty"),
                      );
                    }

                    return ListView(
                        children: (snapshot.data!.data()!['notifications']
                                as List<dynamic>)
                            .map((notification) {
                      final model = NotificationModel.fromMap(notification);

                      return StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection(Collections.users)
                              .doc(Global.USER_DATA.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListTile(
                                leading:
                                    snapshot.data!.data()!['profileImage'] ==
                                            null
                                        ? CircleAvatar(radius: 17.sm)
                                        : CircleAvatar(
                                            radius: 17.sm,
                                            backgroundImage: NetworkImage(
                                                snapshot.data!
                                                    .data()!['profileImage']),
                                          ),
                                title: Text(
                                  "${snapshot.data!.data()!['name']} added a new post",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 15.sm,
                                          fontWeight: FontWeight.normal),
                                ),
                              );
                            } else {
                              return ListTile(
                                leading: CircularProgressIndicator(),
                                title: Text("Loading"),
                              );
                            }
                          });
                    }).toList());

                    // List<NotificationModel> notifications = [];
                    // notificationDatas.map((data) {
                    //   notifications.add(NotificationModel.fromMap(data));
                    // });

                    // return Center(
                    //   child: Text("Has Data"),
                    // );
                  } else {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error Happened"),
                      );
                    } else {
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    }
                  }
                } else {
                  log("${snapshot.connectionState}");
                  return Center(
                    child: Text("Error"),
                  );
                }
              },
            )

            //  ListView.separated(
            //     itemBuilder: (context, index) => ListTile(
            //           visualDensity: VisualDensity(vertical: -2, horizontal: -4),
            //           minVerticalPadding: 10,
            //           leading: CircleAvatar(radius: 17.sm),
            //           title: Text(
            //             "fasjdfljasldkfjlkasjdfljas",
            //             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //                 fontSize: 15.sm, fontWeight: FontWeight.normal),
            //           ),
            //         ),
            //     separatorBuilder: (context, index) => Gap(H: 5.sm),
            //     itemCount: 10),
            ),
      ),
    );
  }
}

class NotificationsAppBar extends StatelessWidget {
  const NotificationsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.sm),
          bottomRight: Radius.circular(40.sm)),
      child: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15.sm),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          "Notifications",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: pureWhite),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.clear_all)),
          Gap(
            W: 15.sm,
          )
        ],
      ),
    );
  }
}
