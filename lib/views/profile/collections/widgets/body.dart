import 'package:fluter_19pmd/models/favorites_model.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/favorites_api.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:fluter_19pmd/views/profile/collections/open_item_collection.dart';
import 'package:fluter_19pmd/views/profile/collections/widgets/list_product.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Body extends StatefulWidget {
  Body({Key key, this.isCreated, this.isDeleted}) : super(key: key);
  bool isCreated;
  final bool isDeleted;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _openFavorite = EventForUserInFavorite();
  final _formController = TextEditingController();
  final _favorites = ProfileBloc();
  @override
  void initState() {
    super.initState();
    _favorites.eventSink.add(UserEvent.showFavorite);
  }

  @override
  void dispose() {
    super.dispose();
    _formController.dispose();
    _openFavorite.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<bool>(
        initialData: false,
        stream: _openFavorite.openFavoriteStream,
        builder: (context, state) {
          return StreamBuilder<List<Favorites>>(
              initialData: null,
              stream: _favorites.userFavoriteStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        Container(
                          height: RepositoryFavorite.getHeight(
                              snapshot.data.length),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) => Container(
                              padding: const EdgeInsets.all(10),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      EventForUserInFavorite.index = index;
                                      (state.data)
                                          ? _openFavorite.openFavoriteSink
                                              .add(false)
                                          : _openFavorite.openFavoriteSink
                                              .add(true);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            AnimatedContainer(
                                              width:
                                                  widget.isDeleted ? 60.0 : 0.0,
                                              height:
                                                  widget.isDeleted ? 60.0 : 0.0,
                                              color: Colors.white,
                                              duration:
                                                  const Duration(seconds: 2),
                                              curve: Curves.fastOutSlowIn,
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () async {
                                                    var data =
                                                        await RepositoryFavorite
                                                            .deleteFavorite(
                                                                snapshot
                                                                    .data[index]
                                                                    .id);
                                                    if (data == 200) {
                                                      showToast(
                                                          "Xóa thành công");
                                                      _favorites.eventSink.add(
                                                          UserEvent
                                                              .showFavorite);
                                                    } else {
                                                      showToast("Xóa thất bại");
                                                    }
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/icons-png/trash.png",
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 250,
                                              height: 70,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot.data[index].title,
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      color: Colors.black87,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                            onTap: () {
                                              EventForUserInFavorite.index =
                                                  index;
                                              (state.data)
                                                  ? _openFavorite
                                                      .openFavoriteSink
                                                      .add(false)
                                                  : _openFavorite
                                                      .openFavoriteSink
                                                      .add(true);
                                            },
                                            child: (state.data &&
                                                    EventForUserInFavorite
                                                            .index ==
                                                        index)
                                                ? const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.teal,
                                                  )
                                                : const Icon(
                                                    Icons.arrow_right,
                                                    color: Colors.teal,
                                                  )),
                                      ],
                                    ),
                                  ),
                                  // ignore: unrelated_type_equality_checks
                                ],
                              ),
                            ),
                          ),
                        ),
                        _form(widget.isCreated, size),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget _form(isCreated, size) => AnimatedContainer(
        width: widget.isCreated ? size.width : 0.0,
        height: widget.isCreated ? 80.0 : 0.0,
        duration: const Duration(seconds: 2),
        alignment: widget.isCreated
            ? Alignment.centerLeft
            : AlignmentDirectional.topCenter,
        curve: Curves.fastOutSlowIn,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: TextFormField(
          controller: _formController,
          style: const TextStyle(fontSize: 20),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.send,
          onFieldSubmitted: (value) async {
            var data = await RepositoryFavorite.addTitle(value);
            if (data == 200) {
              showToast("Tạo thành công", gravity: Toast.BOTTOM, duration: 2);
              _favorites.eventSink.add(UserEvent.showFavorite);
              widget.isCreated = false;
              _formController.text = "";
            } else {
              showToast("Tạo thất bại", gravity: Toast.BOTTOM, duration: 2);
            }
          },
          decoration: InputDecoration(
            border: widget.isCreated ? const OutlineInputBorder() : null,
            errorStyle: const TextStyle(fontSize: 20),
            labelText: "Nhập tên",
            labelStyle: const TextStyle(fontSize: 20),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Bạn chưa nhập tiêu đề';
            }
            return null;
          },
        ),
      );
  showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context,
        duration: duration, gravity: gravity, backgroundColor: Colors.teal);
  }
}
