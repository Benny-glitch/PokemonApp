import 'package:flutter/material.dart';
import 'bottom_fixed_widget.dart';

class MyDraggableSheet extends StatefulWidget {
  final Widget child;
  final bool isEmpty;

  const MyDraggableSheet({super.key, required this.child, this.isEmpty = false});

  @override
  State<MyDraggableSheet> createState() => _MyDraggableSheetState();
}

class _MyDraggableSheetState extends State<MyDraggableSheet> {
  final controller = DraggableScrollableController();
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onSheetChange);
  }

  void _onSheetChange() {
    setState(() {
      isExpanded = controller.size > 0.7;
    });
  }

  void _toggleSheetSize() {
    final targetSize = isExpanded ? 0.7 : 1.0;
    controller.animateTo(
      targetSize,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DraggableScrollableSheet(
          initialChildSize: widget.isEmpty ? 0.2 : 0.7,
          minChildSize: 0.7,
          maxChildSize: widget.isEmpty ? 0.4 : 1.0,
          expand: true,
          controller: controller,
          builder: (BuildContext context, ScrollController scrollController) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _toggleSheetSize,
                    child: topButtonIndicator(),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Collection',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(
                    color: Colors.grey,
                    height: 1.0,
                    thickness: 0.3,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(bottom: BottomFixedWidget.height),
                        child: widget.isEmpty
                            ? Center(
                          child: Text(
                            'No items available',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        )
                            : widget.child,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget topButtonIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: Wrap(
            children: <Widget>[
              Container(
                width: 60,
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                height: 15,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
