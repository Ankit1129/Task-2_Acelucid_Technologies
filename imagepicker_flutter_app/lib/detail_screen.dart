import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailScreen extends StatefulWidget {
  final String item;

  const DetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Uint8List? _capturedImage;

  // Function to capture an image
  Future<void> _captureImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _capturedImage = bytes;
        });
      } else {
        print('No image captured.');
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the selected item
            Text(
              'You selected: ${widget.item}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Button to capture an image
            ElevatedButton.icon(
              onPressed: _captureImage,
              icon: Icon(Icons.camera),
              label: Text('Capture Image'),
            ),
            SizedBox(height: 20),
            // Display the captured image
            _capturedImage != null
                ? Center(
                    child: Image.memory(
                      _capturedImage!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: Text(
                      'No image captured yet.',
                      style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
