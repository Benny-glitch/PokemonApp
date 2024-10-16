import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateCollectionForm extends StatelessWidget {
  final VoidCallback onClose;
  final Function(String, String) onSave;

  const CreateCollectionForm({
    super.key,
    required this.onClose,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController collectionNameController = TextEditingController();
    final TextEditingController collectionDescriptionController = TextEditingController();

    void showToast(String message) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    return Positioned.fill(
      child: GestureDetector(
        onTap: onClose,
        child: Container(
          color: Colors.black54,
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 350,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'New Collection',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 1.0,
                      thickness: 0.4,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: collectionNameController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade600,
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 13),
                              Text(
                                "Description (optional)",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: collectionDescriptionController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade600,
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                minLines: 3,
                                maxLines: 5,
                                textAlignVertical: TextAlignVertical.top,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: TextButton(
                        onPressed: () {
                          final String name = collectionNameController.text;
                          final String description = collectionDescriptionController.text;

                          if (name.isEmpty) {
                            showToast("Collection name is required");
                            return;
                          }

                          onSave(name, description);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange.shade50,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Save collection',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
