import 'package:flutter/material.dart';

void main() {
  runApp(const ParaphraseApp());
}

class ParaphraseApp extends StatelessWidget {
  const ParaphraseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Paraphraser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ParaphraseScreen(),
      },
    );
  }
}

class ParaphraseScreen extends StatefulWidget {
  const ParaphraseScreen({super.key});

  @override
  State<ParaphraseScreen> createState() => _ParaphraseScreenState();
}

class _ParaphraseScreenState extends State<ParaphraseScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _outputText = '';
  bool _isLoading = false;

  // Mock function to simulate paraphrasing
  // In a real app, this would call an API (like OpenAI or Supabase Edge Function)
  Future<void> _performParaphrase() async {
    if (_inputController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      // Simple mock logic for demonstration
      // This just modifies the text slightly to show "change"
      final original = _inputController.text;
      _outputText = "✨ Paraphrased version:\n\n${_reverseWords(original)}"; 
      _isLoading = false;
    });
  }

  // Helper for the mock logic
  String _reverseWords(String input) {
    // Just a dummy transformation: "Hello World" -> "World Hello"
    // Real implementation would use an AI API
    List<String> words = input.split(' ');
    if (words.length > 1) {
      return words.reversed.join(' ');
    }
    return "Rephrased: $input";
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Paraphraser'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter text to rewrite:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Type or paste your text here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _performParaphrase,
              icon: _isLoading 
                  ? const SizedBox(
                      width: 20, 
                      height: 20, 
                      child: CircularProgressIndicator(strokeWidth: 2)
                    ) 
                  : const Icon(Icons.auto_awesome),
              label: Text(_isLoading ? 'Processing...' : 'Paraphrase'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 24),
            if (_outputText.isNotEmpty) ...[
              const Text(
                'Result:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                child: SelectableText(
                  _outputText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
