import 'package:flutter/material.dart';
import 'package:pokemon_card_collector/widgets/explore_page/search_bar.dart';

class SearchPage extends StatefulWidget {
  final List<String> selectedSetName;
  final RangeValues rangeValues;
  final List<String> selectedTypes;

  const SearchPage(
      {super.key,
      required this.rangeValues,
      required this.selectedSetName,
      required this.selectedTypes});

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
          backgroundColor: Colors.black, automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
        child: Column(
          children: [
            Hero(
              tag: 'searchBarHero',
              child: Material(
                color: Colors.transparent,
                child: AutoCompleteSearchWidgetExplorePage(
                  appBarHeight: appBarHeight,
                  height: height,
                  selectedSetName: widget.selectedSetName,
                  selectedTypes: widget.selectedTypes,
                  rangeValues: widget.rangeValues,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
