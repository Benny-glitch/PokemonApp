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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(0, 12.0, 0, 0),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Hero(
                  tag: 'searchBarHero',
                  child: Material(
                    color: Colors.transparent,
                    child: AutoCompleteSearchWidgetExplorePage(),
                    ),
                ),
              ],
            ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
