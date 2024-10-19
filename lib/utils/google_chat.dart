import 'package:google_generative_ai/google_generative_ai.dart';

import 'global.dart';

Future<String?> getChat({required String prompt}) async {
  try {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    return response.text;
  } catch (e) {
    return null;
  }
}
