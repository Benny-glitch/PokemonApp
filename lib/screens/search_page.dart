import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/widgets/explore_page/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    final double height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
          children: [
            Hero(
              tag: 'searchBarHero',
              child: Material(
                color: Colors.transparent,
                child: AutoCompleteSearchWidgetExplorePage(appBarHeight: appBarHeight, height: height),
              ),
            ),
          ],
        ),
      backgroundColor: Colors.black,
    );
  }
}
