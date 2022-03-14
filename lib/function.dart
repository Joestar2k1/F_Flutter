import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/favorites_api.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:fluter_19pmd/views/profile/collections/open_item_collection.dart';
import 'package:flutter/material.dart';

import 'models/favorites_model.dart';

String convertToVND(int price) {
  var current = price.toString().split('');
  var newPrice = '';

  if (current.length == 5) {
    current.insert(2, '.');
    current.forEach((element) {
      newPrice += element;
    });
  } else if (current.length == 6) {
    current.insert(3, '.');
    current.forEach((element) {
      newPrice += element;
    });
  } else if (current.length == 4) {
    current.insert(1, '.');
    current.forEach((element) {
      newPrice += element;
    });
  } else {
    newPrice = price.toString();
  }
  return newPrice.toString();
}

// ignore: must_be_immutable
class AlertDiaLogCustom extends StatelessWidget {
  AlertDiaLogCustom(
      {Key key,
      this.title,
      this.content,
      this.gif,
      this.textButton,
      this.textButton1,
      this.press})
      : super(key: key);
  final String title, content, gif;
  String textButton;
  String textButton1;
  Function press;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 100,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  (textButton1 == null)
                      ? Container()
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(buttonColor),
                          ),
                          onPressed: press,
                          child: Text(
                            textButton1,
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(buttonColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      textButton,
                      style: const TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            backgroundImage: AssetImage(gif),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class AlertTextFieldCustom extends StatefulWidget {
  const AlertTextFieldCustom({Key key, this.title, this.gif, this.productID})
      : super(key: key);
  final String title, gif, productID;

  @override
  State<AlertTextFieldCustom> createState() => _AlertTextFieldCustomState();
}

class _AlertTextFieldCustomState extends State<AlertTextFieldCustom> {
  final controller = TextEditingController();
  final _eventFavorite = EventForUserInFavorite();
  final _favorites = ProfileBloc();

  @override
  void initState() {
    super.initState();
    _favorites.eventSink.add(UserEvent.showFavorite);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _eventFavorite.dispose();
    _favorites.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 100,
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 10.0))
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    StreamBuilder<List<Favorites>>(
                        initialData: null,
                        stream: _favorites.userFavoriteStream,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return SizedBox(
                            width: 300,
                            height: RepositoryFavorite.getHeightForScreenHome(
                                snapshot.data.length),
                            child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            '-${snapshot.data[index].title}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey.shade600,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              var code =
                                                  await RepositoryFavorite
                                                      .addProduct(
                                                widget.productID,
                                                snapshot.data[index].id,
                                              );
                                              if (code == 200) {
                                                Navigator.of(context).pop();
                                                await showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDiaLogCustom(
                                                          title: "Thành công",
                                                          content:
                                                              "-Đã thêm sản phẩm vào yêu thích.",
                                                          gif:
                                                              "assets/gif/success.gif",
                                                          textButton: "Okay");
                                                    });
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.green,
                                              size: 30,
                                            )),
                                      ],
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: snapshot.data.length),
                          );
                        }),
                    StreamBuilder<bool>(
                        initialData: false,
                        stream: _eventFavorite.openFavoriteStream,
                        builder: (context, state) {
                          if (!state.data) {
                            return Container();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: TextFormField(
                              controller: controller,
                              obscureText: false,
                              style: const TextStyle(fontSize: 20),
                              keyboardType: TextInputType.text,
                              onFieldSubmitted: (value) {},
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(fontSize: 18),
                                labelText: "Nhập ...",
                                labelStyle: TextStyle(fontSize: 20),
                              ),
                            ),
                          );
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(buttonColor),
                          ),
                          onPressed: () {
                            _eventFavorite.openFavoriteSink.add(true);
                          },
                          child: const Text(
                            "Tạo mới",
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(buttonColor),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Hủy",
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: SizedBox(
                  height: 100,
                  child: Image.asset(
                    widget.gif,
                    fit: BoxFit.fitHeight,
                    scale: 10.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
