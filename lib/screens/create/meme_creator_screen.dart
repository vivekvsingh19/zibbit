import 'package:flutter/material.dart';
import 'package:memeapp/core/app_theme.dart';

class MemeCreatorScreen extends StatefulWidget {
  const MemeCreatorScreen({super.key});

  @override
  State<MemeCreatorScreen> createState() => _MemeCreatorScreenState();
}

class _MemeCreatorScreenState extends State<MemeCreatorScreen> {
  String? selectedTemplate;
  String topText = '';
  String bottomText = '';

  // Placeholder meme templates - in real app, these would be fetched from backend
  final List<String> memeTemplates = [
    'Drake Format',
    'Distracted Boyfriend',
    'Think About It',
    'Two Buttons',
    'Change My Mind',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Meme'),
        actions: [
          TextButton(
            onPressed: () => _saveMeme(),
            child: Text('Save', style: TextStyle(color: AppTheme.vibrantGreen)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Meme Preview Area
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: selectedTemplate == null
                    ? const Icon(Icons.add_photo_alternate, size: 64)
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          // Placeholder for actual meme template image
                          Text(
                            selectedTemplate!,
                            style: const TextStyle(fontSize: 20),
                          ),
                          // Top Text
                          Positioned(
                            top: 20,
                            child: Text(
                              topText.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2,
                                    color: Colors.black,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Bottom Text
                          Positioned(
                            bottom: 20,
                            child: Text(
                              bottomText.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2,
                                    color: Colors.black,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Template Selection
            Text(
              'Select Template',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: memeTemplates.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedTemplate = memeTemplates[index];
                        });
                      },
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppTheme.cardBg,
                          borderRadius: BorderRadius.circular(8),
                          border: selectedTemplate == memeTemplates[index]
                              ? Border.all(
                                  color: AppTheme.vibrantBlue,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            memeTemplates[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Text Input Fields
            TextField(
              decoration: const InputDecoration(
                labelText: 'Top Text',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => topText = value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Bottom Text',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => bottomText = value),
            ),
          ],
        ),
      ),
    );
  }

  void _saveMeme() {
    // TODO: Implement meme saving logic
    if (selectedTemplate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a template first')),
      );
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Meme saved to your collection!')),
    );

    // Navigate back
    Navigator.pop(context);
  }
}
