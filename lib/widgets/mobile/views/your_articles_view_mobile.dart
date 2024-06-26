import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../constants.dart';
import '../../../services/article_services.dart';
import '../../../services/user_services.dart';
import '../../universal/buttons/circle_button.dart';
import '../cards/article_card_mobile.dart';

class YourArticlesViewMobile extends StatelessWidget {
  const YourArticlesViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kBackgroundColor,
      child: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          "Drafts",
                          style: TextStyle(fontFamily: "Inter", fontSize: 15.0),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Published",
                          style: TextStyle(fontFamily: "Inter", fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: TabBarView(
                          children: [_draftsPage(), _publishedPage()])),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleButton(
                        text: const Text(
                          "Buat Artikel",
                          style: TextStyle(
                              fontFamily: "Inter", color: Colors.white),
                        ),
                        color: kPurpleColor,
                        onTap: () {
                          Modular.to.pushNamed(createArticleRoute);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _draftsPage() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: StreamBuilder(
        stream: getDraftsArticleStreamFromAuthorId(
          currentUser!.id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data == null) {
              return const Center(
                child: Text("Belum ada artikel yang disimpan"),
              );
            } else {
              final data = snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ArticleCardMobile(
                    articleId: data[index].id,
                    article: data[index].data(),
                    withUpdateAndDelete: true,
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  Widget _publishedPage() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: StreamBuilder(
        stream: getPublishedArticlesStreamFromAuthorId(
          currentUser!.id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data == null) {
              return const Center(
                child: Text("Belum ada artikel yang dipublikasikan"),
              );
            } else {
              final data = snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ArticleCardMobile(
                    articleId: data[index].id,
                    article: data[index].data(),
                    withUpdateAndDelete: true,
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
