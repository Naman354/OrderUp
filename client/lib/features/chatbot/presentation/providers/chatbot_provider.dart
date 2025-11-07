import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/message_entity.dart';

class ChatbotNotifier extends StateNotifier<List<MessageEntity>> {
  ChatbotNotifier() : super([]) {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    final welcomeMessage = MessageEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: "Hi! 👋 I'm your food assistant. How can I help you today?",
      isUser: false,
      timestamp: DateTime.now(),
    );
    state = [welcomeMessage];
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    // Add user message
    final userMessage = MessageEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    state = [...state, userMessage];

    // Simulate bot response after a delay
    Future.delayed(const Duration(milliseconds: 800), () {
      final botResponse = _generateBotResponse(text);
      final botMessage = MessageEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: botResponse,
        isUser: false,
        timestamp: DateTime.now(),
      );
      state = [...state, botMessage];
    });
  }

  String _generateBotResponse(String userText) {
    final lowerText = userText.toLowerCase();
    
    if (lowerText.contains('menu') || lowerText.contains('food')) {
      return "We have a variety of delicious dishes! You can check our menu by tapping on the categories above. Would you like recommendations?";
    } else if (lowerText.contains('order')) {
      return "To place an order, simply browse our menu, add items to your cart, and proceed to checkout. Need help with anything specific?";
    } else if (lowerText.contains('delivery')) {
      return "We deliver to Mushin, Lagos and surrounding areas. Delivery typically takes 20-30 minutes. What would you like to order?";
    } else if (lowerText.contains('price') || lowerText.contains('cost')) {
      return "Our menu items range from ₹50 to ₹500. Check out our trending items for the best deals!";
    } else if (lowerText.contains('recommend') || lowerText.contains('suggest')) {
      return "Based on popular choices, I'd recommend our trending items! They're loved by most customers. Want to see them?";
    } else if (lowerText.contains('help')) {
      return "I can help you with:\n• Menu recommendations\n• Order placement\n• Delivery information\n• Payment options\n\nWhat would you like to know?";
    } else {
      return "That's interesting! I'm here to help with menu browsing, orders, and recommendations. What would you like to explore?";
    }
  }

  void clearChat() {
    state = [];
    _addWelcomeMessage();
  }
}

final chatbotProvider = StateNotifierProvider<ChatbotNotifier, List<MessageEntity>>(
  (ref) => ChatbotNotifier(),
);