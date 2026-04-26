import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/post_controller.dart';
import '../models/post_model.dart';

class EditPostScreen extends StatefulWidget {
  final PostModel post;

  const EditPostScreen({super.key,required this.post});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final TextEditingController _contentController = TextEditingController();
  final PostController postController = Get.find<PostController>();
  final ImagePicker _picker = ImagePicker();

  File? _newImageFile; // if user picks a new image

  @override
  void initState() {
    super.initState();
    _contentController.text = widget.post.content;
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _newImageFile = File(pickedFile.path);
      });
    }
  }

  void _savePost() {
    final newContent = _contentController.text.trim();
    if (newContent.isEmpty) {
      Get.snackbar('Error', 'Post content cannot be empty',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    // Update content
    widget.post.content = newContent;
    widget.post.updatedAt = DateTime.now();

    // Update image if a new one is selected
    if (_newImageFile != null) {
      widget.post.imageUrls = [ _newImageFile!.path ]; // overwrite with new image
    }

    widget.post.save();
    postController.posts.refresh();
    Get.back();
  }

  void _removeImage() {
    setState(() {
      _newImageFile = null;
      widget.post.imageUrls = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        actions: [
          TextButton(
            onPressed: _savePost,
            child: const Text('Save', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit your post content:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contentController,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What do you want to say?',
              ),
            ),
            const SizedBox(height: 16),

            // IMAGE SECTION
            Row(
              children: [
                if ((_newImageFile != null) || (widget.post.imageUrls != null && widget.post.imageUrls!.isNotEmpty))
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: _newImageFile != null
                                ? FileImage(_newImageFile!)
                                : FileImage(File(widget.post.imageUrls!.first)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _removeImage,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, size: 48, color: Colors.grey),
                  ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Gallery'),
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera'),
                      onPressed: () => _pickImage(ImageSource.camera),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}