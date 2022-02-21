import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/notification_models.dart';
import 'package:fluter_19pmd/services/notification/notification_event.dart';
import 'package:fluter_19pmd/services/notification/notification_bloc.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final notificationBloc = NotificationBloc();
  @override
  void initState() {
    notificationBloc.eventSink.add(NotificationEvent.fetch);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    notificationBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<List<Notifications>>(
            initialData: [],
            stream: notificationBloc.notificationStream,
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white,
                      shadowColor: Colors.teal,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin: const EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _contentCard(size, snapshot, index),
                      ),
                    );
                  },
                ),
              );
            }),
      ],
    );
  }

  Widget _contentCard(size, snapshot, int) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Ngày:',
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
                TextSpan(
                  text: snapshot.data[int].dateCreated.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: buttonColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/sales/${snapshot.data[int].image}",
                height: 100,
                width: 100,
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 240,
                    height: 30,
                    child: Text(
                      snapshot.data[int].title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 240,
                    height: 100,
                    child: Text(
                      snapshot.data[int].content,
                      maxLines: 4,
                      style: const TextStyle(
                        fontSize: 18,
                        color: textColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
