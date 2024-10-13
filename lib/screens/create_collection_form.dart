import 'package:flutter/material.dart';

class CreateCollectionForm extends StatelessWidget {
  final VoidCallback onClose;

  const CreateCollectionForm({Key? key, required this.onClose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _collectionNameController =
        TextEditingController();
    final TextEditingController _collectionDescriptionController =
        TextEditingController();

    return Positioned.fill(
      child: GestureDetector(
        onTap: onClose, // Chiude il form quando si tocca fuori
        child: Container(
          color: Colors.black54, // Sfondo semi-trasparente
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Blocca l'evento onTap per il form
              child: Container(
                width: 350,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    Container(
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
                            controller: _collectionNameController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10), // Angoli arrotondati durante il focus
                                borderSide: BorderSide(
                                  color: Colors.grey.shade600, // Colore del bordo quando è in focus
                                  width: 2.0, // Spessore del bordo durante il focus
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10), // Angoli arrotondati quando è abilitato
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200, // Colore del bordo quando il `TextField` è abilitato ma non in focus
                                  width: 1.5, // Spessore del bordo quando non è in focus
                                ),
                              ),
                              labelStyle: TextStyle(color: Colors.black), // Colore del testo della label
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
                            controller: _collectionDescriptionController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10), // Angoli arrotondati durante il focus
                                borderSide: BorderSide(
                                  color: Colors.grey.shade600, // Colore del bordo quando è in focus
                                  width: 2.0, // Spessore del bordo durante il focus
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10), // Angoli arrotondati quando è abilitato
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200, // Colore del bordo quando il `TextField` è abilitato ma non in focus
                                  width: 1.5, // Spessore del bordo quando non è in focus
                                ),
                              ),
                              labelStyle: TextStyle(color: Colors.black), // Colore del testo della label
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
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: TextButton(
                        onPressed: () {
                          // Add the logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange.shade50,
                          minimumSize: const Size.fromHeight(60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
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
