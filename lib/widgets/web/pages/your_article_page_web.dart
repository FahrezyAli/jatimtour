import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/services/article_services.dart' as article_services;
import 'package:jatimtour/services/user_services.dart' as user_services;
import 'package:jatimtour/widgets/universal/buttons/circle_button.dart';
import 'package:jatimtour/widgets/web/cards/article_card_web.dart';
import 'package:jatimtour/widgets/web/pages/web_scaffold.dart';

class YourArticlePageWeb extends StatelessWidget {
  const YourArticlePageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Published",
                    style: TextStyle(fontFamily: "Inter", fontSize: 15.0),
                  ),
                ),
                Tab(
                  child: Text(
                    "Drafts",
                    style: TextStyle(fontFamily: "Inter", fontSize: 15.0),
                  ),
                ),
              ],
            ),
            Expanded(
                child: TabBarView(
                    children: [_publishedPage(context), Container()])),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CircleButton(
                  text: const Text(
                    "Buat Artikel",
                    style: TextStyle(fontFamily: "Inter", color: Colors.white),
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
    );
  }

  Widget _publishedPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
      child: StreamBuilder(
        stream: article_services.getArticleStreamFromAuthorId(
          user_services.currentUser!.id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ArticleCardWeb(
                  articleId: data[index].id,
                  article: data[index].data(),
                  withUpdateAndDelete: true,
                );
              },
            );
          }
        },
      ),
    );
  }
}
